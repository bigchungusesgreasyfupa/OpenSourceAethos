import funkin.menus.TitleState;
import funkin.menus.FreeplayState;
import funkin.options.OptionsMenu;
import funkin.menus.credits.CreditsMain;

var bg:FlxSprite;
var ateball:FlxSprite;
var optionSpr:FlxSprite;

var curSelected:Int = 0;
var selectedSomethin:Bool = false;

function create()
{
	bg = new FlxSprite().loadGraphic(Paths.image("menus/main/bg1"));
	add(bg);
	
	ateball = new FlxSprite().loadGraphic(Paths.image("menus/main/8ball"));
	add(ateball);
	
	optionSpr = new FlxSprite().loadGraphic(Paths.image("menus/main/option"+curSelected));
	add(optionSpr);
}

function update(elapsed:Float)
{
	if (selectedSomethin)
		return;
	
	var upP = controls.UP_P;
	var downP = controls.DOWN_P;
	
	var leftP = controls.LEFT_P;
	var rightP = controls.RIGHT_P;
	
	if (upP || leftP)
	{
		changeSelected(-1);
	}
	
	if (downP || rightP)
	{
		changeSelected(1);
	}
	
	if (controls.BACK)
		FlxG.switchState(new TitleState());
	
	if (controls.ACCEPT)
		select();
}

function changeSelected(change:Int = 0)
{
	curSelected += change;
	curSelected = FlxMath.wrap(curSelected, 0, 2);
	optionSpr.loadGraphic(Paths.image("menus/main/option"+curSelected));
	CoolUtil.playMenuSFX(0);
}

function select()
{
	selectedSomethin = true;
	CoolUtil.playMenuSFX(1);
	
	for (i in [bg, ateball, optionSpr])
	{
		FlxTween.color(i, 1.1, FlxColor.WHITE, FlxColor.BLACK, {ease: FlxEase.easeOutCirc});
		//FlxTween.tween(i.scale, {x: 0.0, y: 0.0}, 1.1);
	}
	
	new FlxTimer().start(1.1, ()->{
		switch (curSelected)
		{
			case 0: FlxG.switchState(new FreeplayState());
			case 1: FlxG.switchState(new CreditsMain());
			case 2: FlxG.switchState(new OptionsMenu());
		}
	});
}