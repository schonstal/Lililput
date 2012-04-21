package
{
  import org.flixel.*;
  import com.greensock.TweenLite;
  import com.greensock.easing.*; 

  public class PlayState extends FlxState
  {
    private var word:FlxText;

    public override function create():void {
      word = new FlxText(0,0,FlxG.width,randomWord());
      add(word);
    }

    public override function update():void {
      if(FlxG.keys.justPressed("SPACE")) word.text = randomWord();
      super.update();
    }

    private function randomWord():String {
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
      word = letters.join('');
      return word;
    }
  }
}
