# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
sources = Source.create([
            { name: 'LyngSat', url: 'http://lyngsat-logo.com/logo'},
            { name: 'PBS', url: 'http://www.pbs.org/images/stations/standard'},
            { name: 'XMLTV Sweden', url: 'http://xmltv.se/chanlogos'},
            { name: 'Media UK', url: 'http://www.mediauk.com/logos'},
            { name: 'Teles Locales', url: 'http://www.teleslocales.be/images24'}
            ])
