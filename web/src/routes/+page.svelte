<script lang="ts">
	import { onMount } from 'svelte';
	import HeadComponent from '$lib/HeadComponent.svelte';
	import screenshotsDataJSON from './screenshots.json';

	interface Screenshot {
		src: string;
		alt: string;
		title: string;
		text: string;
	}

	interface ScreenshotData {
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

	let activeIndex = 0;
	let heights: number[] = [];
	let slideEls: HTMLElement[] = [];
	let containerHeight = 0;

	function measure(index: number) {
		const el = slideEls[index];
		if (!el) return;
		heights[index] = el.offsetHeight;
		if (index === activeIndex) containerHeight = heights[index];
	}

	const screenshotData: ScreenshotData = screenshotsDataJSON as ScreenshotData;
	let screenshots: Screenshot[] = [];

	let screenshotSelectedLanguage: string | null = null;
	let screenshotSelectedPlugin: string | null = null;
	let screenshotSelectedLanguageIcon: string | null = null;
	let screenshotSelectedPluginIcon: string | null = null;

	const onScreenshotSelect = (evt: Event) => {
		const target = evt.target as HTMLDivElement;
		const idx = parseInt(target.getAttribute('data-idx') || '0');
		const type = target.getAttribute('data-type');
		activeIndex = 0;
		target.blur();
		if (type === 'language') {
			const data = screenshotData.languages[idx];
			screenshots = data.items;
			screenshotSelectedLanguage = data.name;
			screenshotSelectedLanguageIcon = data.icon || null;
			screenshotSelectedPlugin = null;
			screenshotSelectedPluginIcon = null;
		} else if (type === 'plugin') {
			const data = screenshotData.plugins[idx];
			screenshots = data.items;
			screenshotSelectedPlugin = data.name;
			screenshotSelectedPluginIcon = data.icon || null;
			screenshotSelectedLanguage = null;
			screenshotSelectedLanguageIcon = null;
		}
	};

	const handleAnchorClick = (evt: Event) => {
		evt.preventDefault();
		const link = evt.currentTarget as HTMLAnchorElement;
		const anchorId = new URL(link.href).hash.replace('#', '');
		const anchor = document.getElementById(anchorId);
		window.scrollTo({
			top: anchor?.offsetTop,
			behavior: 'smooth'
		});
	};

	const preventGalleryJump = (evt: Event) => {
		evt.preventDefault();
		const link = evt.currentTarget as HTMLAnchorElement;
		const anchorId = new URL(link.href).hash.replace('#', '');
		activeIndex = parseInt(link.getAttribute('data-idx') || '0');
		if (!anchorId) return;
		// if starts with slide, prevent horizontal jump
		if (anchorId.startsWith('slide')) {
			const currentScroll = window.scrollY;
			const anchor = document.getElementById(anchorId);
			anchor?.scrollIntoView({ behavior: 'smooth' });
			window.scrollTo({ top: currentScroll });
		}
	};

	$: containerHeight = heights[activeIndex] ?? containerHeight;
	$: screenshots;
	$: screenshotSelectedLanguage;
	$: screenshotSelectedPlugin;

	const lazyload = (node: HTMLImageElement) => {
		const observer = new IntersectionObserver(
			(entries, obs) => {
				entries.forEach((entry) => {
					if (entry.isIntersecting) {
						const img = entry.target as HTMLImageElement;
						img.src = img.dataset.src || '';
						obs.unobserve(img);
					}
				});
			},
			{ rootMargin: '50px' }
		);
		observer.observe(node);
		return {
			destroy() {
				observer.unobserve(node);
			}
		};
	};
</script>

<HeadComponent
	data={{
		title: 'vhs-era-theme.nvim',
		description: 'A retro VHS era theme for Neovim, inspired by the aesthetics of the 80s and 90s.'
	}}
/>

<div id="start" class="hero bg-base-200 min-h-screen">
	<div class="hero-content text-center">
		<div class="max-w-md">
			<img src="/logo.svg" alt="vhs-era-theme logo" class="m-5 mx-auto w-64" />
			<h1 class="text-5xl font-bold">VHS Era Theme for Neovim</h1>
			<p class="py-6">A retro VHS era theme for Neovim, inspired by the aesthetics of the 80s and 90s.</p>
			<a href="#screenshots" onclick={handleAnchorClick}><button class="btn btn-primary">Screenshots</button></a>
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
			<div tabindex="0" role="button" class="btn m-1 w-full justify-between">
				{#if screenshotSelectedLanguageIcon}
					<i class={screenshotSelectedLanguageIcon}></i>
				{/if}
				{screenshotSelectedLanguage ? screenshotSelectedLanguage : 'Languages'}
			</div>
			<ul class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
				{#each screenshotData.languages as item, idx (idx)}
					<li>
						<button onclick={onScreenshotSelect} data-type="language" data-idx={idx} class="flex items-center gap-2">
							{#if item.icon}
								<i class={item.icon}></i>
							{/if}
							{item.name}
						</button>
					</li>
				{/each}
			</ul>
		</div>
		<div class="dropdown">
			<div tabindex="0" role="button" class="btn m-1 w-full justify-between">
				{#if screenshotSelectedPluginIcon}
					<i class={screenshotSelectedPluginIcon}></i>
				{/if}
				{screenshotSelectedPlugin ? screenshotSelectedPlugin : 'Plugins'}
			</div>
			<ul class="dropdown-content menu bg-base-100 rounded-box z-[1] w-52 p-2 shadow">
				{#each screenshotData.plugins as item, idx (idx)}
					<li>
						<button onclick={onScreenshotSelect} data-type="plugin" data-idx={idx} class="flex items-center gap-2">
							{#if item.icon}
								<i class={item.icon}></i>
							{/if}
							{item.name}
						</button>
					</li>
				{/each}
			</ul>
		</div>
	</div>
	<div
		class="text-center mb-10 w-full max-w-4xl mx-auto carousel carousel-center space-x-4 rounded-box"
		style="height: {containerHeight}px"
	>
		{#each screenshots as image, index (index)}
			<div id={'slide' + (index + 1)} class="carousel-item relative">
				<div bind:this={slideEls[index]} class="card bg-base-100 shadow-xl mx-auto w-full max-w-3xl">
					<figure>
						<img onload={() => measure(index)} use:lazyload data-src={image.src} alt={image.alt} class="image" />
					</figure>
					<div class="card-body">
						<h2 class="card-title justify-center">{image.title}</h2>
						<p>{image.text}</p>
					</div>
					<div class="absolute left-5 right-5 top-1/2 flex -translate-y-1/2 transform justify-between">
						{#if index !== 0}
							<a onclick={preventGalleryJump} href={'#slide' + index} data-idx={index - 1} class="btn btn-circle">❮</a>
						{:else}
							<div></div>
						{/if}
						{#if index !== screenshots.length - 1}
							<a onclick={preventGalleryJump} href={'#slide' + (index + 2)} data-idx={index + 1} class="btn btn-circle"
								>❯</a
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
			<p class="py-6">vhs-era-theme.nvim is open-source and we welcome contributions.</p>
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
