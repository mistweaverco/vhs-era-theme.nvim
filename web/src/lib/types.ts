export interface Shiki {
  (code: string, lang: string, metadata?: string): Promise<string>;
}

export interface Screenshot {
  src: string;
  alt: string;
  title: string;
  text: string;
}

export interface ScreenshotData {
  languages: {
    name: string;
    icon?: string;
    items: Screenshot[];
  }[];
  plugins: {
    name: string;
    icon?: string;
    items: Screenshot[];
  }[];
}
