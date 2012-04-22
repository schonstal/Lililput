package
{
  import org.flixel.*;
	import flash.utils.getDefinitionByName;
  
  public class EnemyLane extends FlxGroup
  {
    private var spawnTimer:Number = 0;
    private var spawnThreshold:Number = 5.0;
    private var y:Number = 0;
    private var enemyType:String;

    public static const SPAWN_MIN:Object = {
      "Small": 5.0,
      "Large": 10.0
    }
    
    public static const HEIGHT:Number = 25;

    public function EnemyLane(Y:Number, type:String) {
      var thisIsSoStupid:Array = [
        SmallExplosionSprite,
        LargeExplosionSprite,
        SmallEnemySprite,
        LargeEnemySprite
      ];
      enemyType = type;
      spawnTimer = spawnThreshold * Math.random() * (enemyType == "Large" ? 3 : 1);
      y = Y;
    }

    public override function update():void {
      spawnTimer -= FlxG.elapsed;
      if(spawnTimer <= 0) {
        spawnTimer = Math.random() * spawnThreshold * (enemyType == "Large" ? 3 : 1) + SPAWN_MIN[enemyType];

        var enemyClass:Class = getDefinitionByName(enemyType + "EnemySprite") as Class;
        var enemyShadow:EnemyShadow = recycle(EnemyShadow) as EnemyShadow;
        var enemy:EnemySprite = (recycle(enemyClass) as EnemySprite);
        enemy.shadow = enemyShadow;
        enemy.lane = this;

        enemy.init(y);
        enemyShadow.init(enemy);

        add(enemyShadow);
        add(enemy);
      }
      super.update();
    }

    public function onExplode(X:Number, Y:Number):void {
      if(enemyType == "Large") {
        var fuckYouLarge:LargeExplosionSprite = new LargeExplosionSprite();
        fuckYouLarge.init(X,Y);
        add(fuckYouLarge);
      } else {
        var fuckYouSmall:SmallExplosionSprite = new SmallExplosionSprite();
        fuckYouSmall.init(X,Y);
        add(fuckYouSmall);
      }
    }
  }
}
