package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  public class MenuState extends FlxState
  {
    private var foreground:FlxSprite;
    private var headSprite:FlxSprite;

    private var startWordGroup:WordGroup;

    public static const START_Y:Number = -1000;

    public override function create():void {
      FlxG.camera.scroll.y = START_Y;

      var background:FlxSprite = new FlxSprite(0,0);
      background.loadGraphic(Assets.Stars, false, false, 320, 160);
      add(background);

      for(var b:int=3; b>=1; b--) {
        background = new FlxSprite(0,0);
        background.loadGraphic(Assets["Ground0"+b], false, false, 320, 180);
        add(background);
      }

      background = new FlxSprite(92,103);
      background.loadGraphic(Assets.Shard01, false, false, 46, 16);
      add(background);

      background = new FlxSprite(150,130);
      background.loadGraphic(Assets.Shard02, false, false, 36, 8);
      add(background);

      G.face = new FaceSprite();
      add(G.face);

      background = new FlxSprite(0,-55);
      background.loadGraphic(Assets.Helmet, false, false, 102, 235);
      add(background);

      foreground = new FlxSprite(0,FlxG.height-22);
      foreground.loadGraphic(Assets.Foreground, false, false, 320, 22);
      add(foreground);

      startWordGroup = new WordGroup();
      startWordGroup.init("STRAT".split(''), 150, -900, null, function():void {
          TweenLite.to(FlxG.camera.scroll, 5, 
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
      if(!G.api) (G.api = FlxG.stage.addChild(new KongApi()) as KongApi).init();
      super.update();
    }
  }
}
