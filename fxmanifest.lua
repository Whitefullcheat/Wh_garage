
fx_version 'cerulean'
game 'gta5'

name "wh_garage"
description "Garage"
author "Whitefullcheat"
version "1.0"
lua54 'yes'

shared_scripts {
    'config.lua',
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
}

client_scripts {
	'@es_extended/locale.lua',
	'client/*.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server/*.lua'
}