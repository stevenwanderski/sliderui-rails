<template>
  <div class="slides">
    <div class="scrollable">
      <div class="scrollable__header">
        <div class="image-uploader">
          <input type="file" id="slide-image-new" accept="image/jpeg, image/png, image/gif" class="image-uploader__file">
          <label for="slide-image-new" class="image-uploader__label button button--secondary button--full-width button--add-slide">
            Add Slide
          </label>
        </div>
      </div>

      <div class="scrollable__body scrollable__body--button">
        <slide-item
          v-for="slide in slides"
          v-bind:key="slide.id"
          v-bind:slide="slide">
        </slide-item>
      </div>
    </div>
  </div>
</template>

<script>
  import SlideItem from './slide-item';

  export default {
    components: { SlideItem },

    props: ['slides']
  }
</script>
