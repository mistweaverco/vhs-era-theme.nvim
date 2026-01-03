import fs from 'fs';
import { globSync } from 'glob';
import YAML from 'yaml';
import { render } from 'svelte/server';

import type { Component } from 'svelte';

export interface ScreenshotMarkdownDataMetadata {
  title: string;
  url: string;
}

export interface ScreenshotMarkdownData {
  path: string;
  metadata: ScreenshotMarkdownDataMetadata;
  content: string;
}

interface ScreenshotModule {
  default: {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any, @typescript-eslint/no-empty-object-type
    component: Component<any, {}, string>;
  };
  metadata: ScreenshotMarkdownDataMetadata;
}

// screenshots/languages-or-plugins/name/screenshot-001.md
const ALL_SCREENSHOT_FILES = import.meta.glob<ScreenshotModule>('/src/data/screenshots/*/*/*.md');

/**
 * Fetch all screenshots markdown definition files
 * @returns A promise that resolves to an array of ScreenshotMarkdownData
 */
export const getAllScreenshotsByPathPrefix = async (pathPrefix: string): Promise<ScreenshotMarkdownData[]> => {
  const iterableScreenshotFiles = Object.entries(ALL_SCREENSHOT_FILES);
  const allScreenshots = await Promise.all(
    iterableScreenshotFiles.map(async ([p, resolver]) => {
      const md = await resolver();
      const metadata = md.metadata;
      return {
        metadata,
        path: p,
        // @ts-expect-error - render function exists
        content: render(md.default, { props: {} }).body
      };
    })
  );

  return allScreenshots.filter((s) => s.path.startsWith(`/src/data/screenshots/${pathPrefix}`));
};

const CategoryData = {
  plugins: globSync('src/data/screenshots/plugins/*/index.yaml'),
  languages: globSync('src/data/screenshots/languages/*/index.yaml')
};

export enum CategoryName {
  PLUGINS,
  LANGUAGES
}

interface CategoryItemData {
  name: string;
  icon: string;
  url: string;
  screenshots: ScreenshotMarkdownData[];
}

export const getCategoryData = async (category: CategoryName): Promise<CategoryItemData[]> => {
  let allData;
  switch (category) {
    case CategoryName.PLUGINS:
      allData = CategoryData.plugins;
      break;
    case CategoryName.LANGUAGES:
      allData = CategoryData.languages;
      break;
    default:
      allData = CategoryData.plugins;
      break;
  }
  return await Promise.all(
    allData.map(async (p) => {
      const file = fs.readFileSync(p, 'utf8');
      const categoryType = p.includes('plugins') ? 'plugins' : 'languages';
      const d = YAML.parse(file);
      d.screenshots = await getAllScreenshotsByPathPrefix(categoryType + '/' + d.name.toLowerCase());
      return d;
    })
  );
};
