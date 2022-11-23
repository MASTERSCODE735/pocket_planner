class SampleController < ApplicationController

  def test   
    render :json => {"name": "Pramod", "age": 25}
  end

end
