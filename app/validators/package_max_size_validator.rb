class PackageMaxSizeValidator < ActiveModel::Validator
  def validate(record)
    return if record.weight.blank? || record.volume.blank? || record.line_id.blank?

    line_name = Line.find(record.line_id).name
    trains = Train.where(active: true).where("lines @> ?", "#{line_name}".to_json)

    if trains
      suitable_weight_train_ids = trains.where("max_weight >= ?", record.weight).pluck(:id)
      suitable_volume_train_ids = trains.where("max_volume >= ?", record.volume / 1_000_000).pluck(:id)

      return if (suitable_weight_train_ids & suitable_volume_train_ids).present?
    end

    record.errors.add(:base, "The package size is too large.")
  end
end
