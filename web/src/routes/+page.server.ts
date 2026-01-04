import { mdsvexShiki } from '@mistweaverco/mdsvex-shiki';
import type { Shiki } from '$lib/types';
import { InstallationMethod } from '$lib/enums';
import { CategoryName, getCategoryData } from '$lib/screenshots';
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
  const shiki = await mdsvexShiki({
    shikiOptions: {
      langs: ['lua']
    }
  });

  const languagesCategoryData = await getCategoryData(CategoryName.LANGUAGES);
  const pluginsCategoryData = await getCategoryData(CategoryName.PLUGINS);

  return {
    languagesCategoryData,
    pluginsCategoryData,
    installationCode: {
      [InstallationMethod.Lazy]: await getInstallCode(shiki, InstallationMethod.Lazy),
      [InstallationMethod.Packer]: await getInstallCode(shiki, InstallationMethod.Packer),
      [InstallationMethod.VimPlug]: await getInstallCode(shiki, InstallationMethod.VimPlug)
    }
  };
};
