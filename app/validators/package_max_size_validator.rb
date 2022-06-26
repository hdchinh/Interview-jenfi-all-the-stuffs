class PackageMaxSizeValidator < ActiveModel::Validator
  def validate(record)
    return if record.weight.blank? || record.volume.blank? || record.line_id.blank?
  end
end
