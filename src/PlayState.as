package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  public class PlayState extends FlxState
  {
    private var wordGroup:WordGroup = new WordGroup();
    private var currentWordGroup:WordGroup;

    private var lanes:Array;
    private var bigLane:FlxGroup;

    public override function create():void {
      add(new EnemyLane());

      G.wordGroup = wordGroup;
      wordGroup.init(G.randomWord(), 0, 100);
      wordGroup.onComplete = function():void {
        wordGroup.init(G.randomWord(), 0, 100);
      }
      add(wordGroup);

      add(G.wordGroupGroup);
    }

    public override function update():void {
      G.wordGroup.capture();
      super.update();
    }
  }
}
