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
                <input type="checkbox" v-model="randomStart" class="input--checkbox">
                <div>Random Start</div>
              </label>
            </div>

            <div class="setting-group__row">
              <label class="label--checkbox">
                <input type="checkbox" v-model="auto" class="input--checkbox">
                <div>Auto Start</div>
              </label>
            </div>
          </div>
        </div>

        <div class="setting-group">
          <div class="setting-group__title">Pager</div>

          <div class="setting-group__body">
            <div class="setting-group__row">
              <label class="label--checkbox">
                <input type="checkbox" v-model="pager" class="input--checkbox">
                <div>Pager</div>
              </label>
            </div>

            <div class="setting-group__row">
              <label>Pager Type</label>
              <select v-model="pagerType">
                <option value="full">Full</option>
                <option value="short">Short</option>
              </select>
            </div>
          </div>
        </div>

        <div class="setting-group">
          <div class="setting-group__title">Controls</div>

          <div class="setting-group__body">
            <div class="setting-group__row">
              <label class="label--checkbox">
                <input type="checkbox" v-model="controls" class="input--checkbox">
                <div>Controls Enabled</div>
              </label>
            </div>

            <div class="setting-group__row">
              <label class="label--checkbox">
                <input type="checkbox" v-model="autoControls" class="input--checkbox">
                <div>Start / Stop Controls Enabled</div>
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
        auto: this.settings.auto || true,
        autoControls: this.settings.autoControls || false,
        controls: this.settings.controls || true,
        mode: this.settings.mode || 'horizontal',
        pager: this.settings.pager || true,
        pagerType: this.settings.pagerType || 'full',
        randomStart: this.settings.randomStart || false,
        speed: this.settings.speed || 500,
        slideMargin: this.settings.slideMargin || 0,
        startSlide: this.settings.startSlide || 0
      }
    },

    methods: {
      submit(event) {
        event.preventDefault();

        const settings = {
          auto: this.auto,
          autoControls: this.autoControls,
          controls: this.controls,
          mode: this.mode,
          pager: this.pager,
          pagerType: this.pagerType,
          randomStart: this.randomStart,
          speed: this.speed,
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
