<template>
  <div class="slide-item slide-item--editing">
    <div class="slide-item__child slide-item__edit-image">
      <div
        v-bind:style="{ backgroundImage: `url(${slide.imageUrl})`}"
        class="slide-item__preview"
      ></div>

      <div class="image-uploader">
        <input type="file" id="slide-image-79a395c9-3648-4cc3-b23a-07ada37c58d9" accept="image/jpeg, image/png, image/gif" class="image-uploader__file">
        <label for="slide-image-79a395c9-3648-4cc3-b23a-07ada37c58d9" class="image-uploader__label undefined">
          Edit
        </label>
      </div>
    </div>

    <div class="slide-item__child slide-item__controls">
      <a href="" class="slide-item__control slide-item__control--delete">
        Delete
      </a>

      <button v-on:click="onClickCancel" class="slide-item__control slide-item__control--cancel">
        Cancel
      </button>
    </div>
  </div>

</template>

<script>
  export default {
    props: [
      'onClickCancel',
      'slide'
    ]
  }
</script>
