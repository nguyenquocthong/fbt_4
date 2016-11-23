namespace :db do
  task calculator_rate_tour: :environment do
    tours = Tour.all
    tours.each do |tour|
      rate_avg = tour.average("quality").avg
      if tour.update_attributes rate_avg: rate_avg
        puts "#{tour.rate_avg} - #{t "view.success"}"
      else
        puts t "view.error"
      end
    end
  end
end
