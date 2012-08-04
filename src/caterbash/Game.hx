package caterbash;

import hopscotch.input.analogue.Joystick;
import hopscotch.input.digital.Button;
import hopscotch.Playfield;

class Game extends Playfield {
    var caterpillars:Array<Caterpillar>;

    public function new(joystick:Joystick, fireButton:Button) {
        super();

        caterpillars = [];
        for (i in 0...100) {
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
        if (frame % 120 == 0) {
            caterpillars[Std.int(frame/120)].start();
        }

        super.update(frame);
    }
}
