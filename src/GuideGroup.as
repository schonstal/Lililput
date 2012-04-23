package
{
  import org.flixel.*;

  public class GuideGroup extends FlxGroup
  {
    private var letters:Array;
    private var letterSprites:Array = [];
    private var letterIndex:Number = 0;

    private var anyJustPressed:Boolean = false;

    public var onComplete:Function;
    
    public var enemy:EnemySprite;

    public function GuideGroup() {
    }

    public function init(word:Array, X:Number, Y:Number, owner:EnemySprite):void {
      letterIndex = 0;
      letters = word;
      anyJustPressed = false;
      enemy = owner;

      var i:int = 0;
      for each(var letter:String in word) {
        var letterSprite:LetterSprite = recycle(LetterSprite) as LetterSprite;
        letterSprite.init(letter, X, Y, word.length, i);
        add(letterSprite);
        letterSprites[i] = letterSprite;
        if(i == Math.floor((word.length/2) - 1)) {
          letterSprite.onFling = function():void { enemy.fling(); };
        }
        i++;
      }
    }

    //Eventually, this will be an explosion
    public function complete():void {
      //recycle or something
      letterIndex = 0;
      for each(var s:LetterSprite in letterSprites) {
        s.explode();
      }
      if(this == G.wordGroup) G.wordGroup = null;
      G.releaseLetter(letters[0]);
      enemy.stop();
      //setAll("exists", false);
      //if(onComplete != null) onComplete();
    }

    public function prepareToDie():void {
      G.releaseLetter(letters[0]);
      if(this == G.wordGroup) G.wordGroup = null;
      for each(var letterSprite:LetterSprite in members) {
        letterSprite.prepareToDie();
      }
    }

    public function set xVelocity(value:Number):void {
      for each(var letterSprite:LetterSprite in members) {
        letterSprite.velocity.x = value;
      }
    }

    public function capture():void {
      if(FlxG.keys.justPressed(letters[letterIndex])) {
        letterSprites[letterIndex].onDown();
        letterIndex++;
        if(letterIndex >= letters.length) {
          complete();
        }
        anyJustPressed = true;
      } else if(FlxG.keys.any() && !anyJustPressed) {
        anyJustPressed = true;
        FlxG.shake(0.01, 0.1);
      } else if(!FlxG.keys.any()) {
        anyJustPressed = false;
      }

    }

    public override function update():void {
      super.update();
    }
  }
}
