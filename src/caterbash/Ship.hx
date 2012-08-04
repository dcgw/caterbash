package caterbash;

import hopscotch.collision.CircleMask;
import hopscotch.Entity;
import nme.installer.Assets;
import hopscotch.input.analogue.Joystick;
import hopscotch.graphics.Image;

class Ship extends Entity {
    static inline var SPEED = 6;

    var joystick:Joystick;

    public function new (joystick:Joystick) {
        super();

        this.joystick = joystick;

        var image = new Image(Assets.getBitmapData("assets/Ship.png"));
        image.centerOrigin();
        graphic = image;

        collisionMask = new CircleMask(0, 8, 10);
    }

    override public function update(frame:Int) {
        x += joystick.position.x * SPEED;
        y += joystick.position.y * SPEED;

        if (x < 24) {
            x = 24;
        } else if (x > Main.WIDTH - 24) {
            x = Main.WIDTH - 24;
        }

        if (y < 24) {
            y = 24;
        } else if (y > Main.HEIGHT - 24) {
            y = Main.HEIGHT - 24;
        }
    }
}
