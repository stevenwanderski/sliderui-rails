<template>
  <slide-item-view
    v-bind:slide="slide"
    v-bind:onClickEdit="clickEdit"
    v-if="isViewing"
  ></slide-item-view>

  <slide-item-edit
    v-bind:slide="slide"
    v-bind:onCancel="clickCancel"
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
      isViewing() {
        return this.isEditing === false;
      }
    },

    data() {
      return {
        isEditing: false
      }
    },

    methods: {
      clickCancel() {
        this.isEditing = false;
      },

      clickEdit() {
        this.isEditing = true;
      }
    },

    props: [
      'onDelete',
      'slide'
    ]
  }
</script>
