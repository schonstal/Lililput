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
      wordGroup.init(randomWord(), 0, 100);
      wordGroup.onComplete = function():void {
        wordGroup.init(randomWord(), 0, 100);
      }
      add(wordGroup);
    }

    public override function update():void {
      G.wordGroup.capture();
      super.update();
    }

    private function randomWord():Array {
      //Grab a random word
      var word:String = Constants.WORDS[Math.floor(Math.random() * Constants.WORDS.length)];

      //Go through each letter that's not the first, pick a random one, then swap
      var letters:Array = word.split('');
      var letterIndex:int = Math.ceil(Math.random() * (letters.length - 2));
      for (var i:int=1; i<letters.length-1; i++) {
        if(letters[i] != letters[letterIndex]) {
          var letter:String = letters[i];
          letters[i] = letters[letterIndex];
          letters[letterIndex] = letter;
          break;
        }
      }
      return letters;
    }
  }
}
