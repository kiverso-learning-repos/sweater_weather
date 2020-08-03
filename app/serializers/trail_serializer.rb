class TrailSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :forecast, :trails
end
