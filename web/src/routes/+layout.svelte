<script lang="ts">
	import { copyAction } from '@mistweaverco/mdsvex-shiki/copyAction';
	import '@fortawesome/fontawesome-free/css/all.min.css';
	import '@mistweaverco/mdsvex-shiki/styles.css';
	import '../app.css';
	import '../devicon.min.css';
	let { children } = $props();
</script>

<div use:copyAction>
	{@render children()}
</div>
