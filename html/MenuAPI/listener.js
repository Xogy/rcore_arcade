var index = 0;

var AppInput = new Vue({
	el: '#input',
	data:
	{
        identifier: null,
	    titleMenu: "rcore",
	    float: "middle_screen",
	    position: "middle_screen",
	    ChooseText: "Accept",
	    CloseText: "Close",
	    message: "",
	    visible: false,
	    defaultTextInfront: '$',

	},
    methods: {
        Choose: function(){
            $.post('https://rcore_arcade/inputmethod', JSON.stringify({
                identifier: this.identifier,
                message: this.message,
            }));
        },
        Close: function(){
            $.post('https://rcore_arcade/close', JSON.stringify({
                identifier: this.identifier,
            }));
        },
    },
});

var App = new Vue({
	el: '#menu',
	data:
	{
        identifier: null,
	    titleMenu: "rcore",
	    float: "left",
	    position: "middle",
	    visible: false,
		menu: [],
	},
});

function setActiveMenuIndex(index, active_){
    for(var i = 0; i < App.menu.length; i++){ App.menu[i].active = false }
    if(App.menu[index] != null) App.menu[index].active = active_
}

// Menu
$(function(){
    function display(bool) {
        App.visible = bool;
    }
    display(false);
	window.addEventListener('message', function(event) {
        var item = event.data;

        if(item.type_menu === "reset"){
            App.menu = [];
        }

        if(item.type_menu === "add"){
            App.menu.push({
                label: item.label,
                number: item.index,
                secondLabel: item.secondLabel,
                active: false,
            });
        }

        if(item.type_menu === "title"){
            App.titleMenu = item.title
        }

        if (item.type_menu === "ui"){
            display(item.status);
            if(item.properties){
                App.float = item.properties.float;
                App.position = item.properties.position;
            }
            App.identifier = item.identifier;
            index = 0;
            setActiveMenuIndex(0, true)
        }

	    if(App.visible && !AppInput.visible){
            if (item.type_menu === "enter"){
                $.post('https://rcore_arcade/clickItem', JSON.stringify({
                    index: App.menu[index].number,
                    identifier: App.identifier,
                }));
            }

            if (item.type_menu === "up"){
                var lastIndex = index;
                index --;
                if(index < 0) {
                    index = App.menu.length -1
                    document.getElementById('scrolldiv').scrollTop = 90000;
                    }else{
                    document.getElementById('scrolldiv').scrollTop -= 33;
                }
                setActiveMenuIndex(index, true)

                $.post('https://rcore_arcade/selectNew', JSON.stringify({
                    index: App.menu[index].number,
                    identifier: App.identifier,
                    newIndex: App.menu[index].number,
                    oldIndex: App.menu[lastIndex].number,
                }));
            }

            if (item.type_menu === "down"){
                var lastIndex = index;
                index ++;
                if(index > App.menu.length -1) {
                    index = 0
                    document.getElementById('scrolldiv').scrollTop = 0;
                    }else{
                    document.getElementById('scrolldiv').scrollTop += 33;
                }

                setActiveMenuIndex(index, true)

                $.post('https://rcore_arcade/selectNew', JSON.stringify({
                    index: App.menu[index].number,
                    identifier: App.identifier,
                    newIndex: App.menu[index].number,
                    oldIndex: App.menu[lastIndex].number,
                }));
            }
		}
	})
});

// Input
$(function(){
    function display(bool) {
        AppInput.visible = bool;
    }
    display(false);
	window.addEventListener('message', function(event) {
        var item = event.data;

        if(item.type_menu === "title_input"){
            AppInput.titleMenu = item.title
        }

        if (item.type_menu === "ui_input"){
            display(item.status);
            if(item.properties){
                AppInput.float = item.properties.float;
                AppInput.position = item.properties.position;
                AppInput.ChooseText = item.properties.ChooseText;
                AppInput.CloseText = item.properties.CloseText;
            }
            AppInput.identifier = item.identifier;
        }
	})
});