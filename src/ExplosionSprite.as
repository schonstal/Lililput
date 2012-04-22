package 
{
  import org.flixel.*;

  public class ExplosionSprite extends FlxSprite 
  {
    public static const FADE_RATE:Number = 1;

    public function ExplosionSprite() {
      super(0,0);
    }

    public function init(X:Number, Y:Number):void {
      x = X;
      y = Y;
      alpha = 1;
    }

    public override function update():void {
      alpha -= FlxG.elapsed * FADE_RATE;
      scale.x = scale.y = alpha;
      if(alpha <= 0) exists = false;
      super.update();
    }
  }
}
