const SliderSlides = {
  init(args) {
    this.args = args;

    this.initializeState();
    this.render();
  },

  closeMenu(id) {
    const state = this.state;

    const slides = state.slides.map((slide) => {
      if (slide.id === id) {
        slide.isEditing = false;
      }

      return slide;
    });

    state.slides = slides;

    this.setState(state);
  },

  deleteSlide(id, url) {
    this.showLoading();

    $.ajax({
      method: 'delete',
      url: url
    })
    .done(() => {
      this.hideLoading();
      SliderSettings.refreshSlider();

      const state = this.state;

      slides = state.slides.filter((slide) => {
        return slide.id !== id;
      });

      state.slides = slides;

      this.setState(state);
    });

  },

  initializeState() {
    const slides = this.args.slides.map((slide) => {
      return {
        id: slide.id,
        imageUrl: slide.image_url,
        isEditing: false,
        destroyUrl: slide.destroy_url
      }
    });

    this.state = {
      slides: slides
    };
  },

  openMenu(id) {
    const state = this.state;

    const slides = state.slides.map((slide) => {
      if (slide.id === id) {
        slide.isEditing = true;
      }

      return slide;
    });

    state.slides = slides;

    this.setState(state);
  },

  render() {
    const output = HandlebarsTemplates['slides/index'](this.state);

    $('#tpl-slides-output').html(output);

    this.setupEventHandlers();
  },

  setState(data) {
    this.state = data;
    this.render();
  },

  setupEventHandlers() {
    $('[data-menu-close]').on('click', (event) => {
      const $target = $(event.target);
      const id = $target.data('menu-close');

      this.closeMenu(id);
    });

    $('[data-menu-open]').on('click', (event) => {
      const $target = $(event.target);
      const id = $target.data('menu-open');

      this.openMenu(id);
    });

    $('[data-delete]').on('click', (event) => {
      const $target = $(event.target);
      const id = $target.data('delete');
      const url = $target.data('delete-url');

      this.deleteSlide(id, url);
    });
  },

  showLoading() {
    $('.loader').show();
  },

  hideLoading() {
    $('.loader').hide();
  }
}
