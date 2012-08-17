package caterbash;

import hopscotch.input.digital.Button;
import nme.installer.Assets;
import hopscotch.graphics.Image;
import hopscotch.Playfield;

class Title extends Playfield {
    public var startButton:Button;
    public var pacifismButton:Button;

    public var onPlay:Void->Void;
    public var onPacifism:Void->Void;

    public function new(startButton:Button, pacifismButton:Button, score:Score) {
        super();

        this.startButton = startButton;
        this.pacifismButton = pacifismButton;

        var graphic = new Image(Assets.getBitmapData("assets/Title.png"));
        addGraphic(graphic);

        addEntity(score);
    }

    override public function update(frame:Int) {
        if (startButton.justPressed) {
            onPlay();
        }
        if (pacifismButton.justPressed) {
            onPacifism();
        }
    }
}
