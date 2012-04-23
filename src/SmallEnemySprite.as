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
      explosionFrames = [10,11,12,13,14,15,16,17,18,19,20,21,21,20,22,20,22,20,22,20,22];

      damage = 0.35;
      create();
    }
  }
}
