<template>
  <nav>
    <a
      href=""
      class="section__tab-link"
      v-bind:class="{ active: isSlides }"
      @click="onClick('slides', $event)">
      Slides
    </a>

    <a
      href=""
      class="section__tab-link"
      v-bind:class="{ active: isSettings }"
      @click="onClick('settings', $event)">
      Settings
    </a>
  </nav>
</template>

<script>
  export default {
    props: [
      'isSlides',
      'isSettings',
      'onClick',
      'visibleSection'
    ]
  }
</script>
