package caterbash;

import hopscotch.graphics.Text;
import hopscotch.Entity;
import hopscotch.engine.ScreenSize;
import flash.text.TextFormatAlign;

class Score extends Entity {
    var text:Text;
    var multiplier:Float;
    var points:Int;

    public function new() {
        super();

        text = new Text();
        text.fontSize = 24;
        text.color = 0xffffff;
        text.width = Main.WIDTH;
        text.wordWrap = true;
        text.align = TextFormatAlign.RIGHT;
        text.text = "0";

        graphic = text;

        points = 0;
        multiplier = 1;
    }

    public function reset() {
        points = 0;
        multiplier = 1;
    }

    public function score(v:Int) {
        points += Std.int(multiplier * v);
        multiplier += 1;
    }

    override public function update(frame:Int) {
        multiplier -= 0.06;
        if (multiplier < 1) {
            multiplier = 1;
        }
    }

    override public function updateGraphic(frame:Int, screenSize:ScreenSize) {
        text.text = Std.string(points);
        super.updateGraphic(frame, screenSize);
    }
}
