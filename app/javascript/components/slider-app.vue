<template>
  <div class="slider-settings">
    <div class="section slider-settings__slides">
      <div class="scrollable">
        <div class="scrollable__header">
          <slider-nav
            v-bind:onClick="clickNav"
            v-bind:isSlides="isSlides"
            v-bind:isSettings="isSettings"
          ></slider-nav>
        </div>

        <div class="scrollable__body">
          <section-slides
            v-bind:noSlides="noSlides"
            v-bind:onAddSlide="addSlide"
            v-bind:onDeleteSlide="deleteSlide"
            v-bind:onMoveSlide="moveSlide"
            v-bind:slider-id="sliderId"
            v-bind:slides="slides"
            v-if="isSlides"
          ></section-slides>

          <section-settings
            v-if="isSettings"
            :onSubmit="saveSettings"
            :settings="settings"
          ></section-settings>
        </div>
      </div>
    </div>

    <div class="section flex-child--full-width">
      <h3>Preview</h3>

      <div v-if="resettingPreview">
        Updating slider...
      </div>

      <div v-else-if="noSlides" class="slider-preview__placeholder">
        Slider will appear after adding a slide 😬
      </div>

      <slider-preview
        v-else
        :app-host="appHost"
        :short-code="shortCode"
      ></slider-preview>
    </div>

    <loading v-if="isLoading"></loading>
  </div>
</template>

<script>
  import axios from 'axios';
  import Loading from './loading';
  import SliderNav from './slider/slider-nav';
  import SliderPreview from './slider/preview';
  import SectionSlides from './slider/section-slides';
  import SectionSettings from './slider/section-settings';

  export default {
    created() {
      this.fetchData();
    },

    components: {
      Loading,
      SliderNav,
      SliderPreview,
      SectionSlides,
      SectionSettings
    },

    computed: {
      isSlides() {
        return this.visibleSection === 'slides';
      },

      isSettings() {
        return this.visibleSection === 'settings';
      },

      noSlides() {
        return this.slides.length === 0;
      }
    },

    data() {
      return {
        isLoading: true,
        resettingPreview: false,
        settings: {},
        slides: [],
        visibleSection: null
      }
    },

    methods: {
      addSlide: async function(file) {
        this.isLoading = true;

        const formData = new FormData();
        formData.append('slide[slider_id]', this.sliderId);
        formData.append('slide[weight]', this.slides.length);
        formData.append('slide[image]', file);

        const response = await axios.post(`/api/slides`, formData);

        this.slides.push({
          id: response.data.id,
          imageUrl: response.data.image_url,
          destroyUrl: response.data.destroy_url
        });

        this.isLoading = false;
        this.updatePreview();
      },

      clickNav(key, event) {
        event.preventDefault();
        this.visibleSection = key;
      },

      deleteSlide: async function(slideId) {
        this.isLoading = true;

        await axios.delete(`/api/slides/${slideId}`);

        this.isLoading = false;
        this.slides = this.slides.filter((slide) => slide.id != slideId);
        this.updatePreview();
      },

      fetchData: async function() {
        const response = await axios.get(`/api/sliders/${this.sliderId}`);

        this.settings = response.data.settings;
        this.slides = response.data.slides.map((slide) => {
          return {
            id: slide.id,
            imageUrl: slide.image_url,
            destroyUrl: slide.destroy_url,
            weight: slide.weight
          }
        });

        this.isLoading = false;
        this.visibleSection = 'slides';
      },

      moveSlide: async function(event) {
        this.isLoading = true;

        this.slides = this.slides.map((slide, index) => {
          slide.weight = index;
          return slide;
        });

        await axios.put('/api/slides/collection', {
          slides: this.slides
        });

        this.isLoading = false;
        this.updatePreview();
      },

      saveSettings: async function(values) {
        this.isLoading = true;

        const data = { slider: { settings: values } };
        await axios.put(`/api/sliders/${this.sliderId}`, data);

        this.isLoading = false;
        this.settings = values;
        this.updatePreview();
      },

      updatePreview() {
        this.resettingPreview = true;

        setTimeout(() => {
          this.resettingPreview = false;
        }, 500);
      }
    },

    props: [
      'appHost',
      'shortCode',
      'sliderId'
    ]
  }
</script>
