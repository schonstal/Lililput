package 
{
  import org.flixel.*;

  public class EnemyShadow extends FlxSprite 
  {
    private var enemySprite:EnemySprite;

    public function EnemyShadow() {
      super(0,0);
      alpha = 0.75;
    }
    
    public function init(enemy:EnemySprite):void {
      enemySprite = enemy;
      exists = true;

      if(enemy is SmallEnemySprite) {
        loadGraphic(Assets.EnemyShadow, true, true, 16, 3);
        y = enemy.y + enemy.height - 2;
      } else {
        loadGraphic(Assets.FattyShadow, true, true, 18, 4);
        y = enemy.y + enemy.height - 2;
      }

    }

    public override function update():void {
      if(enemySprite is SmallEnemySprite) {
        x = enemySprite.x + 2;
      } else {
        x = enemySprite.x + 8;
      }
      super.update();
    }
  }
}
