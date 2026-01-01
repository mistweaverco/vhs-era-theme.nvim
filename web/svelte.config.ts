import { vitePreprocess } from '@sveltejs/vite-plugin-svelte';
import tailwindcss from '@tailwindcss/vite';
import type { Config } from '@sveltejs/kit';
import adapter from '@sveltejs/adapter-static';

const config: Config = {
  kit: {
    prerender: {
      handleMissingId: 'ignore'
    },
    adapter: adapter({
      precompress: true
    })
  },
  extensions: ['.svelte'],
  plugins: [tailwindcss()],
  preprocess: [
    vitePreprocess({
      script: true
    })
  ]
};

export default config;
