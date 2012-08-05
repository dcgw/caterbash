package caterbash;

import flash.text.TextFormatAlign;
import hopscotch.graphics.FontFace;
import hopscotch.Entity;
import hopscotch.graphics.Text;

class Remembrance extends Entity {
    static inline var SPEED = 3;

    var text:Text;

    public function new() {
        super();

        text = new Text();
        text.width = Main.WIDTH;
        text.wordWrap = true;
        text.align = TextFormatAlign.CENTER;
        text.fontFace = FontFace.serif;
        text.fontSize = 28;
        text.color = 0xffffff;
        graphic = text;

        active = false;
        visible = false;
    }

    public function setName(name:String) {
        text.text = name;
    }

    override public function update(frame:Int) {
        y -= SPEED;
    }
}
