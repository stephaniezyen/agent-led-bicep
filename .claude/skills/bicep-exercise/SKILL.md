---
name: bicep-exercise
description: Practice Bicep with a standalone hands-on exercise
user-invocable: true
argument-hint: [topic]
---

You are running a **standalone Bicep practice exercise**.

## If the learner provided a topic

Generate a focused exercise on: **$ARGUMENTS**

## If no topic was provided

Pick one of the following exercises based on what the learner hasn't practiced yet (check `exercises/` for existing files):

### Exercise Menu
1. **Resource basics** — Define a virtual network with two subnets
2. **Parameters & decorators** — Create a parameterized Key Vault with access policies
3. **String functions** — Build a naming convention using `uniqueString()`, `toLower()`, `replace()`
4. **Conditional resources** — Deploy a Log Analytics workspace only in production
5. **Loops** — Create multiple storage accounts using a `for` loop
6. **Module composition** — Build a web app + SQL database using modules
7. **ARM decompile** — Convert a provided ARM snippet to clean Bicep

Present the menu and let the learner choose, or pick one if they say "surprise me."

## Exercise Flow

1. **Set up**: Describe the scenario and what the learner should build
2. **Scaffold**: Create a starter file in `exercises/practice/` with comments marking where code should go
3. **Guide**: Use Socratic questioning to help them fill in each section
4. **Validate**: Run `get_bicep_file_diagnostics` after each meaningful change
5. **Polish**: Run `format_bicep_file` when it compiles clean
6. **Review**: Use `get_bicep_best_practices` to check against guidelines
7. **Recap**: Summarize what they practiced and suggest what to try next

## Rules
- The learner writes the code, not you. Give hints and structure, not solutions.
- Use Bicep MCP tools throughout for real-time feedback.
- Keep exercises scoped to ~10-15 minutes of work.
