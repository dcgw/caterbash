package caterbash;

import hopscotch.collision.CircleMask;
import hopscotch.math.VectorMath;
import flash.geom.Point;
import nme.installer.Assets;
import hopscotch.graphics.Image;
import hopscotch.Entity;

class Shot extends Entity {
    static inline var SPEED = 8;
    static inline var ANGLE_VARIANCE = Math.PI * 0.04;

    var image:Image;
    var velocity:Point;
    var angularVelocity:Float;

    public function new() {
        super();

        active = false;
        visible = false;

        image = new Image(Assets.getBitmapData("assets/Shot.png"));
        image.centerOrigin();

        graphic = image;

        velocity = new Point();

        angularVelocity = Math.PI/360 + Math.random() * Math.PI / 60;
        if (Math.random() < 0.5) angularVelocity = -angularVelocity;

        collisionMask = new CircleMask(0, 0, 11);
    }

    public function fire(x:Float, y:Float) {
        this.x = x;
        this.y = y;

        velocity.x = 0;
        velocity.y = -SPEED;
        VectorMath.rotate(velocity, Math.random() * ANGLE_VARIANCE - ANGLE_VARIANCE * 0.5);

        visible = true;
        active = true;
    }

    public function destroy() {
        visible = false;
        active = false;
    }

    override public function update(frame:Int) {
        x += velocity.x;
        y += velocity.y;

        if (y < -48) {
            active = false;
            visible = false;
        }

        image.angle += angularVelocity;
    }
}
