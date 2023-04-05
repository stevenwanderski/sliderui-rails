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
      script.src = `${this.appHost}/sliders/${this.shortCode}.js?source=dashboard`;
      document.querySelector('#script-container').appendChild(script);
    },

    props: [
      'appHost',
      'shortCode'
    ]
  }
</script>
