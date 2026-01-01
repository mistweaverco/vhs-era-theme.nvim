<script lang="ts">
	import { onMount, tick } from 'svelte';
	import { pushState } from '$app/navigation';
	import HeadComponent from '$lib/HeadComponent.svelte';
	import { InstallationMethod } from '$lib/enums';
	import type { Screenshot } from '$lib/types.js';

	const { data } = $props();

	let activeIndex = $state(0);
	let heights: number[] = $state([]);
	let slideEls: HTMLElement[] = $state([]);
	let screenshotImgEls: HTMLImageElement[] = $state([]);
	let containerHeight = $state(0);
	let installCode: string = $state('');
	let screenshots: Screenshot[] = $state([]);
	let screenshotSelectedCategory: string | null = $state(null);
	let screenshotSelectedLanguage: string | null = $state(null);
	let screenshotSelectedPlugin: string | null = $state(null);
	let screenshotSelectedLanguageIcon: string | null = $state(null);
	let screenshotSelectedPluginIcon: string | null = $state(null);

	function measure(index: number) {
		const el = slideEls[index];
		if (!el) return;
		heights[index] = el.offsetHeight;
		if (index === activeIndex) containerHeight = heights[index];
	}

	const onScreenshotSelect = (evt: Event) => {
		activeIndex = 0;
		const target = evt.target as HTMLDivElement;
		const idx = parseInt(target.getAttribute('data-idx') || '0');
		const type = target.getAttribute('data-type');
		screenshotSelectedCategory = type;
		// TODO: refactor to pass data directly instead of faking events
		// also blur dropdowns after selection
		if (type === 'language') {
			const d = data.screenshotsData.languages[idx];
			screenshots = d.items;
			screenshotSelectedLanguage = d.name;
			screenshotSelectedLanguageIcon = d.icon || null;
			screenshotSelectedPlugin = null;
			screenshotSelectedPluginIcon = null;
		} else if (type === 'plugin') {
			const d = data.screenshotsData.plugins[idx];
			screenshots = d.items;
			screenshotSelectedPlugin = d.name;
			screenshotSelectedPluginIcon = d.icon || null;
			screenshotSelectedLanguage = null;
			screenshotSelectedLanguageIcon = null;
		}
	};

	const handleAnchorClick = (evt: Event) => {
		evt.preventDefault();
		const link = evt.currentTarget as HTMLAnchorElement;
		const url = new URL(link.href);
		const hash = url.hash;
		const anchorId = hash.replace('#', '');
		const anchor = document.getElementById(anchorId);
		window.scrollTo({
			top: anchor?.offsetTop,
			behavior: 'smooth'
		});
		pushState(url.pathname + hash, '');
	};

	const preventGalleryJump = (evt: Event) => {
		evt.preventDefault();
		const link = evt.currentTarget as HTMLAnchorElement;
		const url = new URL(link.href);
		const hash = url.hash;
		const anchorId = hash.replace('#', '');
		activeIndex = parseInt(link.getAttribute('data-idx') || '0', 10);
		const slideIdx = activeIndex + 1;
		const currentScroll = window.scrollY;
		const anchor = document.getElementById(anchorId);
		anchor?.scrollIntoView({ behavior: 'smooth' });
		window.scrollTo({ top: currentScroll });
		const newUrl =
			url.pathname +
			'#!/' +
			(screenshotSelectedLanguage
				? `screenshots/language/${encodeURIComponent(screenshotSelectedLanguage.toLowerCase())}/${slideIdx}`
				: screenshotSelectedPlugin
					? `screenshots/plugin/${encodeURIComponent(screenshotSelectedPlugin.toLowerCase())}/${slideIdx}`
					: '');
		if (newUrl === window.location.pathname + window.location.hash) return;
		pushState(
			url.pathname +
				'#!/' +
				(screenshotSelectedLanguage
					? `screenshots/language/${encodeURIComponent(screenshotSelectedLanguage.toLowerCase())}/${slideIdx}`
					: screenshotSelectedPlugin
						? `screenshots/plugin/${encodeURIComponent(screenshotSelectedPlugin.toLowerCase())}/${slideIdx}`
						: ''),
			''
		);
	};

	const lazyload = (node: HTMLImageElement) => {
		const mutationObserver = new MutationObserver((mutations) => {
			mutations.forEach((mutation) => {
				if (mutation.type === 'attributes' && mutation.attributeName === 'data-src') {
					const img = mutation.target as HTMLImageElement;
					if (img.dataset.src) {
						img.src = img.dataset.src;
					}
				}
			});
		});
		mutationObserver.observe(node, { attributes: true });
		const intersectionObserver = new IntersectionObserver(
			(entries, obs) => {
				entries.forEach((entry) => {
					if (entry.isIntersecting) {
						const img = entry.target as HTMLImageElement;
						img.src = img.dataset.src || '';
						obs.unobserve(node);
					}
				});
			},
			{ rootMargin: '50px' }
		);
		intersectionObserver.observe(node);
		return {
			destroy() {
				intersectionObserver.unobserve(node);
				mutationObserver.disconnect();
			}
		};
	};

	const onInstallationMethodChange = async (evt: Event) => {
		const target = evt.target as HTMLSelectElement;
		const method = target.selectedIndex;
		switch (method) {
			case InstallationMethod.Lazy:
				installCode = data.lazyInstallCode;
				break;
			case InstallationMethod.Packer:
				installCode = data.packerInstallCode;
				break;
			case InstallationMethod.VimPlug:
				installCode = data.vimPlugInstallCode;
				break;
			default:
				installCode = data.lazyInstallCode;
		}
	};

	const onDeepLink = async () => {
		const hash = window.location.hash;
		if (hash && hash.startsWith('#!/')) {
			const deepLink = hash.replace('#!/', '');
			if (deepLink.startsWith('screenshots')) {
				const anchor = document.getElementById('screenshots');
				window.scrollTo({
					top: anchor?.offsetTop
				});
				const parts = deepLink.split('/');
				if (parts.length < 3) {
					return;
				}
				const type = parts[1];
				const name = decodeURIComponent(parts[2]);
				const slideIdx = parts.length === 4 ? parts[3] : null;
				const slideIdxNum = slideIdx ? parseInt(slideIdx, 10) : 1;
				if (type === 'language') {
					for (const [idx, item] of data.screenshotsData.languages.entries()) {
						if (item.name.toLowerCase() === name.toLowerCase()) {
							onScreenshotSelect({
								target: {
									getAttribute: (attr: string) => {
										if (attr === 'data-idx') return idx.toString();
										if (attr === 'data-type') return 'language';
										return null;
									}
								}
							} as unknown as Event);
							if (slideIdxNum !== null) {
								await tick();
								preventGalleryJump({
									preventDefault: () => {},
									currentTarget: {
										href: new URL(`#slide${slideIdx}`, window.location.href).toString(),
										getAttribute: (attr: string) => {
											if (attr === 'data-idx') return slideIdxNum - 1;
											return null;
										}
									}
								} as unknown as Event);
							}
							break;
						}
					}
				} else if (type === 'plugin') {
					for (const [idx, item] of data.screenshotsData.plugins.entries()) {
						if (item.name.toLowerCase() === name.toLowerCase()) {
							onScreenshotSelect({
								target: {
									getAttribute: (attr: string) => {
										if (attr === 'data-idx') return idx.toString();
										if (attr === 'data-type') return 'plugin';
										return null;
									}
								}
							} as unknown as Event);
							if (slideIdxNum !== null) {
								await tick();
								preventGalleryJump({
									preventDefault: () => {},
									currentTarget: {
										href: new URL(`#slide${slideIdx}`, window.location.href).toString(),
										getAttribute: (attr: string) => {
											if (attr === 'data-idx') return slideIdxNum - 1;
											return null;
										}
									}
								} as unknown as Event);
							}
							break;
						}
					}
				}
			}
		}
	};

	onMount(async () => {
		await tick();
		window.addEventListener('hashchange', onDeepLink);
		onDeepLink();
	});
</script>

<HeadComponent
	data={{
		title: 'vhs-era-theme.nvim',
		description:
			'VHS Era is a nostalgic colorscheme for Neovim that brings back the vibrant and distinct aesthetics of the VHS era.'
	}}
/>

<div class="z-50 fixed right-5 top-5 tooltip tooltip-left" data-tip="Open GitHub repository">
	<a
		href="https://github.com/mistweaverco/vhs-era-theme.nvim"
		class="btn btn-circle btn-xl btn-ghost"
		aria-label="Open GitHub repository"
	>
		<i class="devicon-github-original"></i>
	</a>
</div>

<div id="start" class="hero bg-base-200 min-h-screen">
	<div class="hero-content text-center">
		<div class="max-w-md">
			<img src="/logo.svg" alt="vhs-era-theme logo" class="m-5 mx-auto w-64" />
			<h1 class="text-5xl font-bold">VHS Era</h1>
			<div class="collapse bg-base-100 border border-base-300 mt-6 mb-6">
				<input type="checkbox" name="intro-theme-roots" />
				<div
					class="collapse-title font-semibold text-lg bg-secondary text-secondary-content text-center"
					style="padding-inline-end: unset;"
				>
					A retro colorscheme for Neovim.
					<div class="text-center">
						<i class="fa-solid fa-caret-down"></i>
					</div>
				</div>
				<div class="collapse-content text-center border-1 border-secondary rounded-b-lg">
					<p class="mt-6 mb-2 text-2xl text-secondary">Theme Roots</p>
					<p class="text-secondary text-l mt-6 mb-6">
						When it started it used the base-colors from the popular <a
							class="link"
							href="https://github.com/nyoom-engineering/oxocarbon.nvim"
							>Oxocarbon
							<span class="fa-solid fa-external-link-alt"></span>
						</a> theme, but has since evolved into its own unique style.
					</p>
					<p class="text-secondary text-l mt-6 mb-6">
						Just check out some of the <a class="link" href="#screenshots" onclick={handleAnchorClick}>screenshots</a> to
						see how far it's come!
					</p>
				</div>
			</div>
			<p class="mb-6 text-lg text-secondary text-center border-1 rounded-lg border-secondary p-4">
				VHS Era is a nostalgic colorscheme for Neovim that brings back the vibrant and distinct aesthetics of the VHS
				era.
			</p>
			<a href="#screenshots" onclick={handleAnchorClick}><button class="btn btn-secondary">Screenshots</button></a>
		</div>
	</div>
</div>

<div id="screenshots" class="bg-base-200 min-h-screen flex flex-col justify-center">
	<div class="text-center mb-10">
		<h1 class="text-5xl font-bold">Screenshots 📸</h1>
		<p class="pt-6">Some screenshots</p>
	</div>
	<div class="text-center mb-10">
		<div class="dropdown">
			<button
				tabindex="0"
				class="btn m-1 w-full justify-between {screenshotSelectedLanguage
					? 'btn-outline btn-secondary'
					: 'btn-outline btn-accent'}"
			>
				{#if screenshotSelectedLanguageIcon}
					<i
						class="border-2 border-secondary rounded-full p-1 bg-secondary text-base-content {screenshotSelectedLanguageIcon}"
					></i>
				{/if}
				{screenshotSelectedLanguage ? screenshotSelectedLanguage : 'Languages'}
			</button>
			<ul class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
				{#each data.screenshotsData.languages as item, idx (idx)}
					<li>
						<a
							href="#!/screenshots/language/{item.name.toLowerCase()}/1"
							data-type="language"
							data-idx={idx}
							class="flex items-center gap-2"
						>
							{#if item.icon}
								<i class={item.icon}></i>
							{/if}
							{item.name}
						</a>
					</li>
				{/each}
			</ul>
		</div>
		<div class="dropdown">
			<button
				tabindex="0"
				class="btn m-1 w-full justify-between {screenshotSelectedPlugin
					? 'btn-outline btn-secondary'
					: 'btn-outline btn-accent'}"
			>
				{#if screenshotSelectedPluginIcon}
					<i
						class="border-2 border-secondary rounded-full p-1 bg-secondary text-base-content {screenshotSelectedPluginIcon}"
					></i>
				{/if}
				{screenshotSelectedPlugin ? screenshotSelectedPlugin : 'Plugins'}
			</button>
			<ul class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
				{#each data.screenshotsData.plugins as item, idx (idx)}
					<li>
						<a
							href="#!/screenshots/plugin/{item.name.toLowerCase()}/1"
							data-type="plugin"
							data-idx={idx}
							class="flex items-center gap-2"
						>
							{#if item.icon}
								<i class={item.icon}></i>
							{/if}
							{item.name}
						</a>
					</li>
				{/each}
			</ul>
		</div>
	</div>
	<div
		class="text-center mb-10 w-full mx-auto carousel carousel-center space-x-4 rounded-box max-w-4xl"
		style="height: {containerHeight}px"
	>
		{#each screenshots as image, index (index)}
			<div id={'slide' + (index + 1)} class="carousel-item relative">
				<div bind:this={slideEls[index]} class="card bg-base-100 shadow-xl mx-auto w-full">
					<figure>
						<img
							bind:this={screenshotImgEls[index]}
							onload={() => measure(index)}
							use:lazyload
							data-src={image.src}
							alt={image.alt}
							class="image"
						/>
					</figure>
					<div class="card-body">
						<h2 class="card-title justify-center">{image.title}</h2>
						<p>{image.text}</p>
					</div>
					<div class="absolute right-5 top-5 tooltip tooltip-left" data-tip="Open image in new tab">
						<a
							href={image.src}
							target="_blank"
							class="btn btn-soft btn-circle btn-secondary"
							aria-label="Open image in new tab"
						>
							<i class="fa-solid fa-expand"></i>
						</a>
					</div>
					<div class="absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between">
						{#if index !== 0}
							<a
								href={'#!/screenshots/' +
									screenshotSelectedCategory +
									'/' +
									screenshotSelectedPlugin?.toLocaleLowerCase() +
									'/' +
									index}
								data-idx={index - 1}
								class="btn btn-circle btn-soft btn-secondary">❮</a
							>
						{:else}
							<div></div>
						{/if}
						{#if index !== screenshots.length - 1}
							<a
								href={'#!/screenshots/' +
									screenshotSelectedCategory +
									'/' +
									screenshotSelectedPlugin?.toLocaleLowerCase() +
									'/' +
									(index + 2)}
								data-idx={index + 1}
								class="btn btn-circle btn-soft btn-secondary">❯</a
							>
						{:else}
							<div></div>
						{/if}
					</div>
				</div>
			</div>
		{/each}
	</div>
	<div class="text-center">
		<p>
			<a href="#installation" onclick={handleAnchorClick}
				><button class="btn btn-secondary mt-5">Installation</button></a
			>
		</p>
	</div>
</div>

<div id="installation" class="bg-base-200 min-h-screen flex flex-col justify-center">
	<div class="text-center mb-10">
		<h1 class="text-5xl font-bold">Installation 🚀</h1>
		<p class="pt-6">How to install the theme</p>
	</div>
	<div class="text-center mb-10">
		<select class="select select-bordered mb-6" onchange={onInstallationMethodChange}>
			<option disabled selected>Select</option>
			<option>Lazy.nvim</option>
			<option>Packer.nvim</option>
			<option>Vim-Plug</option>
		</select>
	</div>
	<div class="text-center mb-10 w-full mx-auto carousel carousel-center space-x-4 rounded-box max-w-4xl">
		<div class="m-auto text-left">
			{@html installCode}
		</div>
	</div>
	<div class="text-center mb-10">
		<p>
			<a href="#get-involved" onclick={handleAnchorClick}
				><button class="btn btn-secondary mt-5">Get involved</button></a
			>
		</p>
	</div>
</div>
<div id="get-involved" class="hero bg-base-200 min-h-screen">
	<div class="hero-content text-center">
		<div class="max-w-md">
			<h1 class="text-5xl font-bold">Get involved ❤️</h1>
			<p class="py-6">The colorscheme is open-source and we welcome contributions.</p>
			<p>
				View the <a class="text-secondary" href="https://github.com/mistweaverco/vhs-era-theme.nvim">code.</a>
			</p>
		</div>
	</div>
</div>

<style>
	.carousel {
		overflow-y: hidden;
	}
	.carousel-item {
		position: relative;
		flex: 0 0 auto;
		display: block;
		width: 100%;
		transition: height 300ms ease;
	}

	.image {
		width: 100%;
		height: auto;
		pointer-events: none;
	}
</style>
