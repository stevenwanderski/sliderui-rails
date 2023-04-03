<template>
  <div class="slides">
    <div class="scrollable">
      <div class="scrollable__header">
        <div class="hand" v-if="noSlides">
          👉
        </div>

        <image-uploader
          labelClass="button button--secondary button--full-width button--add-slide"
          fileInputId="slide-image-new"
          v-bind:onChangeFile="onAddSlide"
          text="Add Slide"
        ></image-uploader>
      </div>

      <div class="scrollable__body scrollable__body--button">
        <div v-if="noSlides" class="slides__emptyxxx">
          ⬆️ Start by adding a slide here!
        </div>

        <draggable
          v-else
          :list="slides"
          handle=".slide-item__handle"
          @change="onMoveSlide">
          <slide-item
            v-for="slide in slides"
            v-bind:key="slide.id"
            v-bind:onDelete="onDeleteSlide"
            v-bind:slide="slide">
          </slide-item>
        </draggable>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  import draggable from 'vuedraggable';
  import SlideItem from './slide-item';
  import ImageUploader from './image-uploader';

  export default {
    components: {
      draggable,
      ImageUploader,
      SlideItem
    },

    props: [
      'noSlides',
      'onAddSlide',
      'onDeleteSlide',
      'onMoveSlide',
      'sliderId',
      'slides'
    ]
  }
</script>
