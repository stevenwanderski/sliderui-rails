<template>
  <div class="slider-preview">
    <div v-bind:data-slider-id="shortCode"></div>
    <div id="script-container"></div>
  </div>
</template>

<script>
  export default {
    mounted() {
      document.querySelector(`[data-slider-id="${this.shortCode}"]`).innerHTML = '';
      document.querySelector('#script-container').innerHTML = '';

      const script = document.createElement('script');
      script.src = `http://localhost:3000/sliders/${this.shortCode}.js`;
      document.querySelector('#script-container').appendChild(script);
    },

    props: [
      'shortCode'
    ]
  }
</script>
