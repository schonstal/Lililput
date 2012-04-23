package 
{
  import org.flixel.*;

  public class LargeExplosionSprite extends ExplosionSprite 
  {
    public function LargeExplosionSprite() {
      super();
      loadGraphic(Assets.Splosion, true, true, 24, 24, false);
      scale.x = scale.y = 2;
      offset.x = -6;
      offset.y = -5;
      addAnimation("splode", [0,1,2,3,4,5], 15, false);
    }
  }
}
