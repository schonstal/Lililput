package
{
    import org.flixel.*;

    public class G
    {
        public var _score:Number;
        public var _api:KongApi;
        public var _words:Object;
        public var _alphabet:Array;

        private static var _instance:G = null;

        public function G() {
        }

        private static function get instance():G {
            if(_instance == null) {
                _instance = new G();
                _instance._score = 0;
                _instance.initializeWords();
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

        public static function get words():Object {
          return instance._words;
        }

        public static function get alphabet():Array {
          return instance._alphabet;
        }

        public function initializeWords():void {
          _alphabet = ("ABCDEFGHIJKLMNOPQRSTUVWXYZ").split("");
          for each(letter:String in alphabet) {
            _words[letter] = new Array();
          }
          for each(word:String in Constants.WORDS) {
            _words[word[0]].push(word);
          }
        }
    }
}
