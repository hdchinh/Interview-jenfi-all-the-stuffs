class SeekSuitableTrainService
  def initialize(total_weight, total_volumne, line)
    @total_weight = total_weight
    @total_volume = total_volumne
    @line = line
  end

  def perform
    trains = Train.available.where("lines @> ?", "#{@line.name}".to_json)
    return false if trains.blank?

    suitable_weight_train_ids = trains.where("max_weight >= ?", @total_weight).pluck(:id)
    suitable_volume_train_ids = trains.where("max_volume >= ?", @total_volume).pluck(:id)

    # [1] &  [1, 2, 3] => [1]
    suitable_train_ids = suitable_weight_train_ids & suitable_volume_train_ids

    # In cases can't carry all the packages
    # Return the biggest train that can run on this line
    return trains.order(max_weight: :desc).first if suitable_train_ids.blank?

    trains.order(:cost).first
  end
end
