package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  public class PlayState extends FlxState
  {
    private var wordGroup:WordGroup = new WordGroup();
    private var currentWordGroup:WordGroup;

    private var lanes:Array;
    private var bigLane:FlxGroup;

    private var background:FlxSprite;
    private var foreground:FlxSprite;
    private var footprintSprite:FlxSprite;
    private var smallFootSprite:FlxSprite;

    public static const FIRST_LANE_Y:Number = 100;

    public override function create():void {
      background = new FlxSprite(0,0);
      background.loadGraphic(Assets.Background, false, false, 320, 180);
      add(background);

      footprintSprite = new FlxSprite(0,0);
      footprintSprite.makeGraphic(FlxG.width, FlxG.height, 0x00000000, true);
      add(footprintSprite);

      smallFootSprite = new FlxSprite(0,0);
      smallFootSprite.makeGraphic(1,1,0x44000000);

      for(var i:Number = FIRST_LANE_Y; i < FlxG.height - EnemyLane.HEIGHT; i += EnemyLane.HEIGHT) {
        add(new EnemyLane(i));
      }

      add(G.wordGroupGroup);

      foreground = new FlxSprite(0,FlxG.height-22);
      foreground.loadGraphic(Assets.Foreground, false, false, 320, 22);
      add(foreground);
    }

    public function footPrint(X:Number, Y:Number):void {
      footprintSprite.stamp(smallFootSprite, X, Y);
    }

    public override function update():void {
      if(G.wordGroup == null) {
        for each(var letter:String in G.alphabet) {
          if(FlxG.keys.justPressed(letter)) {
            G.pressedLetter(letter);
          }
        }
      } 
      //This isn't an else because it could have just been set!
      if(G.wordGroup != null) {
        G.wordGroup.capture();
      }
      super.update();
    }
  }
}
