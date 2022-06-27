class ProcessPackagesService
  def initialize(line)
    @line = line
  end

  def perform
    @pending_packages = Package.pending.where(line_id: @line.id)
    return false if @pending_packages.blank?

    total_weight = @pending_packages.map(&:weight).sum
    total_volume = @pending_packages.map(&:volume).sum / 1_000_000

    selected_train = SeekSuitableTrainService.new(total_weight, total_volume, @line).perform
    return false unless selected_train

    FillPackagesService.new(@line, selected_train, @pending_packages).perform

    selected_train
  end
end
