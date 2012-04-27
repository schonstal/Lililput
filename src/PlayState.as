package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  import org.flixel.plugin.photonstorm.*;

  public class PlayState extends FlxState
  {
    private var wordGroup:WordGroup = new WordGroup();
    private var timeTextGroup:WordGroup;

    private var lanes:Array;
    private var bigLane:FlxGroup;

    private var foreground:FlxSprite;
    private var gameOverSprite:FlxSprite;

    private var lifeBar:FlxSprite;
    private var lifeContainer:FlxSprite;
    private var finished:Boolean = false;

    private var finishTimer:Number = 0;

    private var timeText:FlxBitmapFont;
    private var timeTextTaken:FlxBitmapFont;

    private var restartWordGroup:WordGroup;

    public var onCreate:Function;

    public static const FIRST_LANE_Y:Number = 85;
    public static const DEATH_ZONE:Number = 65;
    public static const FINISH_TIME:Number = 0.7;
    public static const START_FADE_TIME:Number = 15;

    public override function create():void {
      G.init();
      FlxG.playMusic(Assets.GameplayMusic, 0);
      FlxG.music.fadeIn(START_FADE_TIME);

      var background:FlxSprite = new FlxSprite(0,0);
      background.loadGraphic(Assets.Stars, false, false, 320, 160);
      add(background);

      for(var b:int=3; b>=1; b--) {
        background = new FlxSprite(0,0);
        background.loadGraphic(Assets["Ground0"+b], false, false, 320, 180);
        add(background);
      }

      add(new EnemyLane(80, "Large", 15));

      background = new FlxSprite(92,103);
      background.loadGraphic(Assets.Shard01, false, false, 46, 16);
      add(background);

      add(new EnemyLane(105, "Small"));

      background = new FlxSprite(150,130);
      background.loadGraphic(Assets.Shard02, false, false, 36, 8);
      add(background);

      add(new EnemyLane(120, "Large", 22));
      add(new EnemyLane(145, "Small", 3.5));

      G.face = new FaceSprite();
      add(G.face);

      background = new FlxSprite(0,-55);
      background.loadGraphic(Assets.Helmet, false, false, 102, 235);
      add(background);

      foreground = new FlxSprite(0,FlxG.height-22);
      foreground.loadGraphic(Assets.Foreground, false, false, 320, 22);
      add(foreground);

      timeText = new FlxBitmapFont(Assets.Numbers, 8, 8, "0123456789'\"", 4, 0, 0);
			timeText.setText("00'00\"00", true, 0, 8, FlxBitmapFont.ALIGN_RIGHT, false);
      timeText.y = 4;
      timeText.x = FlxG.camera.width - 70;
      add(timeText);

      G.health = 1;

      lifeContainer = new FlxSprite(6,4);
      lifeContainer.loadGraphic(Assets.LifeContainer, false, false, 64, 10);
      add(lifeContainer);

      //BG: 0xffffd070
      lifeBar = new FlxSprite(15,6);
      lifeBar.makeGraphic(52, 6, 0xffd63838, true);
      add(lifeBar);

      add(G.wordGroupGroup);

      gameOverSprite = new FlxSprite(0,0);
      gameOverSprite.loadGraphic(Assets.FadeRed, false, false, 320, 180);
      gameOverSprite.alpha = 0;
      add(gameOverSprite);

      restartWordGroup = new WordGroup();
      restartWordGroup.init("RETSART".split(''), 128, 136, null,
        function():void {
          finished = true;
        });
      restartWordGroup.modal = true;

      if(onCreate != null) onCreate();
      FlxG.music.volume = 1;
    }

    private function timeString(time:Number):String {
      var tempTime:Number = time;
      var minutes:Number = Math.floor(tempTime/60);
      tempTime -= 60*minutes;
      var seconds:Number = Math.floor(tempTime);
      tempTime -= seconds;
      var milliseconds:Number = Math.floor(tempTime*100);
      return zeroPad(minutes) + "'" + zeroPad(seconds) + "\"" + zeroPad(milliseconds);
    }

    private function zeroPad(n:Number, zeroChar:String="0"):String {
      return (n < 10 ? zeroChar : "") + (n as int);
    }

    public override function update():void {
      lifeContainer.alpha = timeText.alpha = lifeBar.alpha = G.score/5;

      if(G.health > 0) {
        G.score += FlxG.elapsed;
        timeText.text = timeString(G.score); 
      }

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
      lifeBar.offset.x = (lifeBar.width - (lifeBar.width*lifeBar.scale.x))/2;
      if(lifeBar.scale.x < 0) lifeBar.exists = false;

      if(G.health <= 0 && gameOverSprite.alpha < 1) {
        for each(var w:WordGroup in G.wordGroupGroup.members) {
          for each(var letterSprite:LetterSprite in wordGroup.members) {
              letterSprite.exists = false;
          }
        }
        if(FlxG.timeScale == 1) {
          FlxG.music.stop();
          FlxG.music.destroy();
          G.wordGroup = null;
          G.api.kongregate.stats.submit("milliseconds_survived", Math.floor(G.score*100));
        }
        FlxG.timeScale = 0.1;
        gameOverSprite.alpha += FlxG.elapsed*3;
      } else if(gameOverSprite.alpha >= 1 && FlxG.timeScale < 1) {
        gameOverSprite.alpha = 1;
        FlxG.timeScale = 1;
        G.wordGroup = restartWordGroup;
        G.setHighScore();
        add(restartWordGroup);

        var gameOverTextSprite:FlxSprite = new FlxSprite(0,0);
        gameOverTextSprite.loadGraphic(Assets.GameOver, false, false, 320, 180);
        add(gameOverTextSprite);

        var scoreText:FlxBitmapFont;
        for(var i:int=0; i<10; i++) {
          scoreText = new FlxBitmapFont(Assets.Numbers, 8, 8, "0123456789'\".- ", 4, 0, 0);
          var rankText:String = zeroPad(i+1,"0") + '.';
          rankText += G.highScore[i] > 0 ? timeString(G.highScore[i]) : "--'--\"--";
          scoreText.setText(rankText, true, 0, 8, FlxBitmapFont.ALIGN_RIGHT, false);
          scoreText.y = 48 + i*8;
          scoreText.x = FlxG.camera.width/2 - 44;
          if(G.highScore[i] == G.score) {
            scoreText.replaceColor(0xffd63838, LetterSprite.ACTIVE_BORDER);
            scoreText.replaceColor(0xff000000, 0xffffffff);
          }
          add(scoreText);
        }
      }

      //This isn't an else because it could have just been set!
//      if(G.wordGroup != null) {
//        G.wordGroup.capture();
//      }
      super.update();
    }
  }
}
