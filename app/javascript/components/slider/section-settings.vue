<template>
  <div class="scrollable">
    <div class="scrollable__header">
      <button
        class="button button--secondary button--full-width"
        @click="submit">
        Save Settings
      </button>
    </div>

    <div class="scrollable__body scrollable__body--button">
      <form @submit="submit">
        <div class="setting-group">
          <div class="setting-group__title">General</div>
          
          <div class="setting-group__body">
            <div class="setting-group__row">
              <label>Mode</label>
              <select v-model="mode">
                <option value="horizontal">Horizontal</option>
                <option value="vertical">Vertical</option>
              </select>
            </div>

            <div class="setting-group__row">
              <label>Speed</label>
              <input type="text" v-model="speed" class="input--text">
            </div>

            <div class="setting-group__row">
              <label>Slide Margin</label>
              <input type="text" v-model="slideMargin" class="input--text">
            </div>

            <div class="setting-group__row">
              <label>Start Slide</label>
              <input type="text" v-model="startSlide" class="input--text">
            </div>

            <div class="setting-group__row">
              <label class="label--checkbox">
                <input type="checkbox" v-model="auto" class="input--checkbox">
                <div>Auto Start</div>
              </label>
            </div>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
  export default {
    data() {
      return {
        auto: this.settings.auto,
        mode: this.settings.mode,
        speed: this.settings.speed,
        slideMargin: this.settings.slideMargin || 0,
        startSlide: this.settings.startSlide || 0
      }
    },

    methods: {
      submit(event) {
        event.preventDefault();

        const settings = {
          mode: this.mode,
          speed: this.speed,
          auto: this.auto,
          slideMargin: this.slideMargin,
          startSlide: this.startSlide
        }

        this.onSubmit(settings);
      }
    },

    props: [
      'onSubmit',
      'settings'
    ]
  }
</script>
