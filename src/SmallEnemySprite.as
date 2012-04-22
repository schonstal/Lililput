package 
{
  import org.flixel.*;

  public class SmallEnemySprite extends EnemySprite 
  {
    public function SmallEnemySprite() {
      super();
      loadGraphic(Assets.Enemy, true, true, 16, 16, false);
      walkSpeed = 20;
      minSize = 4;
      maxSize = 7;
      lowVelocity = -200;
      baseAngular = 200;
      shakeAmount = 0.1;
      create();
    }
  }
}
