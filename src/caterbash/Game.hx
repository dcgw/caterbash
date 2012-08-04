package caterbash;

import hopscotch.input.analogue.Joystick;
import hopscotch.input.digital.Button;
import hopscotch.Playfield;

class Game extends Playfield {
    public var onCaterdeath:Void->Void;
    public var onGameOver:Void->Void;

    var counter:Int;
    var interval:Int;

    var caterpillars:Array<Caterpillar>;

    public function new(joystick:Joystick, fireButton:Button) {
        super();

        counter = 0;
        interval = 120;

        caterpillars = [];
        for (i in 0...120) {
            var caterpillar:Caterpillar = null;
            var length = 3 + Std.int(i/6);
            for (j in 0...length) {
                var index = length - j - 1;
                caterpillar = new Caterpillar(caterpillar, index);
                addEntity(caterpillar);
            }
            caterpillars.push(caterpillar);
        }
    }

    override public function update(frame:Int) {
        if (counter % interval == 0) {
            var i = Std.int(counter/interval);
            if (i >= caterpillars.length) {
                i = 0;
                interval = Std.int(Math.max(interval * 0.25, 1));
                counter = 0;
            }
            caterpillars[i].start();
        }

        super.update(frame);

        ++counter;
    }
}
