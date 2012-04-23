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
    private var gameOverSprite:FlxSprite;

    private var lifeBar:FlxSprite;
    private var finished:Boolean = false;

    private var finishTimer:Number = 0;

    private var currentWord:FlxBitmapFont;
    private var currentWordTaken:FlxBitmapFont;

    private var restartWordGroup:WordGroup;

    public var onCreate:Function;

    public static const FIRST_LANE_Y:Number = 85;
    public static const DEATH_ZONE:Number = 65;
    public static const FINISH_TIME:Number = 0.7;

    public override function create():void {
      G.init();
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

      G.health = 1;

      lifeBar = new FlxSprite(0,0);
      lifeBar.makeGraphic(DEATH_ZONE, 14, 0xffaa44ff, true);
      add(lifeBar);

      add(G.wordGroupGroup);

      gameOverSprite = new FlxSprite(0,0);
      gameOverSprite.loadGraphic(Assets.GameOver, false, false, 320, 180);
      gameOverSprite.alpha = 0;
      add(gameOverSprite);

      restartWordGroup = new WordGroup();
      restartWordGroup.init("RETSART".split(''), FlxG.camera.width/2 - 28, FlxG.camera.height * (2/3), null,
        function():void {
          finished = true;
        });

      if(onCreate != null) onCreate();
    }

    public override function update():void {
      if(finished) {
        finishTimer += FlxG.elapsed;
        if(finishTimer >= FINISH_TIME) {
          FlxG.fade(0xff000000, 2, function():void {
            var state:PlayState = new PlayState();
            state.onCreate = function():void {
              FlxG.flash(0xff000000, 2);
            }
            FlxG.switchState(state);
          });
        }
      }

      lifeBar.scale.x = G.health;
      lifeBar.offset.x = (DEATH_ZONE - (lifeBar.width*lifeBar.scale.x))/2;
      if(G.health <= 0 && gameOverSprite.alpha < 1) {
        if(FlxG.timeScale == 1) FlxG.music.stop();
        FlxG.timeScale = 0.1;
        gameOverSprite.alpha += FlxG.elapsed*3;
      } else if(gameOverSprite.alpha >= 1 && FlxG.timeScale < 1) {
        gameOverSprite.alpha = 1;
        FlxG.timeScale = 1;
        G.wordGroup = restartWordGroup;
        add(restartWordGroup);
      }

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
