# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Duck.create(region: 1, address: '서울 마포구 양화로 108', daddress: '지하2층~지상1층', name: '하비팩토리', mtype: 1, mlong: 126.919402, mlat: 37.553165, image_url: 'http://duckplace.azurewebsites.net/hobbyfactory.gif')
Duck.create(region: 1, address: '서울 서초구 효령로 304', daddress: '지하2층~지상1층', name: '국전(논노21 등)', mtype: 1, mlong: 127.017784, mlat: 37.484709, image_url: 'http://duckplace.azurewebsites.net/gukjun.gif')