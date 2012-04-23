package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  import org.flixel.plugin.photonstorm.*;

  public class PlayState extends FlxState
  {
    private var wordGroup:WordGroup = new WordGroup();
    private var currentWordGroup:WordGroup;

    private var lanes:Array;
    private var bigLane:FlxGroup;

    private var background:FlxSprite;
    private var foreground:FlxSprite;
    private var headSprite:FlxSprite;

    private var currentWord:FlxBitmapFont;
    private var currentWordTaken:FlxBitmapFont;

    public static const FIRST_LANE_Y:Number = 85;
    public static const DEATH_ZONE:Number = 65;

    public override function create():void {
      FlxG.playMusic(Assets.GameplayMusic);
      FlxG.music.fadeIn(15);

      background = new FlxSprite(0,0);
      background.loadGraphic(Assets.Background, false, false, 320, 180);
      add(background);

      headSprite = new FlxSprite(0,0);
      headSprite.makeGraphic(DEATH_ZONE, FlxG.height, 0xff990000, true);
      add(headSprite);

      add(new EnemyLane(80, "Large"));
      add(new EnemyLane(105, "Small"));
      add(new EnemyLane(120, "Large"));
      add(new EnemyLane(145, "Small"));

      foreground = new FlxSprite(0,FlxG.height-22);
      foreground.loadGraphic(Assets.Foreground, false, false, 320, 22);
      add(foreground);

/*
      currentWord = new FlxBitmapFont(Assets.LettersBig, 16, 16, FlxBitmapFont.TEXT_SET10, 6, 0, 0);
			currentWord.setText("AMISSISSIPPI", true, 0, 8, FlxBitmapFont.ALIGN_CENTER, false);
      currentWord.x = currentWord.y = 0;
      currentWord.width = FlxG.width;
      add(currentWord);
*/
      add(G.wordGroupGroup);
    }

    public override function update():void {
      FlxG.log(G.wordGroup == null ? "null" : G.wordGroup.Word);

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
