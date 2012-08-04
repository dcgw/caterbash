package caterbash;

import hopscotch.input.analogue.Joystick;
import hopscotch.input.digital.Button;
import hopscotch.Playfield;

class Game extends Playfield {
    var caterpillars:Array<Caterpillar>;

    public function new(joystick:Joystick, fireButton:Button) {
        super();

        caterpillars = [];
        for (i in 5...26) {
            var caterpillar:Caterpillar = null;
            for (j in 0...i) {
                var index = i - j - 1;
                caterpillar = new Caterpillar(caterpillar, index);
                addEntity(caterpillar);
            }
            caterpillars.push(caterpillar);
        }
    }
}
