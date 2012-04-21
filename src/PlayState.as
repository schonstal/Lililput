package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  public class PlayState extends FlxState
  {
    var insert_game:FlxText;

    public override function create():void {
      insert_game = new FlxText(0,0,FlxG.width,"INSERT GAME");
      add(insert_game);
    }

    public override function update():void {
      super.update();
    }
  }
}
