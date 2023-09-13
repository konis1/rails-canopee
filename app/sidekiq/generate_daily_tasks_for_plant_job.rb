# Ce job est appelé sur chaque plante d'un jardin, organise les données contenues dans weather_data, puis s'en sert pour
# générer les tâches à effectuer prochainement pour la plante en question.
class GenerateDailyTasksForPlantJob
  include Sidekiq::Job
  require 'rubygems'
  require 'twilio-ruby'

  def perform(garden_plant_id, weather_data)
    @weather_data = weather_data

    @garden_plant = GardenPlant.find(garden_plant_id)

    generate_plant_watering_task(@weather_data['past_rain_array'], @weather_data['today_rain'])
    generate_plant_sheltering_task
    generate_plant_cover_task
    generate_mulching_task
    due_tasks = Task.where(due_date: Date.today)

    due_tasks.each do |task|
      # Assuming the user model has a phone_number attribute
      user_phone_number = task.user.phone_number

      # Send WhatsApp notification
      WhatsappNotificationService.new(user_phone_number, "Your task '#{task.name}' is due today!").send
    end
  end

  private

  # C'est la seule tâche générée pour l'instant. J'attends de voir ce que ça donne pour améliorer la logique et
  # implémenter d'autres tâches.
  def generate_plant_watering_task(past_rain_array, today_rain)
    watering_interval = calculate_plant_watering_interval

    if past_rain_array.last(watering_interval).all? { |precipitation| precipitation < 10.0 } && today_rain < 10.0 && @garden_plant.tasks.watering.pending.count.zero? && @garden_plant.tasks.watering.done.count.zero?
      Task.create(
        activity: "Arrose-moi !",
        criticity: 0,
        due_date: DateTime.now + (watering_interval * 0.7).day,
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end

  def calculate_plant_watering_interval
    plant_watering_needs = @garden_plant.plant.water_need
    case plant_watering_needs
    when 0 then 31
    when 1 then 7
    when 2 then 1
    end
  end

  def generate_plant_sheltering_task
    if @today_min_temp < -5 && @garden_plant.tasks.sheltering.urgent.pending.count.zero?
      Task.create(activity: "Rentre-moi à l'intérieur !", criticity: 2, due_date: DateTime.now + 1.day, start_time: DateTime.now, garden_plant: @garden_plant)
    elsif @forecast_min_temp_array.any? { |t| t < -5 } && @garden_plant.tasks.sheltering.pending.count.zero?
      Task.create(
        activity: "Rentre-moi à l'intérieur !",
        criticity: 1,
        due_date: DateTime.parse(@forecast_dates_array[@forecast_min_temp_array.index(@forecast_min_temp_array.find { |t| t < -5 })]),
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end

  def generate_plant_cover_task
    if @today_min_temp > -5 && @today_min_temp.negative? && @garden_plant.tasks.covering.urgent.pending.count.zero?
      Task.create(activity: "Couvre-moi !", criticity: 2, due_date: DateTime.now + 1.day, start_time: DateTime.now, garden_plant: @garden_plant)
    elsif @forecast_min_temp_array.any? { |temperature| (-5..0).cover?(temperature) } && @garden_plant.tasks.sheltering.pending.count.zero?
      Task.create(
        activity: "Couvre-moi !",
        criticity: 1,
        due_date: DateTime.parse(@forecast_dates_array[@forecast_min_temp_array.index(@forecast_min_temp_array.find { |temperature| (-5..0).cover?(temperature) })]),
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end

  def generate_mulching_task
    if @today_min_temp.positive? && @today_min_temp < 5 && @garden_plant.tasks.mulching.urgent.pending.count.zero?
      Task.create(activity: "Paille-moi !", criticity: 2, due_date: DateTime.now + 1.day, start_time: DateTime.now, garden_plant: @garden_plant)
    elsif @forecast_min_temp_array.any? { |temperature| (0..5).cover?(temperature) } && @garden_plant.tasks.mulching.pending.count.zero?
      Task.create(
        activity: "Paille-moi !",
        criticity: 1,
        due_date: DateTime.parse(@forecast_dates_array[@forecast_min_temp_array.index(@forecast_min_temp_array.find { |temperature| (0..5).cover?(temperature) })]),
        start_time: DateTime.now,
        garden_plant: @garden_plant
      )
    end
  end
end
