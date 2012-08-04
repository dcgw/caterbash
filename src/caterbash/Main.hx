package caterbash;

import hopscotch.input.digital.Key;
import hopscotch.input.digital.Keyboard;
import hopscotch.engine.Engine;

class Main {
    public static inline var WIDTH = 640;
    public static inline var HEIGHT = 480;
    public static inline var LOGIC_RATE = 60;

    public static function main() {
        var keyboard = new Keyboard();
        var joystick = keyboard.joystickForKeys(Key.Up, Key.Down, Key.Left, Key.Right);
        var fireButton = keyboard.buttonForKey(Key.X);

        var engine = new Engine(flash.Lib.current, WIDTH, HEIGHT, LOGIC_RATE);
        engine.inputs.push(joystick);
        engine.inputs.push(fireButton);

        var title = new Title(fireButton);
        var game = new Game(joystick, fireButton);
        //var gameOver = new GameOver();

        title.onPlay = function() {
            engine.playfield = game;
        };

        //game.onGameOver = onGameOver;

        //gameOver.onDone = onGameOverDone;

        engine.playfield = title;
        engine.start();
    }
}
