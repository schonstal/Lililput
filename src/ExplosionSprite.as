package 
{
  import org.flixel.*;

  public class ExplosionSprite extends FlxSprite 
  {
    public function ExplosionSprite() {
      super(0,0);
    }

    public function init(X:Number, Y:Number):void {
      x = X;
      y = Y;
      exists = true;
      play("splode");
    }

    public override function update():void {
      if(finished) exists = false;
      super.update();
    }
  }
}
