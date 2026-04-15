# Bicep 101 — Learn Azure Bicep with an AI Tutor

An interactive, agent-led tutorial that teaches you [Azure Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/overview?tabs=bicep) from scratch. Instead of reading docs, you learn by writing real infrastructure code with an AI tutor that guides you step by step.

## Who is this for?

- **New to Infrastructure as Code** — no Bicep, ARM, or Terraform experience needed
- **Comfortable with Azure** — you know what resource groups, storage accounts, and subscriptions are
- **PowerShell background** — the tutor maps Bicep concepts to PowerShell equivalents you already know

## What you'll learn

| Module | Topic | What you'll build |
|--------|-------|-------------------|
| 1 | Hello Storage Account | Your first Bicep resource |
| 2 | Parameters, Variables & Conditions | Flexible, reusable templates |
| 3 | Modules & Outputs | Composable infrastructure (like PowerShell functions) |
| 4 *(optional)* | ARM → Bicep Migration | Convert existing ARM templates to Bicep |
| 5 | Deployment Stacks | Deploy and manage resources as a tracked unit |

> **Module path**: All learners follow Module 1 → 2 → 3 → 5. Module 4 is only included if you have prior ARM template experience.

## Getting started

### Prerequisites

- An AI coding assistant that supports MCP servers — either:
  - [GitHub Copilot CLI](https://docs.github.com/copilot/concepts/agents/about-copilot-cli) (`copilot`)
  - [Claude Code](https://docs.anthropic.com/en/docs/build-with-claude/claude-code/overview) (`claude`)
- [.NET SDK](https://dotnet.microsoft.com/download) (for the Bicep MCP server)

### 1. Clone the repo

```bash
git clone https://github.com/your-org/agent-led-bicep.git
cd agent-led-bicep
```

### 2. Launch your AI assistant

```bash
copilot
```
or
```bash
claude
```

The Bicep MCP server is pre-configured in `.mcp.json` — it provides real-time compilation, diagnostics, schema lookup, and more. Your assistant will connect to it automatically.

### 3. Start learning

Type the following to begin the tutorial:

```
/learn-bicep
```

The tutor will check your progress, ask a few background questions, and start you on Module 1. You can also jump to a specific module:

```
/learn-bicep 3
```

### Other commands

| Command | What it does |
|---------|--------------|
| `/learn-bicep` | Start or resume the full tutorial |
| `/bicep-exercise` | Standalone practice on a specific topic |
| `/bicep-quiz` | Quick knowledge check (8 questions) |

## How it works

The AI tutor uses the [Bicep MCP server](https://github.com/Azure/bicep) to give you real-time feedback as you write code:

- **`get_bicep_best_practices`** — grounds guidance in official best practices at the start of each module
- **`get_bicep_file_diagnostics`** — checks your code for errors after each change
- **`get_az_resource_type_schema`** — looks up resource properties so you can explore what's available
- **`list_az_resource_types_for_provider`** — lists resource types available for a given provider
- **`format_bicep_file`** — formats your code to Bicep conventions
- **`list_avm_metadata`** — shows available Azure Verified Modules (Module 3)
- **`get_file_references`** — visualizes module dependencies (Module 3)
- **`get_deployment_snapshot`** — previews what your code would deploy before running it
- **`decompile_arm_template_file`** — converts ARM JSON to Bicep (Module 4, optional)
- **`decompile_arm_parameters_file`** — converts ARM parameter files alongside templates (Module 4, optional)

The tutor guides you to write the code yourself — it won't hand you complete solutions.

## Project structure

```
AGENTS.md                          # Tutor persona (loaded by Copilot CLI)
.mcp.json                          # Bicep MCP server configuration
exercises/
  main.bicep                       # Your working file (evolves through modules)
.claude/
  agents/bicep-tutor/              # Tutor persona (loaded by Claude Code)
  skills/
    learn-bicep/                   # /learn-bicep command
    bicep-exercise/                # /bicep-exercise command
    bicep-quiz/                    # /bicep-quiz command
plans/
  plan.md                          # Original project plan
  enhancements-plan.md             # Future curriculum ideas
```

## Contributing

See `plans/enhancements-plan.md` for curriculum ideas being considered — including loops, user-defined types, and the Bicep test framework.
