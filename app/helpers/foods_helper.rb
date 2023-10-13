module FoodsHelper
  def get_measurement_prefix(measurement)
    options = {
      'grams' => 'g',
      'milliliters' => 'ml',
      'units' => 'units'
    }
    options[measurement]
  end
end
