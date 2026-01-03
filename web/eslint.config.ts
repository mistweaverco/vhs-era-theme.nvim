import prettier from 'eslint-config-prettier';
import svelte from 'eslint-plugin-svelte';

import globals from 'globals';
import js from '@eslint/js';
import ts from 'typescript-eslint';

export default ts.config(
  js.configs.recommended,
  ...ts.configs.recommended,
  prettier,
  ...svelte.configs['flat/prettier'],
  {
    languageOptions: {
      globals: {
        ...globals.browser,
        ...globals.node
      }
    }
  },
  {
    files: ['**/*.svelte'],
    languageOptions: {
      parserOptions: {
        parser: ts.parser
      }
    }
  },
  {
    files: ['README.md', 'vite.config.ts', 'vitest.config.ts', 'eslint.config.ts', 'svelte.config.ts', 'tsconfig.json'],
    ignores: ['node_modules/**', 'build/**', '.svelte-kit/**']
  }
);
