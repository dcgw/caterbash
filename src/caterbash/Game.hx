package caterbash;

import hopscotch.input.analogue.Joystick;
import hopscotch.input.digital.Button;
import hopscotch.Playfield;

class Game extends Playfield {
    static inline var MAX_SHOTS = 100;
    static inline var SHOTS_AT_A_TIME = 1;
    static inline var SHOT_INTERVAL = 10;

    public var onCaterdeath:Void->Void;
    public var onGameOver:Void->Void;

    var fireButton:Button;

    var ship:Ship;

    var counter:Int;
    var caterpillarInterval:Int;

    var lastShotFrame:Int;
    var shotsQueued:Int;

    var caterpillars:Array<Caterpillar>;

    var shots:Array<Shot>;
    var shotIndex:Int;

    public function new(joystick:Joystick, fireButton:Button) {
        super();

        this.fireButton = fireButton;

        counter = 0;
        caterpillarInterval = 60;

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

        shots = [];
        for (i in 0...MAX_SHOTS) {
            var shot = new Shot();
            shots[i] = shot;
            addEntity(shot);
        }
        shotIndex = 0;

        ship = new Ship(joystick);
        addEntity(ship);
    }

    override public function begin(frame:Int) {
        counter = 0;
        ship.x = Main.WIDTH * 0.5;
        ship.y = Main.HEIGHT - 48;
        lastShotFrame = 0;
    }

    override public function update(frame:Int) {
        for (caterpillar in caterpillars) {
            var shipCollision = false;
            do {
                if (caterpillar.active) {
                    for (shot in shots) {
                        if (shot.active && caterpillar.collideEntity(shot)) {
                            caterpillar.die();
                            shot.destroy();
                            break;
                        }
                    }

                    if (caterpillar.collideEntity(ship)) {
                        ship.visible = false;
                        shipCollision = true;
                        break;
                    }
                }
            } while ((caterpillar = caterpillar.tail) != null);

            if (shipCollision) break;
        }

        if (counter % caterpillarInterval == 0) {
            var i = Std.int(counter/caterpillarInterval);
            if (i >= caterpillars.length) {
                i = 0;
                caterpillarInterval = Std.int(Math.max(caterpillarInterval * 0.25, 1));
                counter = 0;
            }
            caterpillars[i].start();
        }

        if (ship.visible) {
            if (fireButton.justPressed) {
                shotsQueued = SHOTS_AT_A_TIME;
            }

            if (shotsQueued > 0 && frame > lastShotFrame + SHOT_INTERVAL) {
                shots[shotIndex].fire(ship.x, ship.y);
                shotIndex = (shotIndex+1) % shots.length;
                --shotsQueued;
                lastShotFrame = frame;
            }
        }

        super.update(frame);

        ++counter;
    }
}