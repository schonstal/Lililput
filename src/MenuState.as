package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  public class MenuState extends FlxState
  {
    private var background:FlxSprite;
    private var foreground:FlxSprite;
    private var headSprite:FlxSprite;

    private var startWordGroup:WordGroup;

    public static const START_Y:Number = -1000;

    public override function create():void {
      FlxG.camera.scroll.y = START_Y;

      background = new FlxSprite(0,0);
      background.loadGraphic(Assets.Background, false, false, 320, 180);
      add(background);

      headSprite = new FlxSprite(0,0);
      headSprite.makeGraphic(PlayState.DEATH_ZONE, FlxG.height, 0xff990000, true);
      add(headSprite);

      foreground = new FlxSprite(0,FlxG.height-22);
      foreground.loadGraphic(Assets.Foreground, false, false, 320, 22);
      add(foreground);

      startWordGroup = new WordGroup();
      startWordGroup.init("STRAT".split(''), 150, -900, null, function():void {
          TweenLite.to(FlxG.camera.scroll, 2, 
              {y: 0, ease: Quart.easeInOut,
              onComplete: function():void { 
                FlxG.switchState(new PlayState());
              }});
        });

      startWordGroup.modal = true;
      add(startWordGroup);
    }

    public override function update():void {
      startWordGroup.capture();
      super.update();
    }
  }
}
