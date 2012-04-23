package
{
  import org.flixel.*;

  public class LetterSprite extends FlxSprite
  {
    private var letters:Array;
    private var letterIndex:Number = 0;
    private var position:Number = 0;
    private var originY:Number = 0;

    private var shaking:Boolean = false;
    private var exploding:Boolean = false;
    private var readyToExplode:Boolean = false;
    private var preparingToDie:Boolean = false;

    public var centerX:Number = 0;
    public var wordSize:Number = 0;

    private var explosionTimer:Number = 0;

    public var onFling:Function;

    public static const WIDTH:Number = 8;
    public static const SHAKE_AMOUNT:Number = 2;
    public static const EXPLOSION_DELAY:Number = 0.05;
    public static const EXPLOSION_X:Number = 200;
    public static const EXPLOSION_Y:Number = -400;
    public static const EXPLOSION_X_MIN:Number = 400;
    public static const EXPLOSION_Y_MIN:Number = -200;
    public static const EXPLOSION_DELAY_MIN:Number = 0.15;
    public static const EXPLOSION_ANGULAR:Number = 300;

    public static const ACTIVE_BORDER:uint = 0xffffffff;
    public static const INACTIVE_BORDER:uint = 0xff444444;

    public static const READY_LETTER:uint = 0xff0000aa;
    public static const ACTIVE_LETTER:uint = 0xffff00ff;
    public static const INACTIVE_LETTER:uint = 0xff440000;

    public function LetterSprite() {
      super(-WIDTH,-WIDTH);
      loadGraphic(Assets.Letters, true, false, 8, 8, true);

      var frame:int = 0;
      for each(var l:String in G.alphabet) {
        addAnimation(l, [frame]);
        frame++;
      }
    }

    public function init(letter:String, CenterX:Number, Y:Number, WordSize:Number, Position:Number):void {
      replaceColor(0xffff00ff, 0xff0000aa);
      originY = y = Y;
      centerX = CenterX;
      wordSize = WordSize;
      position = Position;
      exists = true;
      shaking = false;
      exploding = false;
      readyToExplode = false;
      preparingToDie = false;
      acceleration.y = 0;
      angle = 0;
      angularVelocity = 0;
      velocity.y = velocity.x = 0;
      play(letter);

      replaceColor(INACTIVE_LETTER, READY_LETTER);
      replaceColor(INACTIVE_BORDER, ACTIVE_BORDER);

      x = centerX - ((wordSize * WIDTH)/2.0) + (position*WIDTH);
    }

    public function calculatePosition():void {
      if(!preparingToDie) {
        offset.x = (shaking ? Math.random() * SHAKE_AMOUNT : 0);
        offset.y = (shaking ? Math.random() * SHAKE_AMOUNT : 0);
      }
    }

    public function onDown():void {
      replaceColor(READY_LETTER, ACTIVE_LETTER);
      shaking = true;
    }

    public function prepareToDie():void {
      replaceColor(READY_LETTER, INACTIVE_LETTER);
      replaceColor(ACTIVE_LETTER, INACTIVE_LETTER);
      replaceColor(ACTIVE_BORDER, INACTIVE_BORDER);
      preparingToDie = true;
      velocity.x = 0;
    }

    public function explode():void {
      readyToExplode = true;
    }

    public override function update():void {
      if(!exploding) {
        calculatePosition();
      } 
      if(readyToExplode && !exploding) {
        if(preparingToDie) {
          exploding = true;
          var direction:Number = Math.random() > 0.5 ? 1 : -1;
          velocity.x = (Math.random() * 50 + 50) * direction;
          velocity.y = Math.random() * -50 - 50;
          acceleration.y = 600;
          angularVelocity = (Math.random() * EXPLOSION_ANGULAR + 500) * direction;
        } else {
          explosionTimer += FlxG.elapsed;
          if(explosionTimer >= EXPLOSION_DELAY * position + 
              (x/FlxG.width) * EXPLOSION_DELAY_MIN) {
            velocity.x = Math.random() * EXPLOSION_X + EXPLOSION_X_MIN;
            velocity.y = Math.random() * EXPLOSION_Y + EXPLOSION_Y_MIN;
            angularVelocity = Math.random() * EXPLOSION_ANGULAR;
            exploding = true;
            if(onFling != null) onFling();
          }
        }
      }

      if(exploding && !onScreen()) exists = false;
      super.update();
    }
  }
}
