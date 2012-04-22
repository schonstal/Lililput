package
{
    import org.flixel.*;

    public class G
    {
        public var _score:Number;
        public var _api:KongApi;
        public var _words:Object;
        public var _alphabet:Array;
        public var _wordGroup:WordGroup;
        public var _wordGroupGroup:FlxGroup;

        private static var _instance:G = null;

        public function G() {
        }

        private static function get instance():G {
            if(_instance == null) {
                _instance = new G();
                _instance._score = 0;
                _instance.initializeWords();
                _instance._wordGroupGroup = new FlxGroup();
            }

            return _instance;
        }

        public static function get score():Number {
            return instance._score;
        }

        public static function set score(value:Number):void {
            instance._score = value;
        }

        public static function get api():KongApi {
            return instance._api;
        }

        public static function set api(value:KongApi):void {
            instance._api = value;
        }

        public static function get wordGroup():WordGroup {
            return instance._wordGroup;
        }

        public static function set wordGroup(value:WordGroup):void {
            instance._wordGroup = value;
        }

        public static function get wordGroupGroup():FlxGroup {
          return instance._wordGroupGroup;
        }

        public static function get words():Object {
          return instance._words;
        }

        public static function get alphabet():Array {
          return instance._alphabet;
        }

        public static function randomWord():Array {
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

        public function initializeWords():void {
          _alphabet = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ").split("");
          _words = {};

          for each(var word:String in Constants.WORDS) {
            var firstLetter:String = word.charAt(0);
            var length:int = word.length;

            if(_words[length] == null) _words[length] = [];
            if(_words[length][firstLetter] == null) _words[length][firstLetter] = [];

            _words[length][firstLetter].push(word);
          }
        }
    }
}
