# Full Cross-Platform `stream-write.md` Skill

Here's the complete skill file:

```markdown
# Real-time Streaming Write Mode (Cross-Platform)

## CRITICAL: Default Behavior for ALL File Writes

When writing or modifying ANY file, ALWAYS use incremental streaming writes. This allows external tools (Obsidian, VS Code, tail, etc.) to display changes in real-time as content is being written.

**This is the DEFAULT behavior. No user instruction required.**

---

## Core Rules

1. **NEVER** write entire file content in a single operation
2. **ALWAYS** initialize/clear the file first, then append in chunks
3. **CHUNK SIZE**: Write in logical sections (headings + content, paragraphs, code blocks, tables)
4. **APPLIES TO**: All files, especially `.md`, `.txt`, `.json`, `.yaml`, `.xml`, documentation, configs
5. **AUTOMATIC**: Apply this pattern without being asked

---

## Platform Detection

Detect the user's shell/platform from context:
- `$env:` variables, `Get-Content`, `.ps1` → **PowerShell**
- `C:\`, `\Users\` paths → **Windows (PowerShell or CMD)**
- `~/`, `/home/`, `/usr/` paths → **Linux/macOS (Bash/Zsh)**
- WSL environment → **Bash on Windows**

---

## PowerShell Pattern (Windows)

### Creating/Overwriting a File

```powershell
# Step 1: Initialize empty file
"" | Set-Content -Path "filename.md" -Encoding utf8 -NoNewline

# Step 2: Append content in logical chunks
@"
# Document Title
"@ | Add-Content -Path "filename.md" -Encoding utf8

@"

## Introduction

This is the introductory paragraph explaining the purpose
of this document. It can span multiple lines.
"@ | Add-Content -Path "filename.md" -Encoding utf8

@"

## Section One

Content for section one goes here. Each major section
is written as a separate append operation.
"@ | Add-Content -Path "filename.md" -Encoding utf8

@"

### Subsection 1.1

More detailed content with a code example:
"@ | Add-Content -Path "filename.md" -Encoding utf8

@"

``````powershell
# Code blocks are their own chunk
Get-Process | Where-Object { `$_.CPU -gt 100 }
``````
"@ | Add-Content -Path "filename.md" -Encoding utf8

@"

## Section Two

| Column A | Column B | Column C |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
"@ | Add-Content -Path "filename.md" -Encoding utf8

# Continue appending until complete...
```

### Single Line Appends (for short additions)

```powershell
"Single line of content" | Add-Content -Path "filename.md" -Encoding utf8
"" | Add-Content -Path "filename.md" -Encoding utf8  # Empty line
```

### PowerShell Notes

- Always use `-Encoding utf8` for consistency
- Use `@" ... "@` (here-strings) for multi-line chunks
- Variables inside here-strings need backtick escape: `` `$variable ``
- `-NoNewline` on `Set-Content` prevents extra blank line at start

---

## Bash/Zsh Pattern (Linux/macOS/WSL)

### Creating/Overwriting a File

```bash
# Step 1: Initialize empty file
> "filename.md"

# Step 2: Append content in logical chunks using heredocs
cat << 'EOF' >> "filename.md"
# Document Title
EOF

cat << 'EOF' >> "filename.md"

## Introduction

This is the introductory paragraph explaining the purpose
of this document. It can span multiple lines.
EOF

cat << 'EOF' >> "filename.md"

## Section One

Content for section one goes here. Each major section
is written as a separate append operation.
EOF

cat << 'EOF' >> "filename.md"

### Subsection 1.1

More detailed content with a code example:
EOF

cat << 'EOF' >> "filename.md"

```bash
# Code blocks are their own chunk
ps aux | grep -v grep | awk '{print $1, $2, $11}'
```
EOF

cat << 'EOF' >> "filename.md"

## Section Two

| Column A | Column B | Column C |
|----------|----------|----------|
| Data 1   | Data 2   | Data 3   |
| Data 4   | Data 5   | Data 6   |
EOF

# Continue appending until complete...
```

### Single Line Appends (for short additions)

```bash
echo "Single line of content" >> "filename.md"
echo "" >> "filename.md"  # Empty line
```

### Bash/Zsh Notes

- Use `'EOF'` (quoted) to prevent variable expansion in heredocs
- Use `EOF` (unquoted) if you need variable expansion
- `>` overwrites/creates, `>>` appends
- Wrap filenames in quotes for paths with spaces

---

## Chunking Guidelines

### What Constitutes a Chunk

| Content Type | Chunking Strategy |
|--------------|-------------------|
| Heading + short content | Together as 1 chunk |
| Heading + long content | Heading separate, then paragraphs |
| Paragraph | 1 chunk per paragraph |
| Code block | 1 chunk (keep complete) |
| Table | 1 chunk (keep complete) |
| List (short) | 1 chunk |
| List (long) | Split into logical groups |
| Frontmatter/YAML | 1 chunk |

### Chunk Size Balance

- **Too small** (single lines): Slow, excessive operations
- **Too large** (entire sections): Defeats real-time purpose
- **Just right**: 5-30 lines per chunk, or logical content units

---

## Editing Existing Files

When making significant edits to an existing file:

### Option A: Full Rewrite with Streaming (Preferred for major changes)

```powershell
# PowerShell
$content = Get-Content -Path "filename.md" -Raw
# Modify $content as needed, then:
"" | Set-Content -Path "filename.md" -Encoding utf8 -NoNewline
# Stream the new/modified content in chunks...
```

```bash
# Bash
content=$(cat "filename.md")
# Modify content as needed, then:
> "filename.md"
# Stream the new/modified content in chunks...
```

### Option B: Append Only (for additions)

Simply append new content to the end using the patterns above.

---

## File Types - Always Apply Streaming

- ✅ `.md` - Markdown (Obsidian, Typora, etc.)
- ✅ `.txt` - Plain text
- ✅ `.json` - JSON (write pretty-printed in chunks)
- ✅ `.yaml` / `.yml` - YAML configs
- ✅ `.xml` - XML documents
- ✅ `.html` - HTML files
- ✅ `.css` - Stylesheets
- ✅ `.js` / `.ts` - JavaScript/TypeScript
- ✅ `.py` - Python
- ✅ `.sh` / `.ps1` - Shell scripts
- ✅ `.env` - Environment files
- ✅ `.gitignore`, `.dockerignore` - Ignore files
- ✅ `README`, `LICENSE`, `CHANGELOG` - Documentation
- ✅ Any file where user may be watching changes

---

## Examples by Scenario

### Scenario: Writing a README.md

```powershell
# PowerShell
"" | Set-Content -Path "README.md" -Encoding utf8 -NoNewline

@"
# Project Name

Short project description here.
"@ | Add-Content -Path "README.md" -Encoding utf8

@"

## Installation

``````bash
npm install my-package
``````
"@ | Add-Content -Path "README.md" -Encoding utf8

@"

## Usage

``````javascript
const pkg = require('my-package');
pkg.doSomething();
``````
"@ | Add-Content -Path "README.md" -Encoding utf8

@"

## License

MIT
"@ | Add-Content -Path "README.md" -Encoding utf8
```

### Scenario: Writing a Config File

```bash
# Bash
> "config.yaml"

cat << 'EOF' >> "config.yaml"
# Application Configuration
app:
  name: MyApp
  version: 1.0.0
EOF

cat << 'EOF' >> "config.yaml"

# Database Settings
database:
  host: localhost
  port: 5432
  name: myapp_db
EOF

cat << 'EOF' >> "config.yaml"

# Feature Flags
features:
  dark_mode: true
  beta_features: false
EOF
```

---

## Summary

| Step | PowerShell | Bash/Zsh |
|------|------------|----------|
| **1. Init file** | `"" \| Set-Content -Path "f.md" -Encoding utf8 -NoNewline` | `> "f.md"` |
| **2. Append chunk** | `@"..."@ \| Add-Content -Path "f.md" -Encoding utf8` | `cat << 'EOF' >> "f.md" ... EOF` |
| **3. Single line** | `"text" \| Add-Content -Path "f.md"` | `echo "text" >> "f.md"` |
| **4. Repeat** | Continue appending chunks until done | Continue appending chunks until done |

---

## Remember

> **This streaming write pattern is the DEFAULT behavior.**
> 
> Apply it automatically to every file write operation.
> 
> The user should see content appearing progressively in their editor/viewer (Obsidian, VS Code, tail -f, etc.) without needing to request it.
```
