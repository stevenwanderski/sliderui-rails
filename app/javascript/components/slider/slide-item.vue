<template>
  <slide-item-view
    v-bind:slide="slide"
    v-bind:onClickEdit="clickEdit"
    v-if="isViewing"
  ></slide-item-view>

  <slide-item-edit
    v-bind:slide="slide"
    v-bind:onClickCancel="clickCancel"
    v-bind:onDelete="onDelete"
    v-else-if="isEditing"
  ></slide-item-edit>
</template>

<script>
  import SlideItemView from './slider-item/view';
  import SlideItemEdit from './slider-item/edit';

  export default {
    components: {
      SlideItemEdit,
      SlideItemView
    },

    computed: {
      isEditing() {
        return this.slide.isEditing === true;
      },

      isViewing() {
        return this.slide.isEditing === false;
      }
    },

    methods: {
      clickCancel() {
        this.slide.isEditing = false;
      },

      clickEdit() {
        this.slide.isEditing = true;
      }
    },

    props: [
      'onDelete',
      'slide'
    ]
  }
</script>
