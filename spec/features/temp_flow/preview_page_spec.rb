require 'spec_helper'
include TempSliderHelper

describe 'Temp Slider Flow', js: true do
  before :each do
    create_temp_slider
  end

  describe 'Preview page' do
    context 'when slides exist' do
      it 'shows the slider preview' do

      end
    end

    context 'when slides do not exist' do
      it 'shows the empty preview' do

      end
    end
  end
end
