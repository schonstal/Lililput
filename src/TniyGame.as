package
{
  import org.flixel.*;
  [SWF(width="640", height="360", backgroundColor="#000000")]
  [Frame(factoryClass="Preloader")]

  public class TniyGame extends FlxGame
  {
    //[Embed(source = '../data/adore64.ttf', fontFamily="ack", embedAsCFF="false")] public var AckFont:String;
    public function TniyGame() {
      forceDebugger = true;
      FlxG.debug = true;
      super(320,180,BadingState,2,60);
    }
  }
}
