fx_version 'adamant'
games { 'gta5' }

client_scripts {
	"locale.lua",
	"locales/*.lua",
	"config.lua",

	"client/main.lua",
	"client/InvisibleFunction.lua",
	"client/class/*.lua",
	"client/events.lua",
	"client/threads.lua",

	"MenuAPI/exports/*.lua",
	"MenuAPI/system/*.lua",
	"MenuAPI/module/*.lua",
	"MenuAPI/*.lua",
}

escrow_ignore {
	"locale.lua",
	"locales/*.lua",
	"config.lua",

	"client/main.lua",
	"client/class/*.lua",
	"client/events.lua",
	"client/threads.lua",
	"client/InvisibleFunction.lua",

	"MenuAPI/exports/*.lua",
	"MenuAPI/system/*.lua",
	"MenuAPI/module/*.lua",
	"MenuAPI/*.lua",
	
	"locale.lua",
	"locales/*.lua",
	"config.lua",

	"server/server.lua",

	"object.lua",	
}

server_script {
	"locale.lua",
	"locales/*.lua",
	"config.lua",

	"server/server.lua",
}

shared_scripts {
	"object.lua",
}

files {
	"html/css/style.css",
	"html/css/reset.css",
	
	"html/css/img/monitor.png",
	"html/css/img/table.png",
	
	"html/*.html",
	
	"html/scripts/*.js",

	"html/MenuAPI/*.js",
	"html/MenuAPI/*.html",
	"html/MenuAPI/*.css",
}

ui_page "html/index.html"

lua54 "yes"