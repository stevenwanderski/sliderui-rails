<template>
  <div class="image-uploader">
    <input
      accept="image/jpeg, image/png, image/gif"
      class="image-uploader__file"
      v-bind:id="fileInputId"
      v-on:change="changeFile"
      type="file">

    <label
      v-bind:for="fileInputId"
      class="image-uploader__label"
      v-bind:class="labelClass">
      {{ text }}
    </label>
  </div>
</template>

<script>
  export default {
    methods: {
      changeFile(event) {
        const file = event.target.files[0];

        if (!this.validFileSize(file) || !this.validFileType(file)) {
          return;
        }

        this.onChangeFile(file);
      },

      validFileSize(file) {
        const maxFileSize = 2000000 // 1MB
        const fileSize = file.size;

        if (fileSize > maxFileSize) {
          alert('Image cannot be greater than 2MB.');
          return false;
        }

        return true;
      },

      validFileType(file) {
        const acceptedFileTypes = [
          'image/jpeg',
          'image/png',
          'image/gif'
        ]
        const fileType = file.type;

        if (acceptedFileTypes.indexOf(fileType) === -1) {
          alert('Image must be one of the following: jpg, png, gif');
          return false;
        }

        return true;
      }
    },

    props: [
      'fileInputId',
      'labelClass',
      'onChangeFile',
      'text'
    ]
  }
</script>
