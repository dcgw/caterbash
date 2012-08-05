package caterbash;

import flash.media.Sound;
import flash.media.SoundChannel;
import nme.installer.Assets;
import hopscotch.graphics.Image;
import hopscotch.Playfield;
import hopscotch.graphics.Text;

class GameOver extends Playfield {
    static inline var INTERVAL = 30;
    static inline var MAX_REMEMBRANCES_ON_SCREEN = 25;

    public var onDone:Void->Void;

    var names:Array<String>;
    var numRemembrances:Int;
    var remembrances:Array<Remembrance>;

    var music:Sound;
    var musicChannel:SoundChannel;

    var counter:Int;

    public function new() {
        super();

        music = Assets.getSound("assets/Remembrance.mp3");
        musicChannel = null;

        names = ["Dan", "George", "Florian", "Sam", "Terry", "Stephen", "John", "Hayden", "Jasper", "Alan",
                "Jonathan", "Alistair", "Mark", "Emma", "Perrin", "Melissa", "Alex", "Aubrey", "Ed", "Tom",
                "Craig", "Phil", "Michael", "Bennett", "Laika", "Tracy", "Zayne", "Christer", "Harry"];
        numRemembrances = 0;

        remembrances = [];
        for (i in 0...MAX_REMEMBRANCES_ON_SCREEN) {
            remembrances[i] = new Remembrance();
            addEntity(remembrances[i]);
        }

        addGraphic(new Image(Assets.getBitmapData("assets/GameOver.png")));

        counter = 0;
    }

    public function addRemembrance() {
        ++numRemembrances;
    }

    override public function update(frame:Int) {
        if (counter % INTERVAL == 0) {
            var i = Std.int(counter/INTERVAL);
            if (i < numRemembrances) {
                var remembrance = remembrances[i % MAX_REMEMBRANCES_ON_SCREEN];
                remembrance.y = Main.HEIGHT;
                remembrance.setName(names[Std.int(Math.random() * names.length)] + " the Caterpillar");
                remembrance.active = true;
                remembrance.visible = true;
            } else if (numRemembrances == 0 ||
                    remembrances[(numRemembrances-1) % MAX_REMEMBRANCES_ON_SCREEN].y < -32) {
                onDone();
            }
        }

        ++counter;

        super.update(frame);
    }

    override public function begin(frame:Int) {
        if (musicChannel == null) {
            musicChannel = music.play(0, 2147483647);
        }

        counter = 0;
    }

    override public function end() {
        if (musicChannel != null) {
            musicChannel.stop();
            musicChannel = null;
        }

        for (remembrance in remembrances) {
            remembrance.active = false;
            remembrance.visible = false;
        }

        numRemembrances = 0;
    }
}
