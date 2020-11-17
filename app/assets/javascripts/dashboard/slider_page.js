const SliderPage = {
  init(args) {
    this.shortCode = args.shortCode;
    this.setupNav();
  },

  refreshSlider() {
    $('[data-slider-id]').html('');
    $('#script-container').html('');

    const script = $('<script>');
    script.attr('src', `http://localhost:3000/sliders/${this.shortCode}.js`);
    $('#script-container').html(script);
  },

  setNavMenu($target) {
    $('[data-nav]').removeClass('active');
    $target.addClass('active');
  },

  setupNav() {
    $('[data-nav]').on('click', (event) => {
      event.preventDefault();
      const $target = $(event.target);

      this.setNavMenu($target);
      this.showNavSection($target);
    });
  },

  showNavSection($target) {
    const section = $target.data('nav');

    $('[data-section]').hide();
    $(`[data-section="${section}"]`).show();
  }
}
