package 
{
  import org.flixel.*;

  public class SmallExplosionSprite extends ExplosionSprite 
  {
    public function SmallExplosionSprite() {
      super();
      //loadGraphic(Assets.Fatty, true, true, 32, 32, false);
      makeGraphic(16, 16, 0xff9944ff);
    }
  }
}
