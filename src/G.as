package
{
    import org.flixel.*;

    public class G
    {
        public var _score:Number;
        public var _highScore:Array;
        public var _save:FlxSave;

        public var _api:KongApi;
        public var _words:Object;
        public var _alphabet:Array;
        public var _wordGroup:WordGroup;
        public var _wordGroupGroup:FlxGroup;
        public var _takenLetters:Object;
        public var _health:Number;

        //I konw tihs is bad; who caers? I'm tierd.
        public var _face:FaceSprite;

        private static var _instance:G = null;

        public function G() {
        }

        private static function get instance():G {
            if(_instance == null) {
              _instance = new G();
              init();
            }

            return _instance;
        }

        public static function init():void {
            _instance._score = 0;
            _instance.initializeWords();
            _instance._wordGroupGroup = new FlxGroup();
            _instance._takenLetters = {};

            _instance._save = new FlxSave();
            _instance._save.bind("gluliver-tarvels");
            if(_instance._save.data.highScore != null)
              _instance._highScore = instance._save.data.highScore;
            else
              _instance._highScore = [0,0,0,0,0,0,0,0,0,0];
        }

        public static function get score():Number {
            return instance._score;
        }

        public static function get highScore():Array {
          return instance._highScore;
        }

        public static function set score(value:Number):void {
            instance._score = value;
        }

        public static function setHighScore():void {
            if(instance._score > instance._highScore[9]) {
                instance._highScore.push(instance._score);
                instance._highScore.sort(Array.NUMERIC);
                instance._highScore.reverse();
                instance._highScore.pop();
                instance._save.data.highScore = instance._highScore;
            }
        }

        public static function get face():FaceSprite {
            return instance._face;
        }

        public static function set face(value:FaceSprite):void {
            instance._face = value;
        }

        public static function get health():Number {
            return instance._health;
        }

        public static function set health(value:Number):void {
            instance._health = value;
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

        public static function randomWord(minLength:Number = 4, maxLength:Number = 8):Array {
          //Grab a random word
          var length:Number = Math.floor((Math.random() * (maxLength-minLength)) + minLength);
          var wordBucket:Object = words[length]
          var startingLetter:String;
          var availableLetters:Array = [];
          for(var k:String in wordBucket) {
            if(instance._takenLetters[k] == null) {
              availableLetters.push(k);
            }
          }
          startingLetter = availableLetters[Math.floor(Math.random() * availableLetters.length)];
          if(startingLetter == null) return [];

          var word:String = wordBucket[startingLetter][Math.floor(Math.random() * wordBucket[startingLetter].length)];

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

        public static function pressedLetter(letter:String):void {
          if(G.health > 0 && wordGroup == null && instance._takenLetters[letter] != null) {
            wordGroup = instance._takenLetters[letter];
          }
        }

        public static function takeLetter(letter:String, wordGroup:WordGroup):void {
          instance._takenLetters[letter] = wordGroup;
        }

        public static function releaseLetter(letter:String):void {
          instance._takenLetters[letter] = null;
        }

        public function initializeWords():void {
          _alphabet = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ").split("");
          _words = {};

          for each(var word:String in Constants.WORDS) {
            var firstLetter:String = word.charAt(0);
            var length:int = word.length;

            if(_words[length] == null) _words[length] = {};
            if(_words[length][firstLetter] == null) _words[length][firstLetter] = [];

            _words[length][firstLetter].push(word);
          }
        }
    }
}
