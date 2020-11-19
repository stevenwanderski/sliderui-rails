import React from 'react';

class SliderContainer extends React.Component {
  constructor() {
    console.log(React.version);
    super();

    this.state = {
      visibleSection: 'slides'
    }

    this.clickNav = this.clickNav.bind(this);
  }

  clickNav(section) {
    this.setState({ visibleSection: section });
  }

  render () {
    return (
      <div className="slider-settings">
        <div className="section slider-settings__slides">
          <div className="scrollable">
            <div className="scrollable__header">
              <nav>
                <a
                  className="section__tab-link section__tab-link--slides active"
                  onClick={this.clickNav.bind(this, 'slides')}>
                  Slides
                </a>

                <a
                  className="section__tab-link section__tab-link--settings"
                  onClick={this.clickNav.bind(this, 'settings')}>
                  Settings
                </a>
              </nav>
            </div>

            <div className="scrollable__body">
              {this.state.visibleSection}
            </div>
          </div>
        </div>

        <div className="section flex-child--full-width">
          I am slider.
        </div>
      </div>
    );
  }
}

export default SliderContainer;
