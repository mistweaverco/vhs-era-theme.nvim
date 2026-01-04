import tailwindcss from '@tailwindcss/vite';
import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig } from 'vite';

export default defineConfig({
  plugins: [sveltekit(), tailwindcss()],
  build: {
    rollupOptions: {
      output: {
        manualChunks: (id) => {
          if (id.includes('@fortawesome')) {
            return 'fontawesome';
          }
          if (id.includes('node_modules')) {
            if (id.includes('svelte') || id.includes('@sveltejs')) {
              return 'svelte-vendor';
            }
            if (id.includes('tailwind') || id.includes('daisyui')) {
              return 'tailwind-vendor';
            }
            return 'vendor';
          }
        }
      }
    }
  }
});
