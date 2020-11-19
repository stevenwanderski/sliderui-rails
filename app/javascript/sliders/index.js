import axios from 'axios';
import $ from 'jquery';

class Sliders {
  constructor() {
    this.state = { slides: [] };

    this.fetchData();
  }

  render() {
    const output = HandlebarsTemplates['slides/index'](this.state);

    $('#tpl-slides-output').html(output);
  }

  setState(state) {
    this.state = state;

    this.render();
  }

  fetchData() {
    axios.get('/api/sliders/c87cfaf5-4bb9-474c-b386-557d91a9289c')
      .then((response) => {
        const state = this.state;

        const slides = response.data.slides.map((slide) => {
          return {
            id: slide.id,
            imageUrl: slide.image_url,
            isEditing: false,
            destroyUrl: slide.destroy_url
          }
        });

        state.slides = slides;

        this.setState(state);
      });
  }
}

document.addEventListener('DOMContentLoaded', (event) => {
  new Sliders();
});
