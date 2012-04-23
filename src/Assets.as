package
{
  import org.flixel.*;

  public class Assets
  {
    [Embed(source = "../data/letters.png")] public static var Letters:Class;
    [Embed(source = "../data/lettersBig.png")] public static var LettersBig:Class;
    [Embed(source = "../data/enemy.png")] public static var Enemy:Class;
    [Embed(source = "../data/enemyShadow.png")] public static var EnemyShadow:Class;
    [Embed(source = "../data/fatty.png")] public static var Fatty:Class;
    [Embed(source = "../data/fattyShadow.png")] public static var FattyShadow:Class;
    [Embed(source = "../data/foreground.png")] public static var Foreground:Class;
    [Embed(source = "../data/gameOver.png")] public static var GameOver:Class;

    [Embed(source = "../data/numbers.png")] public static var Numbers:Class;

    
    //Background
    [Embed(source = "../data/ground01.png")] public static var Ground01:Class;
    [Embed(source = "../data/ground02.png")] public static var Ground02:Class;
    [Embed(source = "../data/ground03.png")] public static var Ground03:Class;
    [Embed(source = "../data/stars.png")] public static var Stars:Class;

    [Embed(source = "../data/helmet.png")] public static var Helmet:Class;
    [Embed(source = "../data/shard01.png")] public static var Shard01:Class;
    [Embed(source = "../data/shard02.png")] public static var Shard02:Class;

    [Embed(source = "../data/face.png")] public static var Face:Class;

    [Embed(source = "../data/music.swf", symbol="gameplayMusic")] public static var GameplayMusic:Class;
  }
}
