package
{
  import org.flixel.*;

  public class WordGroup extends FlxGroup
  {
    private var letters:Array;
    private var letterSprites:Array = [];
    private var letterIndex:Number = 0;

    private var anyJustPressed:Boolean = false;

    private var alpha:Number = 1;

    private var onCompleteCallbacks:Array = [];
    public var modal:Boolean = false;
    
    public var enemy:EnemySprite;

    public static const ALPHA_RATE:Number = 2;

    public function WordGroup() {
    }

    public function init(word:Array, X:Number, Y:Number, owner:EnemySprite, OnComplete:Function=null):void {
      letterIndex = 0;
      letters = word;
      anyJustPressed = false;
      enemy = owner;
      onCompleteCallbacks.push(OnComplete);
      alpha = (G.health > 0 ? 1 : 0);

      var i:int = 0;
      for each(var letter:String in word) {
        var letterSprite:LetterSprite = recycle(LetterSprite) as LetterSprite;
        letterSprite.init(letter, X, Y, word.length, i);
        add(letterSprite);
        letterSprites[i] = letterSprite;
        if(enemy != null && i == Math.floor((word.length/2) - 1)) {
          letterSprite.onFling = function():void { enemy.fling(); };
        }
        i++;
      }
    }

    public function addOnCompleteCallback(callback:Function):void {
      onCompleteCallbacks.push(callback);
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

      if(enemy != null) enemy.stop();
      //setAll("exists", false);
      for each(var callback:Function in onCompleteCallbacks) {
       if(callback is Function) callback();
      }
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

    public function get Word():String {
      return letters.join('');
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
      if(G.health <= 0 && !modal) {
        alpha -= FlxG.elapsed * ALPHA_RATE;
        setAll('alpha', alpha);
      }
      super.update();
    }
  }
}
