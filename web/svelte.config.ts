import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';
import tailwindcss from '@tailwindcss/vite';
import type { Config } from '@sveltejs/kit';
import adapter from '@sveltejs/adapter-static';
import { mdsvex } from 'mdsvex';
import mdsvexShiki from '@mistweaverco/mdsvex-shiki';

const config: Config = {
  kit: {
    adapter: adapter({
      precompress: true
    })
  },
  extensions: ['.svelte'],
  plugins: [tailwindcss()],
  preprocess: [
    vitePreprocess({
      script: true
    }),
    mdsvex({
      highlight: {
        highlighter: await mdsvexShiki({})
      }
    })
  ]
};

export default config;
