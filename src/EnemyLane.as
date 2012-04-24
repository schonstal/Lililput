package
{
  import org.flixel.*;
	import flash.utils.getDefinitionByName;
  
  public class EnemyLane extends FlxGroup
  {
    private var spawnTimer:Number = 0;
    private var spawnThreshold:Number = 2.0;
    private var y:Number = 0;
    private var enemyType:String;

    public var spawnMin:Object = {
      "Small": 2.15,
      "Large": 8
    };

    public var spawnMax:Object = {
      "Small": 3.95,
      "Large": 12.3
    }
    
    public static const HEIGHT:Number = 25;
    public static const MAX_DIFFICULTY_SECONDS:Number = 240;

    public function EnemyLane(Y:Number, type:String, offset:Number=0) {
      var thisIsSoStupid:Array = [
        SmallExplosionSprite,
        LargeExplosionSprite,
        SmallEnemySprite,
        LargeEnemySprite
      ];
      enemyType = type;
      spawnTimer = spawnThreshold * Math.random() * (enemyType == "Large" ? 3 : 1);
      y = Y;
      spawnTimer = offset;
    }

    public override function update():void {
      spawnTimer -= FlxG.elapsed;
      if(spawnTimer <= 0) {
        var spawnDiff:Number = spawnMax[enemyType] - spawnMin[enemyType];
        var spawnPercentage:Number = (G.score/MAX_DIFFICULTY_SECONDS);
        if(spawnPercentage > 1) spawnPercentage = 1;
        var spawnTime = spawnMin[enemyType] + (spawnDiff * spawnPercentage);

        spawnTimer = Math.random() * spawnThreshold * (enemyType == "Large" ? 3 : 1) + spawnMax[enemyType];

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
