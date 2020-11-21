<template>
  <div class="slides">
    <div class="scrollable">
      <div class="scrollable__header">
        <div class="image-uploader">
          <input
            accept="image/jpeg, image/png, image/gif"
            class="image-uploader__file"
            id="slide-image-new"
            v-on:change="changeFile"
            type="file">

          <label
            for="slide-image-new"
            class="image-uploader__label button button--secondary button--full-width button--add-slide">
            Add Slide
          </label>
        </div>
      </div>

      <div class="scrollable__body scrollable__body--button">
        <slide-item
          v-for="slide in slides"
          v-bind:key="slide.id"
          v-bind:onDelete="onDeleteSlide"
          v-bind:slide="slide">
        </slide-item>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';
  import SlideItem from './slide-item';

  export default {
    components: { SlideItem },

    methods: {
      changeFile(event) {
        const file = event.target.files[0];

        this.onAddSlide(file);
        //
        // const formData = new FormData();
        // formData.append('slide[slider_id]', this.sliderId);
        // formData.append('slide[weight]', this.slides.length);
        // formData.append('slide[image]', file);
        //
        // return axios.post(`/api/slides`, formData)
        //   .then((response) => {
        //     console.log(response.data);
        //     this.slides.push(response.data);
        //     // let slides = this.state.slides;
        //     // let slide = response.data;
        //     // slides.push(slide);
        //     // this.setState({ slides: slides });
        //     // this.props.onNewSlide();
        //   });
        //
      }
    },

    props: [
      'onAddSlide',
      'onDeleteSlide',
      'sliderId',
      'slides'
    ]
  }
</script>
