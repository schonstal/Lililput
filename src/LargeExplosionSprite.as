package 
{
  import org.flixel.*;

  public class LargeExplosionSprite extends ExplosionSprite 
  {
    public function LargeExplosionSprite() {
      super();
      //loadGraphic(Assets.Fatty, true, true, 32, 32, false);
      makeGraphic(32, 32, 0xff9944ff);
    }
  }
}
