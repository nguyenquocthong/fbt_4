every 6.hours do
  rake "db:calculator_rate_tour", output: "#{path}/log/lograte.log"
end
