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

    public static const START_Y:Number = -360;

    public override function create():void {
      FlxG.camera.scroll.y = START_Y;
      FlxG.flash(0xff000000, 1);

      var background:FlxSprite;
      
      for(var i:int=0; i<4; i++) {
        background = new FlxSprite(0,-160*i);
        background.loadGraphic(Assets.Stars, false, false, 320, 160);
        add(background);
        background.scrollFactor.y = 0.5;
      }

      background = new FlxSprite(0,START_Y);
      background.loadGraphic(Assets.Title, false, false, 320, 160);
      add(background);

      background = new FlxSprite(0,0);
      background.loadGraphic(Assets["Ground03"], false, false, 320, 180);
      add(background);
      background.scrollFactor.y = 0.7;

      background = new FlxSprite(0,0);
      background.loadGraphic(Assets["Ground02"], false, false, 320, 180);
      add(background);
      background.scrollFactor.y = 0.8;

      background = new FlxSprite(0,0);
      background.loadGraphic(Assets["Ground01"], false, false, 320, 180);
      add(background);
      background.scrollFactor.y = 0.9;

      background = new FlxSprite(92,103);
      background.loadGraphic(Assets.Shard01, false, false, 46, 16);
      add(background);
      background.scrollFactor.y = 0.9;

      background = new FlxSprite(150,130);
      background.loadGraphic(Assets.Shard02, false, false, 36, 8);
      add(background);
      background.scrollFactor.y = 0.9;

      G.face = new FaceSprite();
      add(G.face);

      background = new FlxSprite(0,-55);
      background.loadGraphic(Assets.Helmet, false, false, 102, 235);
      add(background);
      background.scrollFactor.y = 0.95;

      foreground = new FlxSprite(0,FlxG.height-22);
      foreground.loadGraphic(Assets.Foreground, false, false, 320, 22);
      add(foreground);

      startWordGroup = new WordGroup();
      startWordGroup.init("LILILPUT".split(''), 144, START_Y + 112, null, function():void {
          TweenLite.to(FlxG.camera.scroll, 5, 
              {y: 0, ease: Quart.easeInOut,
              onComplete: function():void { 
                FlxG.switchState(new PlayState());
              }});
        });

      G.wordGroup = startWordGroup;
      startWordGroup.modal = true;
      add(startWordGroup);
    }

    public override function update():void {
      if(!G.api) (G.api = FlxG.stage.addChild(new KongApi()) as KongApi).init();
      super.update();
    }
  }
}
