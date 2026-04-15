# Token Flow — How CodeDNA Stays Within Budget

```mermaid
graph TD
  A["User Prompt"] --> B["Task Planner\n~4k tokens"]
  B --> C["Context Assembler"]
  C --> D["Project DNA Identity\n~300 tokens (FIXED)"]
  C --> E["Task Description\n~100 tokens (FIXED)"]
  C --> F["Target File Contents\n~28000 tokens max"]
  C --> G["Module Context Cards\n~28000 tokens max"]
  D & E & F & G --> H["LLM Prompt\n≤64,000 tokens total"]
  H --> I["LLM Response\n≤8,000 output tokens"]
  I --> J["File Block Parser"]
  J --> K["Quality Gates"]
  K --> L["Write Files to Disk"]
  L --> M["Update Context Cards"]
  M --> N["Git Commit + Checkpoint"]
```

## Token Budget: gemini/gemini/gemini-2.5-flash-lite

| Budget Item | Tokens |
|-------------|--------|
| Context window | 64,000 |
| Output reserve per task | 8,000 |
| Input budget per task | 56,000 |
| DNA identity block | ~300 (never dropped) |
| Task description | ~100 (never dropped) |
| Per module context card | ~200 |
| Max modules in context | ~240 |
