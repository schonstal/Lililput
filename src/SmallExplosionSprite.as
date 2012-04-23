package 
{
  import org.flixel.*;

  public class SmallExplosionSprite extends ExplosionSprite 
  {
    public function SmallExplosionSprite() {
      super();
      loadGraphic(Assets.Splosion, true, true, 24, 24, false);
      offset.x = 1;
      offset.y = 3;
      addAnimation("splode", [0,1,2,3,4,5], 15, false);
    }
  }
}
