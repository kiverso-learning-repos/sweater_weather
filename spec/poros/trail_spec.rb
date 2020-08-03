require 'rails_helper'

RSpec.describe "Trail" do
  describe "methods" do
    it "can create instances of itself", :vcr do
      start_location = '39.742043,-104.991531'
      trail_info = {:id=>7011192,
                    :name=>"Boulder Skyline Traverse",
                    :type=>"Recommended Route",
                    :summary=>"The classic long mountain route in Boulder.",
                    :difficulty=>"black",
                    :stars=>4.7,
                    :starVotes=>86,
                    :location=>"Superior, Colorado",
                    :url=>"https://www.hikingproject.com/trail/7011192/boulder-skyline-traverse",
                    :imgSqSmall=>"https://cdn2.apstatic.com/photos/hike/7039883_sqsmall_1555092747.jpg",
                    :imgSmall=>"https://cdn2.apstatic.com/photos/hike/7039883_small_1555092747.jpg",
                    :imgSmallMed=>"https://cdn2.apstatic.com/photos/hike/7039883_smallMed_1555092747.jpg",
                    :imgMedium=>"https://cdn2.apstatic.com/photos/hike/7039883_medium_1555092747.jpg",
                    :length=>17.4,
                    :ascent=>5480,
                    :descent=>-5558,
                    :high=>8454,
                    :low=>5423,
                    :longitude=>-105.2582,
                    :latitude=>39.9388,
                    :conditionStatus=>"All Clear",
                    :conditionDetails=>"Dry",
                    :conditionDate=>"2020-06-20 23:07:00"}

      trail = Trail.new(trail_info, start_location)

      expect(trail.name).to eq('Boulder Skyline Traverse')
      expect(trail.difficulty).to eq('black')
      expect(trail.summary).to eq('The classic long mountain route in Boulder.')
      expect(trail.location).to eq('Superior, Colorado')
      expect(trail.distance_to_trail).to eq(27.97)
    end
  end
end