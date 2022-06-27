class FillPackagesService
  def initialize(line, train, packages)
    @line = line
    @train = train
    @packages = packages
  end

  def perform
    if @packages.map(&:weight).sum <= @train.max_weight && @packages.map(&:volume).sum / 1_000_000 <= @train.max_volume
      @packages.update_all(status: Package.statuses[:in_progress])
    else
      selected_package_ids = []
      total_weight = 0

      @packages.find_each do |package|
        if total_weight <= @train.max_weight && package.weight <= @train.max_weight
          total_weight += package.weight
          selected_package_ids.push(package.id)
        else
          break
        end
      end

      @packages.where(id: selected_package_ids).update_all(status: Package.statuses[:in_progress])
    end

    @train.unavailable!
    @line.unavailable!
  end
end
