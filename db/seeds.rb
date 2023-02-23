require 'csv'

CSV.foreach("db/csv/mountains-data.csv", headers: true) do |row|
  Mountain.create(
    kana: row[0],
    name: row[1],
    prefecture: row[2],
    elevation: row[3],
    latitude: row[4],
    longitude: row[5]
  )
end