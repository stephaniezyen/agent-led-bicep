# Bicep 101 Tutorial Agent — Plan

## Context

The Bicep product team wants an interactive Claude Code agent that teaches Bicep to new DevOps engineers (zero IaC experience, PowerShell scripting background). The agent guides learners through a Socratic, hands-on tutorial leveraging the Bicep MCP server for real-time feedback.

## Bicep MCP Server

The Bicep MCP server (bundled with VS Code Bicep extension 0.40.2+) exposes **10 tools**:

| Tool | Purpose |
|------|---------|
| `get_bicep_best_practices` | Returns coding best practices and guidelines |
| `get_az_resource_type_schema` | Schema for a specific resource type + API version |
| `list_az_resource_types_for_provider` | Lists resource types for a provider (e.g., Microsoft.Storage) |
| `list_avm_metadata` | Lists Azure Verified Modules metadata |
| `get_bicep_file_diagnostics` | Analyzes a Bicep file, returns compilation diagnostics |
| `format_bicep_file` | Applies consistent formatting to a Bicep file |
| `get_file_references` | Lists all referenced files/modules/dependencies |
| `get_deployment_snapshot` | Preview resources from a .bicepparam file |
| `decompile_arm_template_file` | Converts ARM JSON → Bicep |
| `decompile_arm_parameters_file` | Converts ARM parameter JSON → .bicepparam |

### MCP Config (`.mcp.json`)

Uses the DLL bundled with the VS Code Bicep extension:

```json
{
  "mcpServers": {
    "Bicep": {
      "command": "dotnet",
      "args": ["C:\\Users\\alfran\\.vscode\\extensions\\ms-azuretools.vscode-bicep-0.40.2\\bicepMcpServer\\Azure.Bicep.McpServer.dll"]
    }
  }
}
```

## File Structure

```
.claude/
  agents/
    bicep-tutor/
      bicep-tutor.md            # Agent definition (core deliverable)
  skills/
    learn-bicep/
      SKILL.md                  # /learn-bicep — tutorial entry point
    bicep-exercise/
      SKILL.md                  # /bicep-exercise — standalone practice
    bicep-quiz/
      SKILL.md                  # /bicep-quiz — knowledge check
.mcp.json                       # Bicep MCP server config (shareable)
exercises/
  01-hello-storage/
    README.md                   # Instructions + hints
  02-parameters-variables/
    README.md
  03-modules-outputs/
    README.md
  04-arm-to-bicep/
    sample.json                 # ARM template for decompile exercise
```

## Agent Design

### Persona
- Patient, encouraging tutor
- Bridges Bicep concepts to PowerShell equivalents (e.g., params → `param()`, modules → functions, outputs → `Write-Output`)
- Plain language, avoids jargon unless defining it

### Pedagogy — Socratic Method
- **Never dump a complete solution.** Ask guiding questions; let the learner write the code.
- Give progressively specific hints when stuck, not answers.
- Validate often with `get_bicep_file_diagnostics` — treat errors as teaching moments.
- Use MCP tools as *teaching aids* and explain why each tool is being invoked.

### MCP Tool Usage Map

| Module | Tools Used |
|--------|-----------|
| 1 — Hello Storage | `get_bicep_best_practices`, `get_az_resource_type_schema`, `get_bicep_file_diagnostics` |
| 2 — Params & Variables | `get_bicep_file_diagnostics`, `format_bicep_file` |
| 3 — Modules & Outputs | `list_avm_metadata`, `get_file_references`, `get_deployment_snapshot` |
| 4 — ARM → Bicep | `decompile_arm_template_file`, `decompile_arm_parameters_file`, `get_bicep_file_diagnostics`, `format_bicep_file` |

## Curriculum — 4 Interactive Modules

### Module 1: Hello Storage Account
**Goal**: Write a first Bicep file defining a storage account.

- **Concepts**: What is IaC? What is Bicep? Resource blocks, types, API versions.
- **PowerShell bridge**: "A script that declares *what* you want, not *how* — like a recipe vs. cooking instructions."
- **Exercise**: Create `main.bicep` with a storage account. Agent validates with diagnostics after each attempt.

### Module 2: Parameters, Variables & Conditions
**Goal**: Make the template flexible.

- **Concepts**: `param`, `var`, decorators (`@allowed`, `@description`), string interpolation, ternary operator, default values.
- **PowerShell bridge**: Bicep `param` → PowerShell `[Parameter()]` attributes; decorators → `[ValidateSet()]`.
- **Exercise**: Extract hardcoded values into parameters, add a computed name with `uniqueString()`, add conditional tags.

### Module 3: Modules & Outputs
**Goal**: Compose reusable infrastructure.

- **Concepts**: `output` keyword, modules (referencing other .bicep files), Azure Verified Modules (AVM).
- **PowerShell bridge**: Modules → PowerShell functions that return objects.
- **Exercise**: Refactor storage into a module, create a main.bicep that calls it, explore AVM catalog.

### Module 4: ARM → Bicep Migration
**Goal**: Convert existing ARM templates to Bicep.

- **Concepts**: Why migrate? Decompilation workflow, cleanup, best practices.
- **Exercise**: Decompile `sample.json`, compare ARM vs Bicep side-by-side, clean up and apply best practices.

## Slash Commands

| Command | Purpose |
|---------|---------|
| `/learn-bicep` | Entry point. Welcomes learner, assesses background, starts Module 1. Can resume from where they left off. |
| `/bicep-exercise` | Standalone practice. Agent picks a topic or learner requests one. |
| `/bicep-quiz` | 5–10 Socratic questions across the curriculum. Agent asks, learner answers, agent explains. |

## Implementation Order

1. `.mcp.json` — MCP server config
2. `bicep-tutor.md` — Agent definition (the core deliverable)
3. `/learn-bicep` skill — Entry point slash command
4. Exercise files — Starter content for each module
5. `/bicep-exercise` and `/bicep-quiz` skills — Supplementary commands

## Verification

1. Run `claude` in the repo — confirm Bicep MCP server connects (`/mcp`)
2. `/learn-bicep` — tutorial starts, asks background questions, begins Module 1
3. Follow Module 1 — agent uses `get_az_resource_type_schema` and `get_bicep_file_diagnostics` interactively
4. Write intentionally broken Bicep — agent catches errors via diagnostics and guides the fix
5. `/bicep-quiz` — quiz mode works independently
