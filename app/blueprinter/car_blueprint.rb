class CarBlueprint < Blueprinter::Base
  identifier :id

  fields :model, :brand_id, :price

  view :api do
    field :label do |car, options|
      user = options[:user]
      if user.preferred_brands.include?(car.brand) && user.preferred_price_range.include?(car.price)
        "prefect_match"
      elsif user.preferred_brands.include?(car.brand)
        "good_match"
      else
        nil
      end
    end

    field :rank_score do |car, options|
      res = options[:response].find{|h| h[:car_id] == car.id}
      res[:rank_score] if res.respond_to?(:fetch)
    end

    association :brand, blueprint: BrandBlueprint
  end
end
