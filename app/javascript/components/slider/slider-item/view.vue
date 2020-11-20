<template>
  <div class="slide-item slide-item--showing">
    <div class="slide-item__child">
      <div
        v-bind:style="{ backgroundImage: `url(${slide.imageUrl})`}"
        class="slide-item__preview"
      ></div>
    </div>

    <div class="slide-item__child slide-item__controls">
      <button
        class="slide-item__control--edit"
        v-on:click="onClickEdit"
      ></button>

      <div class="slide-item__handle slide-item__control--move"></div>
    </div>
  </div>
</template>

<script>
  export default {
    props: [
      'onClickEdit',
      'slide'
    ]
  }
</script>
