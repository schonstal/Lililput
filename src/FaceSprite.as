package
{
  import org.flixel.*;

  public class FaceSprite extends FlxSprite
  {
    public var breathIndex:int=0;

    public var winceTimer:Number = 0;
    public var blowing:Boolean = false;


    public static const WINCE_TIME:Number = 0.5;
    public static const FRAMES:Object = {
      "idle": 0,
      "wince": 1,
      "breath": [2,3,4,5,6,7]
    };

    public function FaceSprite() {
      super(0,0);
      loadGraphic(Assets.Face, true, true, 64, 180); 
      addAnimation("blow", [8,9,9,9,8], 15, false);
    }

    public function wince():void {
      winceTimer = WINCE_TIME;
    }

    public function blow():void {
      play("blow");
      blowing = true;
    }

    public override function update():void {
      winceTimer -= FlxG.elapsed;

      if(blowing) {
        if(finished) blowing = false;
      } else if(winceTimer > 0) {
        frame = FRAMES.wince;
      } else if(G.wordGroup) {
        frame = FRAMES.breath[Math.floor(G.wordGroup.letterIndex/2)];
      } else {
        frame = FRAMES.idle;
      }
      super.update();
    }
  }
}

