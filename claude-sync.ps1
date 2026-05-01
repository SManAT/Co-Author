# =============================================================================
#
#   CLAUDE CODE HISTORY SYNC SCRIPT (PowerShell)
#   ---------------------------------------------
#   Sync your Claude Code conversations across machines using Git + GitHub PAT.
#
#   HOW TO USE:
#   -----------
#   .\claude-sync.ps1 pull   - Download latest history from GitHub
#   .\claude-sync.ps1 push   - Upload your history to GitHub
#   .\claude-sync.ps1 status - Show sync status and machine list
#
#   FIRST TIME SETUP:
#   -----------------
#   1. Create a GitHub PAT: GitHub > Settings > Developer settings >
#      Personal access tokens > Tokens (classic) > Generate new token
#      Required scope: repo (full control)
#   2. Edit the CONFIGURATION section below (PAT, USERNAME, REPO_NAME, MACHINE)
#   3. Run: .\claude-sync.ps1 pull
#
#   NOTE: If PowerShell blocks execution, run once as admin:
#         Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
#
# =============================================================================

param(
    [string]$Command = ""
)

# =============================================================================
# CONFIGURATION - You MUST edit these values!
# =============================================================================

# Your GitHub Personal Access Token (PAT)
# Create at: https://github.com/settings/tokens
$PAT = "github_pat_XXXXXX"

# Your GitHub username
$USERNAME = "SManAT"

# Your GitHub repository name (must already exist on GitHub)
$REPO_NAME = "claude-history"

# A unique name for THIS machine
$MACHINE = "Christina-Home"


# =============================================================================
# ADVANCED CONFIGURATION - Usually no need to change these
# =============================================================================

# Where the sync repository will be cloned to
$REPO = "$env:USERPROFILE\claude-history-sync"

# Where Claude Code stores your conversation history
$CLAUDE_PROJECTS = "$env:USERPROFILE\.claude\projects"


# =============================================================================
# SCRIPT CODE - No need to edit anything below this line
# =============================================================================

# Authenticated URL embeds the PAT — never printed to screen
$AUTH_URL    = "https://$PAT@github.com/$USERNAME/$REPO_NAME.git"
# Safe URL for display (no token)
$DISPLAY_URL = "https://github.com/$USERNAME/$REPO_NAME"

function Write-Green  { param($msg) Write-Host $msg -ForegroundColor Green }
function Write-Yellow { param($msg) Write-Host $msg -ForegroundColor Yellow }
function Write-Red    { param($msg) Write-Host $msg -ForegroundColor Red }

# Clone the repository if this is the first time running the script
if (-not (Test-Path $REPO)) {
    Write-Yellow "First time setup: Cloning repository..."
    git clone $AUTH_URL $REPO
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Red "ERROR: Failed to clone repository."
        Write-Host ""
        Write-Host "Common causes:"
        Write-Host "  1. PAT is incorrect or expired - check GitHub > Settings > Developer settings"
        Write-Host "  2. PAT is missing the 'repo' scope"
        Write-Host "  3. USERNAME or REPO_NAME is wrong"
        Write-Host "  4. Repository doesn't exist - create it on GitHub first"
        Write-Host ""
        exit 1
    }

    # Store credentials so subsequent git commands inside $REPO work without re-embedding the PAT
    git -C $REPO remote set-url origin $AUTH_URL
    Write-Host ""
}

switch ($Command.ToLower()) {

    # -------------------------------------------------------------------------
    # PUSH - Upload your local history to GitHub
    # -------------------------------------------------------------------------
    "push" {
        Write-Yellow "Pushing Claude history from $MACHINE..."
        Write-Host ""

        if (-not (Test-Path $CLAUDE_PROJECTS)) {
            Write-Red "ERROR: Claude projects directory not found."
            Write-Host ""
            Write-Host "Location checked: $CLAUDE_PROJECTS"
            Write-Host ""
            Write-Host "This means either:"
            Write-Host "  1. Claude Code is not installed"
            Write-Host "  2. You haven't had any conversations yet"
            Write-Host ""
            Write-Host "Use Claude Code at least once, then try again."
            exit 1
        }

        $dest = Join-Path $REPO $MACHINE
        New-Item -ItemType Directory -Force -Path $dest | Out-Null
        Copy-Item -Path "$CLAUDE_PROJECTS\*" -Destination $dest -Recurse -Force -ErrorAction SilentlyContinue

        # Ensure the authenticated remote URL is current (PAT may have changed)
        git -C $REPO remote set-url origin $AUTH_URL
        git -C $REPO add .

        git -C $REPO diff --staged --quiet
        if ($LASTEXITCODE -eq 0) {
            Write-Yellow "No new changes to sync."
            Write-Host "Your history is already up to date."
        } else {
            $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            git -C $REPO commit -m "$MACHINE sync $timestamp"
            git -C $REPO push
            Write-Host ""
            Write-Green "Successfully pushed from $MACHINE!"
            Write-Host "Your history is now saved to GitHub."
        }
    }

    # -------------------------------------------------------------------------
    # PULL - Download the latest history from GitHub
    # -------------------------------------------------------------------------
    "pull" {
        Write-Yellow "Pulling latest history from GitHub..."
        Write-Host ""

        git -C $REPO remote set-url origin $AUTH_URL
        git -C $REPO pull

        Write-Host "Available machines with synced history:"

        Get-ChildItem -Path $REPO -Directory |
            Where-Object { $_.Name -notmatch '^\.' } |
            ForEach-Object { Write-Host "  - $($_.Name)" }

        # Copy history from ALL machines into Claude's projects directory
        $machineDirs = Get-ChildItem -Path $REPO -Directory | Where-Object { $_.Name -notmatch '^\.' }
        if ($machineDirs) {
            New-Item -ItemType Directory -Force -Path $CLAUDE_PROJECTS | Out-Null
            foreach ($dir in $machineDirs) {
                Copy-Item -Path "$($dir.FullName)\*" -Destination $CLAUDE_PROJECTS -Recurse -Force -ErrorAction SilentlyContinue
            }
            $bytes = (Get-ChildItem -Path $CLAUDE_PROJECTS -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
            $sizeStr = if ($bytes -ge 1GB) { "{0:N2} GB" -f ($bytes / 1GB) }
                       elseif ($bytes -ge 1MB) { "{0:N2} MB" -f ($bytes / 1MB) }
                       else { "{0:N0} KB" -f ($bytes / 1KB) }
            Write-Host ""
            Write-Green "History from all machines restored to Claude projects directory."
            Write-Host "Projects folder size: $sizeStr"
        } else {
            Write-Host ""
            Write-Yellow "No history found in the repository yet."
            Write-Host "Run '.\claude-sync.ps1 push' from any machine first."
        }
    }

    # -------------------------------------------------------------------------
    # STATUS - Show current sync status
    # -------------------------------------------------------------------------
    "status" {
        Write-Yellow "Sync Status"
        Write-Host "==========="
        Write-Host ""

        Write-Host "Repository: $REPO"
        Write-Host "Remote URL: $DISPLAY_URL"   # safe — no PAT
        Write-Host "This machine: $MACHINE"
        Write-Host ""

        git -C $REPO diff --quiet
        $diffClean = $LASTEXITCODE -eq 0
        git -C $REPO diff --staged --quiet
        $stagedClean = $LASTEXITCODE -eq 0

        if ($diffClean -and $stagedClean) {
            Write-Green "Status: All synced!"
        } else {
            Write-Yellow "Status: You have unsynced changes. Run 'push' to sync."
        }
        Write-Host ""

        Write-Host "Machines with synced history:"
        Write-Host ""

        Get-ChildItem -Path $REPO -Directory |
            Where-Object { $_.Name -notmatch '^\.' } |
            ForEach-Object {
                $count = (Get-ChildItem -Path $_.FullName -Filter "*.jsonl" -Recurse -ErrorAction SilentlyContinue).Count
                Write-Host "  - $($_.Name): $count conversation file(s)"
            }

        Write-Host ""
    }

    # -------------------------------------------------------------------------
    # HELP - Show usage when no command or invalid command given
    # -------------------------------------------------------------------------
    default {
        Write-Host ""
        Write-Host "  Claude Code History Sync"
        Write-Host "  ========================"
        Write-Host ""
        Write-Host "  Usage: .\claude-sync.ps1 [command]"
        Write-Host ""
        Write-Host "  Commands:"
        Write-Host "    pull     Download latest history from GitHub"
        Write-Host "    push     Upload this machine's history to GitHub"
        Write-Host "    status   Show sync status and machine info"
        Write-Host ""
        Write-Host "  Examples:"
        Write-Host "    .\claude-sync.ps1 pull    # Run this when you start working"
        Write-Host "    .\claude-sync.ps1 push    # Run this when you're done"
        Write-Host ""
        Write-Host "  Configuration:"
        Write-Host "    Current machine name: $MACHINE"
        Write-Host "    Repository URL: $DISPLAY_URL"
        Write-Host ""
    }
}
