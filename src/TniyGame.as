package
{
  import org.flixel.*;
  [SWF(width="1280", height="720", backgroundColor="#000000")]
  [Frame(factoryClass="Preloader")]

  public class TniyGame extends FlxGame
  {
    //[Embed(source = '../data/adore64.ttf', fontFamily="ack", embedAsCFF="false")] public var AckFont:String;
    public function TniyGame() {
      forceDebugger = true;
      FlxG.debug = true;
      super(320,180,MenuState,4,60);
    }
  }
}
