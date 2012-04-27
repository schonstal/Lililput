package
{
  import org.flixel.*;
  import flash.events.KeyboardEvent;

  public class WordGroup extends FlxGroup
  {
    private var letters:Array;
    private var letterSprites:Array = [];
    public var letterIndex:Number = 0;

    private var alpha:Number = 1;

    private var onCompleteCallbacks:Array = [];
    public var modal:Boolean = false;
    
    public var enemy:EnemySprite;

    private var x:Number;
    private var y:Number;

    public static const ALPHA_RATE:Number = 2;

    public function WordGroup() {
    }

    public function init(word:Array, X:Number, Y:Number, owner:EnemySprite, OnComplete:Function=null):void {
      letterIndex = 0;
      letters = word;
      enemy = owner;
      onCompleteCallbacks.push(OnComplete);
      alpha = (G.health > 0 ? 1 : 0);
      alive = true;
      letterSprites = [];
      x = X;
      y = Y;

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
      alive = false;

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

    public function capture(keyboardEvent:KeyboardEvent):void {
      if(alive && (this == G.wordGroup || G.wordGroup == null)) {
        if(FlxG.keys.getKeyCode(letters[letterIndex]) == keyboardEvent.keyCode) {
          FlxG.play(Assets.Right,0.2);
          letterSprites[letterIndex].onDown();
          letterIndex++;
          if(letterIndex >= letters.length) {
            complete();
            if(G.face) G.face.blow(letters.length);
          } 
        } else if(G.wordGroup != null){
          FlxG.play(Assets.Wrong,0.4);
          FlxG.shake(0.01, 0.1);
          if(FlxG.keys.getKeyCode("BACKSPACE") == keyboardEvent.keyCode) {
            for each(var letter:LetterSprite in letterSprites) {
              letter.exists = false;
            }
            if(enemy != null) {
              G.wordGroup = null;
              init(letters, enemy.x+(enemy.width/2), enemy.y-LetterSprite.WIDTH + enemy.letterOffset, enemy);
              xVelocity = enemy.velocity.x;
            } else {
              init(letters, x, y, null);
            }
          }
        } 
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
