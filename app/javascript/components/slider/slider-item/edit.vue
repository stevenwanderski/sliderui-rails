<template>
  <div class="slide-item slide-item--editing">
    <div class="slide-item__child slide-item__edit-image">
      <div
        v-bind:style="{ backgroundImage: `url(${slide.imageUrl})`}"
        class="slide-item__preview"
      ></div>
    </div>

    <div class="slide-item__child slide-item__controls">
      <button v-on:click="clickDelete" class="slide-item__control slide-item__control--delete">
        Delete
      </button>

      <button v-on:click="onCancel" class="slide-item__control slide-item__control--cancel">
        Cancel
      </button>
    </div>
  </div>

</template>

<script>
  export default {
    methods: {
      clickDelete() {
        this.onDelete(this.slide.id);
      }
    },

    props: [
      'onCancel',
      'onDelete',
      'slide'
    ]
  }
</script>
