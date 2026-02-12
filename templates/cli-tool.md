# [CLI_NAME]

[One sentence: what this CLI does]

## Stack

- [LANGUAGE] (Node.js / Python / Rust / Go)
- [CLI_FRAMEWORK] (Commander / Yargs / Click / Clap)
- TypeScript/Type hints for type safety

## Installation

```bash
# Development
npm link  # or pip install -e .

# Global install (published)
npm install -g [cli-name]
```

## Commands

```bash
npm run dev      # Run with ts-node/nodemon
npm run build    # Compile for distribution
npm run test     # Run tests
npm run lint     # Lint code
```

## Usage

```bash
# Basic usage
[cli-name] [command] [options]

# Examples
[cli-name] init                    # Initialize config
[cli-name] run --input file.txt    # Run with input
[cli-name] --help                  # Show help
[cli-name] --version               # Show version
```

## Structure

```
src/
├── commands/           # Command handlers
│   ├── init.ts
│   ├── run.ts
│   └── index.ts
├── lib/
│   ├── config.ts       # Config loading
│   ├── output.ts       # Console output helpers
│   └── errors.ts       # Error handling
├── utils/              # Utilities
├── types.ts            # Type definitions
└── index.ts            # Entry point + CLI setup
```

## Command Pattern

```typescript
// commands/run.ts
import { Command } from 'commander'

export const runCommand = new Command('run')
  .description('Run the main process')
  .option('-i, --input <file>', 'Input file path')
  .option('-o, --output <file>', 'Output file path')
  .option('-v, --verbose', 'Verbose output')
  .action(async (options) => {
    // implementation
  })
```

## Conventions

### Output
- Use colors sparingly (chalk/picocolors)
- Prefix errors with ❌, warnings with ⚠️, success with ✅
- Support `--quiet` and `--verbose` flags
- Respect `NO_COLOR` environment variable

```typescript
// lib/output.ts
export const log = {
  info: (msg: string) => console.log(msg),
  success: (msg: string) => console.log(chalk.green('✅ ' + msg)),
  warn: (msg: string) => console.error(chalk.yellow('⚠️  ' + msg)),
  error: (msg: string) => console.error(chalk.red('❌ ' + msg)),
}
```

### Config
- Look for config in: `./.[cli-name]rc`, `./[cli-name].config.js`, `package.json`
- Support environment variables for overrides
- Merge configs sensibly (local > user > default)

### Exit Codes
- `0` — success
- `1` — general error
- `2` — invalid usage

### File Handling
- Use streams for large files
- Handle stdin/stdout for piping
- Create files atomically (write to temp, then move)

## Do NOT

- Use synchronous operations for I/O
- Print to stdout unless it's actual output (use stderr for logs)
- Require global config that could be local
- Exit silently on errors
- Use hardcoded paths

## Interactive Prompts

```typescript
import { confirm, input, select } from '@inquirer/prompts'

const name = await input({ message: 'Project name:' })
const framework = await select({
  message: 'Framework:',
  choices: [
    { name: 'Next.js', value: 'nextjs' },
    { name: 'Vite', value: 'vite' },
  ]
})
```

## Progress Indicators

```typescript
import ora from 'ora'

const spinner = ora('Processing...').start()
// do work
spinner.succeed('Done!')
```

## Testing

- Test commands with fixtures
- Mock file system operations
- Test help output and arg parsing

```typescript
// __tests__/run.test.ts
it('runs with valid input', async () => {
  const result = await runCommand(['--input', 'test.txt'])
  expect(result.exitCode).toBe(0)
})
```

## Publishing

```bash
npm version patch
npm publish
```

---

*Last updated: [DATE]*
