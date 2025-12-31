<script lang="ts">
	import HeadComponent from '$lib/HeadComponent.svelte';
	import screenshotsData from './screenshots.json';

	interface Screenshot {
		src: string;
		alt: string;
		title: string;
		text: string;
	}

	const screenshots: Screenshot[] = screenshotsData;
	let currentScreenshotIndex = 0;

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
		currentScreenshotIndex = parseInt(link.getAttribute('data-idx') || '0');
		if (!anchorId) return;
		// if starts with slide, prevent horizontal jump
		if (anchorId.startsWith('slide')) {
			const currentScroll = window.scrollY;
			const anchor = document.getElementById(anchorId);
			anchor?.scrollIntoView({ behavior: 'smooth' });
			window.scrollTo({ top: currentScroll });
		}
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
	<div class="text-center mb-10 w-full max-w-4xl mx-auto carousel carousel-center space-x-4 rounded-box">
		{#each screenshots as image, index (index)}
			<div
				id={'slide' + (index + 1)}
				class="carousel-item relative w-full {currentScreenshotIndex === index ? '' : 'hidden'}"
			>
				<div class="card bg-base-100 shadow-xl">
					<figure>
						<img src={image.src} alt={image.alt} class="w-full object-contain" />
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
