const SliderSettings = {
  init(args) {
    this.shortCode = args.shortCode;

    this.setupFormHandler();
  },

  buildSettings(formData) {
    const settings = {};
    const skipKeys = ['authenticity_token', 'utf8'];

    formData.forEach((item) => {
      const { name, value } = item;

      if (skipKeys.includes(name)) { return; }

      if (value === '') { return; }

      settings[name] = this.formatValue(value);
    });

    return { slider: { settings: settings } };
  },

  formatValue(value) {
    if (value === 'true') {
      return true;
    }

    if (value == 'false') {
      return false
    }

    return value;
  },

  hideLoading() {
    $('.loader').hide();
  },

  setupFormHandler() {
    $('form').on('submit', (event) => {
      event.preventDefault();

      const $form = $(event.target);
      const action = $form.attr('action');
      const formData = $form.serializeArray();
      const data = this.buildSettings(formData);

      this.showLoading();

      $.ajax({
        contentType: 'application/json',
        data: JSON.stringify(data),
        dataType: 'json',
        method: 'put',
        url: action
      })
      .done(() => {
        this.hideLoading();
        SliderPage.refreshSlider();
      });
    });
  },

  showLoading() {
    $('.loader').show();
  }
}
