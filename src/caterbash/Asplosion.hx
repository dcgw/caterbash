package caterbash;

import flash.display.BlendMode;
import hopscotch.Entity;
import hopscotch.graphics.GraphicList;
import nme.installer.Assets;
import hopscotch.graphics.Image;

class Asplosion extends Entity {
    static inline var START_SCALE = 0.1;
    static inline var SCALE_RATE = 0.05;
    static inline var FRAMES_PER_IMAGE = 4;

    public var onDone:Void->Void;

    var images:Array<Image>;

    var counter:Int;

    public function new() {
        super();

        images = [];
        for (i in 1...12) {
            var image = new Image(Assets.getBitmapData("assets/Asplosion" + i + ".png"));
            image.centerOrigin();
            image.blendMode = BlendMode.ADD;
            images.push(image);
        }

        graphic = images[0];

        counter = 0;

        active = false;
        visible = false;
    }

    public function asplode(x:Float, y:Float) {
        active = true;
        visible = true;

        this.x = x;
        this.y = y;

        counter = 0;
    }

    override public function update(frame:Int) {
        var pos = counter / FRAMES_PER_IMAGE;
        var posFloor = Math.floor(pos);

        if (posFloor >= images.length) {
            active = false;
            visible = false;
            onDone();
            return;
        }

        graphic = images[posFloor];
        images[posFloor].scale = START_SCALE + counter * SCALE_RATE;

        ++counter;
    }
}
