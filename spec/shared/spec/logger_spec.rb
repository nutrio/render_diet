require 'spec_helper'

describe RenderDiet::Logger do

  before do
    RenderDiet::Logger.reset
  end

  describe "#reset" do
    it "should reset count/time/renders" do
      RenderDiet::Logger.count.should == 0
      RenderDiet::Logger.time.should == 0
      RenderDiet::Logger.renders.should == []

      Benchmark.should_receive(:realtime).at_least(:once).and_return(5)
      Movie.create

      RenderDiet::Logger.count.should > 0
      RenderDiet::Logger.time.should > 0
      RenderDiet::Logger.renders.size.should > 0
    end
  end

  describe "#count" do
    it "should return the number of renders since the last reset" do
      Movie.create
      Movie.create
      RenderDiet::Logger.count.should == 2
    end
  end

  describe "#time" do
    it "should return the number of miliseconds spent running database renders since the last reset" do
      Benchmark.should_receive(:realtime).at_least(:once).and_return(5)
      Movie.create
      RenderDiet::Logger.time.should == 5000
    end
  end

  describe "#renders" do
    it "should return the renders since last reset" do
      Benchmark.should_receive(:realtime).at_least(:once).and_return(5.1234)
      Movie.create
      RenderDiet::Logger.renders.size.should == 1
      render = RenderDiet::Logger.renders.first
      render.size.should == 2
      #render[0].should include("INSERT INTO \"movies\"")
      render[0].should include("nested")
      render[1].should == 5.1234
    end
  end

  describe "#paused" do

    before do
      RenderDiet::Logger.paused = false
    end

    after do
      RenderDiet::Logger.paused = false
    end

    it "should be false by default" do
      RenderDiet::Logger.paused.should == false
    end

    it "should pause the render count" do
      Movie.create
      Movie.create
      RenderDiet::Logger.count.should == 2

      RenderDiet::Logger.paused = true
      Movie.create
      RenderDiet::Logger.count.should == 2

      RenderDiet::Logger.paused = false
      Movie.create
      RenderDiet::Logger.count.should == 3
    end

    # regression
    it "should still execute renders if paused" do
      Movie.delete_all
      RenderDiet::Logger.paused = true
      #Movie.count.should == 0
      #Movie.create
      #Movie.count.should == 1
      rendered = RenderDietController.render :two_renders
      rendered.should include("nested")
    end

    it "should be false by default" do
      RenderDiet::Logger.paused.should == false
    end

  end

end
