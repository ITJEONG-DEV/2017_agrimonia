local widget = require "widget"

	saveB = widget.newButton(
	{
		width = 50,
		height = 50,
		x = 100,
		y = 100,
		defaultFile = "image/ui/UI_SAVEB.png",
        overFile = "image/ui/UI_SAVEO.png",
		onEvent = onSaveB,
		id = "save",
	})

	loadB = widget.newButton(
	{
		width = 50,
		height = 50,
		x = 150,
		y = 150,
		defaultFile = "image/ui/UI_LOADB.png",
		overFile = "image/ui/UI_LOADO.png",
		onEvent = onLoadB,
		id = "load",	
	})

	titleB = widget.newButton(
	{
		width = 50,
		height = 50,
		x = 200,
		y = 200,
		defaultFile = "image/ui/UI_TITLEB.png",
		overFile = "image/ui/UI_TITLEO.png",
		onEvent = onTitleB,
		id = "title",	
	})