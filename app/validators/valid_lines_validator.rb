class ValidLinesValidator < ActiveModel::Validator
  def validate(record)
    return record.errors.add(:lines, "can't be empty") if record.lines.blank?

    lines = record.lines.uniq

    return record.errors.add(:lines, "contains wrong line name") if lines.size != Line.where(name: lines).size
  end
end
