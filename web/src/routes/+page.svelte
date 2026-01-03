<script lang="ts">
	import { page } from '$app/state';
	import { browser } from '$app/environment';
	import { pushState } from '$app/navigation';
	import HeadComponent from '$lib/HeadComponent.svelte';
	import { InstallationMethod } from '$lib/enums';
	import type { ScreenshotMarkdownData } from '$lib/screenshots';

	const { data } = $props();
	const params = $derived(browser ? Object.fromEntries(page.url.searchParams) : {});
	const screenshots: ScreenshotMarkdownData[] = $derived.by(() => {
		if (page.url.hash !== '#screenshots') return [];
		const { category, name } = params;
		if (!name || !category) return [];
		const source =
			category === 'language'
				? data.languagesCategoryData.find((item) => item.name.toLowerCase() === name.toLowerCase()) || {
						screenshots: []
					}
				: data.pluginsCategoryData.find((item) => item.name.toLowerCase() === name.toLowerCase()) || {
						screenshots: []
					};
		return source.screenshots || [];
	});

	let activeIndex = $state(0);
	let heights: number[] = $state([]);
	let slideEls: HTMLElement[] = $state([]);
	let screenshotImgEls: HTMLImageElement[] = $state([]);
	let containerHeight = $state(0);

	const onParamsChange = async () => {
		if (page.url.hash === '#screenshots') {
			if (params.slide) {
				const anchor = document.getElementById('slide' + params.slide);
				anchor?.scrollIntoView({
					behavior: 'smooth',
					block: 'nearest',
					inline: 'center'
				});
			}
			return;
		}
	};

	$effect(() => {
		onParamsChange();
	});

	function measureContainerHeight(index: number) {
		const el = slideEls[index];
		if (!el) return;
		heights[index] = el.offsetHeight;
		if (index === activeIndex) containerHeight = heights[index];
	}

	const handleSectionAnchorClick = (evt: Event) => {
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

	const lazyloadScreenshots = (node: HTMLImageElement) => {
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
		target.closest('form')?.submit();
	};
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
						Just check out some of the <a class="link" href="#screenshots" onclick={handleSectionAnchorClick}
							>screenshots</a
						> to see how far it's come!
					</p>
				</div>
			</div>
			<p class="mb-6 text-lg text-secondary text-center border-1 rounded-lg border-secondary p-4">
				VHS Era is a nostalgic colorscheme for Neovim that brings back the vibrant and distinct aesthetics of the VHS
				era.
			</p>
			<a href="#screenshots" onclick={handleSectionAnchorClick}
				><button class="btn btn-secondary">Screenshots</button></a
			>
		</div>
	</div>
</div>

<div class="bg-base-200 min-h-screen flex flex-col justify-center">
	<a id="screenshots" aria-label="Screenshots section anchor"></a>
	<div class="text-center mb-10">
		<h1 class="text-5xl font-bold">Screenshots 📸</h1>
		<p class="pt-6">Some screenshots</p>
	</div>
	<div class="text-center mb-10">
		<div class="dropdown">
			<button
				tabindex="0"
				class="btn m-1 w-full justify-between {params.category === 'language'
					? 'btn-outline btn-secondary'
					: 'btn-outline btn-accent'}"
			>
				{#if params.category === 'language' && params.name}
					<i
						class="border-2 border-secondary rounded-full p-1 bg-secondary text-base-content {data.languagesCategoryData.find(
							(item) => item.name === params.name
						)?.icon || ''}"
					></i>
				{/if}
				{params.category === 'language' && params.name ? params.name : 'Languages'}
			</button>
			<ul class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
				{#each data.languagesCategoryData as item, idx (idx)}
					<li>
						<a href="?category=language&name={item.name}&slide=1#screenshots" class="flex items-center gap-2">
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
				class="btn m-1 w-full justify-between {params.category === 'plugin'
					? 'btn-outline btn-secondary'
					: 'btn-outline btn-accent'}"
			>
				{#if params.category === 'plugin' && params.name}
					<i
						class="border-2 border-secondary rounded-full p-1 bg-secondary text-base-content {data.pluginsCategoryData.find(
							(item) => item.name === params.name
						)?.icon || ''}"
					></i>
				{/if}
				{params.category === 'plugin' && params.name ? params.name : 'Plugins'}
			</button>
			<ul class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
				{#each data.pluginsCategoryData as item, idx (idx)}
					<li>
						<a href="?category=plugin&name={item.name}&slide=1#screenshots" class="flex items-center gap-2">
							{#if item.icon}
								<i class={item.icon}></i>
							{/if}
							{item.name}
						</a>
					</li>
				{/each}
			</ul>
		</div>
		{#if screenshots.length === 0}
			<div role="alert" class="alert alert-warning max-w-md mx-auto mt-6 flex justify-center">
				<i class="fa-solid fa-triangle-exclamation"></i>
				<span>Please select a language or plugin to view screenshots.</span>
			</div>
		{/if}
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
							onload={() => measureContainerHeight(index)}
							use:lazyloadScreenshots
							data-src="/assets/screenshots/{params.category}s/{params.name.toLowerCase()}/{image.metadata.url}"
							alt={image.metadata.title}
							class="image"
						/>
					</figure>
					<div class="card-body">
						<h2 class="card-title justify-center">
							<a
								href={params.category === 'language'
									? data.languagesCategoryData.find((item) => item.name.toLowerCase() === params.name.toLowerCase())
											?.url
									: data.pluginsCategoryData.find((item) => item.name.toLowerCase() === params.name.toLowerCase())?.url}
								target="_blank"
								class="btn btn-ghost btn-xl"
							>
								{params.name}
								<span class="fa-solid fa-external-link-alt"></span>
							</a>
						</h2>
						{@html image.content}
					</div>
					<div class="absolute right-5 top-5 tooltip tooltip-left" data-tip="Open image in new tab">
						<a
							href="/assets/screenshots/{params.category}s/{params.name.toLowerCase()}/{image.metadata.url}"
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
								href={'?category=' + params.category + '&name=' + params.name + '&slide=' + index + '#screenshots'}
								class="btn btn-circle btn-soft btn-secondary">❮</a
							>
						{:else}
							<div></div>
						{/if}
						{#if index !== screenshots.length - 1}
							<a
								href={'?category=' +
									params.category +
									'&' +
									'name=' +
									params.name +
									'&slide=' +
									(index + 2) +
									'#screenshots'}
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
			<a href="#installation" onclick={handleSectionAnchorClick}
				><button class="btn btn-secondary mt-5">Installation</button></a
			>
		</p>
	</div>
</div>

<div class="bg-base-200 min-h-screen flex flex-col justify-center">
	<a id="installation" aria-label="Installation section anchor"></a>
	<div class="text-center mb-10">
		<h1 class="text-5xl font-bold">Installation 🚀</h1>
		<p class="pt-6">How to install the theme</p>
	</div>
	<div class="text-center mb-10">
		<form method="GET" action="#installation">
			<select name="pluginManager" class="select select-bordered mb-6" onchange={onInstallationMethodChange}>
				<option disabled selected={params.pluginManager ? null : true}>Select</option>
				<option
					selected={params.pluginManager === InstallationMethod.Lazy ? true : null}
					value={InstallationMethod.Lazy}>Lazy.nvim</option
				>
				<option
					selected={params.pluginManager === InstallationMethod.Packer ? true : null}
					value={InstallationMethod.Packer}>Packer.nvim</option
				>
				<option
					selected={params.pluginManager === InstallationMethod.VimPlug ? true : null}
					value={InstallationMethod.VimPlug}>Vim-Plug</option
				>
			</select>
		</form>
	</div>
	{#if params.pluginManager}
		<div class="text-center mb-10 w-full mx-auto carousel carousel-center space-x-4 rounded-box max-w-4xl">
			<div class="m-auto text-left">
				{@html data.installationCode[params.pluginManager as InstallationMethod]}
			</div>
		</div>
	{/if}
	<div class="text-center mb-10">
		<p>
			<a href="#get-involved" onclick={handleSectionAnchorClick}
				><button class="btn btn-secondary mt-5">Get involved</button></a
			>
		</p>
	</div>
</div>

<div class="hero bg-base-200 min-h-screen">
	<a id="get-involved" aria-label="Get involved section anchor"></a>
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
