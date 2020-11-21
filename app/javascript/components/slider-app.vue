<template>
  <div class="slider-settings">
    <div class="section slider-settings__slides">
      <div class="scrollable">
        <div class="scrollable__header">
          <slider-nav
            v-bind:onClick="clickNav"
            v-bind:isSlides="isSlides"
            v-bind:isSettings="isSettings">
          </slider-nav>
        </div>

        <div class="scrollable__body">
          <section-slides
            v-bind:onAddSlide="addSlide"
            v-bind:onDeleteSlide="deleteSlide"
            v-bind:slider-id="sliderId"
            v-bind:slides="slides"
            v-if="isSlides">
          </section-slides>

          <section-settings
            v-if="isSettings">
          </section-settings>
        </div>
      </div>
    </div>

    <div class="section flex-child--full-width">
      <h3>Preview</h3>
    </div>

    <loading v-if="isLoading"></loading>
  </div>
</template>

<script>
  import axios from 'axios';
  import Loading from './loading';
  import SliderNav from './slider/slider-nav';
  import SectionSlides from './slider/section-slides';
  import SectionSettings from './slider/section-settings';

  export default {
    created() {
      this.fetchData();
    },

    components: {
      Loading,
      SliderNav,
      SectionSlides,
      SectionSettings
    },

    computed: {
      isSlides() {
        return this.visibleSection === 'slides';
      },

      isSettings() {
        return this.visibleSection === 'settings';
      }
    },

    data() {
      return {
        isLoading: true,
        slides: [],
        visibleSection: null
      }
    },

    methods: {
      addSlide(file) {
        this.isLoading = true;

        const formData = new FormData();
        formData.append('slide[slider_id]', this.sliderId);
        formData.append('slide[weight]', this.slides.length);
        formData.append('slide[image]', file);

        return axios.post(`/api/slides`, formData)
          .then((response) => {
            const slideResponse = response.data;

            const slide = {
              id: slideResponse.id,
              imageUrl: slideResponse.image_url,
              isEditing: false,
              destroyUrl: slideResponse.destroy_url
            };

            this.slides.push(slide);

            this.isLoading = false;
          });
      },

      clickNav(key, event) {
        event.preventDefault();

        this.visibleSection = key;
      },

      deleteSlide(slideId) {
        this.isLoading = true;

        return axios.delete(`/api/slides/${slideId}`)
          .then((response) => {
            this.isLoading = false;

            this.slides = this.slides.filter((slide) => slide.id != slideId);
          });
      },

      fetchData() {
        axios.get(`/api/sliders/${this.sliderId}`)
          .then((response) => {
            const slides = response.data.slides.map((slide) => {
              return {
                id: slide.id,
                imageUrl: slide.image_url,
                isEditing: false,
                destroyUrl: slide.destroy_url
              }
            });

            this.isLoading = false;
            this.slides = slides;
            this.visibleSection = 'slides';
          });
      }
    },

    props: ['sliderId']
  }
</script>
