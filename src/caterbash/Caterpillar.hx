package caterbash;

import hopscotch.math.VectorMath;
import flash.geom.Point;
import nme.installer.Assets;
import hopscotch.graphics.Image;
import hopscotch.Entity;

class Caterpillar extends Entity {
    static inline var NUM_PREVIOUS_POSITIONS = 12;

    var tail:Caterpillar;
    var isHead:Bool;
    var velocity:Point;

    var previousPositions:Array<Point>;
    var previousPositionIndex:Int;

    public function new(tail:Caterpillar, index:Int) {
        super();

        this.tail = tail;
        isHead = index == 0;

        active = false;
        visible = false;

        var image = if (isHead) new Image(Assets.getBitmapData("assets/Caterhead.png"));
        else if (index % 2 == 1) new Image(Assets.getBitmapData("assets/Caterbody1.png"));
        else new Image(Assets.getBitmapData("assets/Caterbody2.png"));

        image.centerOrigin();
        graphic = image;

        previousPositions = [];
        for (i in 0...NUM_PREVIOUS_POSITIONS) {
            previousPositions.push(new Point());
        }
        previousPositionIndex = 0;

        velocity = new Point();
        randomStartPosition();
        randomDirection();
    }

    public function start() {
        active = true;
        visible = true;
        randomStartPosition();
        randomDirection();
        var node = this;
        while ((node = node.tail) != null) {
            node.x = x;
            node.y = y;
            node.randomDirection();
            node.active = true;
            node.visible = true;
        }
    }

    public function die() {
        active = false;
        visible = false;
        tail.isHead = true;
    }

    override public function update(frame:Int) {
        if (!isHead) {
            return;
        }

        var node:Caterpillar;
        var prevNode = this;
        while ((node = prevNode.tail) != null) {
            node.x = prevNode.previousPositions[prevNode.previousPositionIndex].x;
            node.y = prevNode.previousPositions[prevNode.previousPositionIndex].y;
            prevNode.previousPositions[prevNode.previousPositionIndex].x = prevNode.x;
            prevNode.previousPositions[prevNode.previousPositionIndex].y = prevNode.y;
            prevNode.previousPositionIndex = (prevNode.previousPositionIndex + 1) % NUM_PREVIOUS_POSITIONS;
            prevNode = node;
        }

        if (x < 16 || x > Main.WIDTH - 16) {
            velocity.x = -velocity.x;
        }

        if (y > Main.HEIGHT - 16) {
            velocity.y = -velocity.y;
        }

        x += velocity.x;
        y += velocity.y;
    }

    function randomStartPosition() {
        y = -32;
        x = 32 + Math.random() * (Main.WIDTH - 64);

        for (position in previousPositions) {
            position.x = x;
            position.y = y;
        }
    }

    function randomDirection() {
        VectorMath.toPolar(velocity, Math.PI/2 + Math.random() * Math.PI, 2);
    }
}
