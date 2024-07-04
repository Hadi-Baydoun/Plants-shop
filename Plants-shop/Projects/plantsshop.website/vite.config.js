import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import viteCompression from 'vite-plugin-compression';
import { visualizer } from 'rollup-plugin-visualizer';

export default defineConfig({
    plugins: [
        react(),
        viteCompression({
            verbose: true,
            disable: false,
            threshold: 10240,
            algorithm: 'brotliCompress',
            ext: '.br',
        }),
        viteCompression({
            verbose: true,
            disable: false,
            threshold: 10240,
            algorithm: 'gzip',
            ext: '.gz',
        }),
        visualizer({
            filename: './dist/stats.html',
        }),
    ],
    optimizeDeps: {
        include: ['react', 'react-dom', '@mui/material', 'react-router-dom'],
    },
    build: {
        sourcemap: true,
        minify: 'terser',  // Ensure minify is set to 'terser'
        terserOptions: {
            compress: {
                drop_console: true,  // Example option to drop console logs
            },
        },
    },
});
