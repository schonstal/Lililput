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
    public static const EXPLOSION_DELAY_MIN:Number = 0.3;
    public static const EXPLOSION_ANGULAR:Number = 300;

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
      play(letter);

      x = centerX - ((wordSize * WIDTH)/2.0) + (position*WIDTH);
    }

    public function calculatePosition():void {
      offset.x = (shaking ? Math.random() * SHAKE_AMOUNT : 0);
      offset.y = (shaking ? Math.random() * SHAKE_AMOUNT : 0);
    }

    public function onDown():void {
      replaceColor(0xff0000aa, 0xffff00ff);
      shaking = true;
    }

    public function explode():void {
      readyToExplode = true;
    }

    public override function update():void {
      if(!exploding) {
        calculatePosition();
      } 
      if(readyToExplode && !exploding) {
        explosionTimer += FlxG.elapsed;
        if(explosionTimer >= EXPLOSION_DELAY * position + EXPLOSION_DELAY_MIN) {
          velocity.x = Math.random() * EXPLOSION_X + EXPLOSION_X_MIN;
          velocity.y = Math.random() * EXPLOSION_Y + EXPLOSION_Y_MIN;
          angularVelocity = Math.random() * EXPLOSION_ANGULAR;
          exploding = true;
          if(onFling != null) onFling();
        }
      }
      if(exploding && x > FlxG.camera.width) exists = false;
      super.update();
    }
  }
}
