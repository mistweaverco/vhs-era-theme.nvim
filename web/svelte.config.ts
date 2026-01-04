import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';
import tailwindcss from '@tailwindcss/vite';
import type { Config } from '@sveltejs/kit';
import adapter from '@sveltejs/adapter-static';
import { mdsvex } from 'mdsvex';
import type { PreprocessorGroup } from 'svelte/compiler';

const mdsvexConfig = mdsvex({
  extension: '.md'
}) as PreprocessorGroup;

const config: Config = {
  kit: {
    prerender: {
      handleMissingId: 'ignore'
    },
    adapter: adapter({
      precompress: true
    })
  },
  extensions: ['.svelte', '.md'],
  plugins: [tailwindcss()],
  preprocess: [
    vitePreprocess({
      script: true
    }),
    mdsvexConfig
  ]
};

export default config;
