# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Match.delete_all
Stream.delete_all

matches = Match.create!([
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Benfica vs Sporting', competition: 'Taça da Liga'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Famalicão vs Aves', competition: 'Taça de Portugal'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Moreirense vs Belenenses SAD', competition: 'Liga NOS'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Liverpool vs Leicester', competition: 'Premier League'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Marselha vs Paris Saint German', competition: 'Ligue 1'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Juventus vs AC Milan', competition: 'Serie A'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'DC United vs San Jose Earthquakes', competition: 'MLS'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Real Madrid vs Huesca', competition: 'Liga Satander'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'PSV vs Ajax', competition: 'Erdevise'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Galatasarai vs Besiktas', competition: 'Liga Turca'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Benfica vs Bayer Munich', competition: 'Champions League'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Sporting vs Artmedia', competition: 'Europa League'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Benfica B vs Académica', competition: 'Liga Ledman Pro'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Portugal vs Italia', competition: 'UEFA Nations League'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Peru vs Venezuela', competition: 'Copa America'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Russia vs Espanha', competition: 'World Cup'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Santos vs Colo Colo', competition: 'Copa Libertadores'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'FC Porto vs Sporting', competition: 'Taça da Amizade'},
    {sport: 'Football/Soccer', kickoff: Time.now + rand(10).hours, title: 'Benfica vs Turino', competition: 'Taça Eusébio'}
                        ])


matches.each do |m|

  (0..rand(10)).each do |s|
    m.streams << Stream.new(url: 'acestream://899504vs0f938gjvd048g930f8vis9r39g9sdv9g8d0s', extra_info: 'HD ESPN')
  end

  m.save

end


