import { mdsvexShiki } from '@mistweaverco/mdsvex-shiki';
import type { ScreenshotData, Shiki } from '$lib/types';
import { InstallationMethod } from '$lib/enums';
import screenshotsDataJSON from './screenshots.json';
import installCodeLazy from './install-code-lazy.lua?raw';
import installCodePacker from './install-code-packer.lua?raw';
import installCodeVimPlug from './install-code-vimplug.lua?raw';

const getInstallCode = async (shiki: Shiki, method: InstallationMethod) => {
  let codeSnippet = '';
  switch (method) {
    case InstallationMethod.Lazy:
      codeSnippet = installCodeLazy;
      break;
    case InstallationMethod.Packer:
      codeSnippet = installCodePacker;
      break;
    case InstallationMethod.VimPlug:
      codeSnippet = installCodeVimPlug;
      break;
  }
  codeSnippet += '\n-- Then set the colorscheme\nvim.cmd("colorscheme vhs-era-theme")';
  return await shiki(codeSnippet, 'lua', 'path=nvim/init.lua');
};

export const load = async () => {
  const shiki = await mdsvexShiki({});

  return {
    screenshotsData: screenshotsDataJSON as ScreenshotData,
    lazyInstallCode: await getInstallCode(shiki, InstallationMethod.Lazy),
    packerInstallCode: await getInstallCode(shiki, InstallationMethod.Packer),
    vimPlugInstallCode: await getInstallCode(shiki, InstallationMethod.VimPlug)
  };
};
