fx_version 'adamant'
games { 'gta5' }

dependencies {
	'rcore'
}

client_scripts {
	"@es_extended/locale.lua",
	"locales/*.lua",
	"config.lua",

	"client/main.lua",
	"client/class/*.lua",
	"client/events.lua",
	"client/threads.lua",
}

server_script {
	"@es_extended/locale.lua",
	"locales/*.lua",
	"config.lua",

	"server/server.lua",
}

files {
	"html/css/style.css",
	"html/css/reset.css",
	
	"html/css/img/monitor.png",
	"html/css/img/table.png",
	
	"html/*.html",
	
	"html/scripts/listener.js",
}

ui_page "html/index.html"