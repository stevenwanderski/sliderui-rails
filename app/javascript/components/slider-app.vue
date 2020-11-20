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
      clickNav(key, event) {
        event.preventDefault();

        this.visibleSection = key;
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
