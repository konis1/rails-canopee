class GenerateDailyTasksForPlantJob < ApplicationJob
  queue_as :default

  def perform(garden_plant_id, weather_data)
    @weather_data = weather_data
    @min_temp_array = weather_data[0]
    @max_temp_array = weather_data[1]
    @rain_array = weather_data[2]
    @dates_array = weather_data[3]
    @past_min_temp_array = @min_temp_array.first(30)
    @past_max_temp_array = @max_temp_array.first(30)
    @past_rain_array = @rain_array.first(30)
    @past_dates_array = @dates_array.first(30)
    @today_max_temp = @max_temp_array[31]
    @today_min_temp = @min_temp_array[31]
    @today_rain = @rain_array[31]
    @forecast_min_temp_array = @min_temp_array.drop(31)
    @forecast_max_temp_array = @max_temp_array.drop(31)
    @forecast_rain_array = @rain_array.drop(31)
    @forecast_dates_array = @dates_array.drop(31)

    @garden_plant = GardenPlant.find(garden_plant_id)

    generate_plant_watering_task
    generate_plant_displacement_task
    generate_plant_cover_task
    generate_mulching_task
  end

  private

  def generate_plant_watering_task
    plant_watering_needs = @garden_plant.plant.water_need
    days = case plant_watering_needs
           when 0 then 31
           when 1 then 7
           when 2 then 1
           end

    if @past_rain_array.last(days).all?(0) && @today_rain.zero? && @garden_plant.tasks.where(activity: "Arrose-moi !").where("done_time > :limit_date", limit_date: Date.today - days.days).count.zero?
      Task.create(
        activity: "Arrose-moi !",
        criticity: "low",
        due_date: DateTime.now + 1.day,
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end

  def generate_plant_displacement_task
    if @today_min_temp < -5 && @garden_plant.tasks.where(activity: "Rentre-moi à l'intérieur !").count.zero?
      Task.create(activity: "Rentre-moi à l'intérieur !", criticity: "high", due_date: DateTime.now + 1.day, start_time: DateTime.now, garden_plant: @garden_plant)
    elsif @forecast_min_temp_array.any? { |t| t < -5 } && @garden_plant.tasks.where(activity: "Rentre-moi à l'intérieur !").count.zero?
      Task.create(
        activity: "Rentre-moi à l'intérieur !",
        criticity: "medium",
        due_date: DateTime.parse(@forecast_dates_array[@forecast_min_temp_array.index(@forecast_min_temp_array.find { |t| t < -5 })]),
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end

  def generate_plant_cover_task
    if @today_min_temp > -5 && @today_min_temp.negative? && @garden_plant.tasks.where(activity: "Couvre-moi !").count.zero?
      Task.create(activity: "Couvre-moi !", criticity: "high", due_date: DateTime.now + 1.day, start_time: DateTime.now, garden_plant: @garden_plant)
    elsif @forecast_min_temp_array.any? { |temperature| (-5..0).cover?(temperature) } && @garden_plant.tasks.where(activity: "Couvre-moi !").count.zero?
      Task.create(
        activity: "Couvre-moi !",
        criticity: "medium",
        due_date: DateTime.parse(@forecast_dates_array[@forecast_min_temp_array.index(@forecast_min_temp_array.find { |temperature| (-5..0).cover?(temperature) })]),
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end

  def generate_mulching_task
    if @today_min_temp.positive? && @today_min_temp < 5 && @garden_plant.tasks.where(activity: "Paille-moi !").count.zero?
      Task.create(activity: "Paille-moi !", criticity: "high", due_date: DateTime.now + 1.day, start_time: DateTime.now, garden_plant: @garden_plant)
    elsif @forecast_min_temp_array.any? { |temperature| (0..5).cover?(temperature) } && @garden_plant.tasks.where(activity: "Paille-moi !").count.zero?
      Task.create(
        activity: "Paille-moi !",
        criticity: "medium",
        due_date: DateTime.parse(@forecast_dates_array[@forecast_min_temp_array.index(@forecast_min_temp_array.find { |temperature| (0..5).cover?(temperature) })]),
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end
end
