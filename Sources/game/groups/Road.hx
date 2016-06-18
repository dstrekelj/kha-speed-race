package game.groups;

import game.SpeedRace;
import game.tools.Group;
import game.tools.Sprite;

import kha.Image;

class Road extends Group<RoadSegment> {
    public function new(x : Float, graphic : Image) {
        super();
        
        var segmentCount = Math.ceil(SpeedRace.HEIGHT / graphic.height);
        
        for (i in (-2)...segmentCount) add(new RoadSegment(x, i * graphic.height, graphic));
    }
    
    public function updateVelocity(v : Float) : Void {
        RoadSegment.v = v;
    }
}

private class RoadSegment extends Sprite {
    public static var v : Float = 0;
    
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic);
    }
    
    override public function update() : Void {
        super.update();
        
        if (y  > SpeedRace.HEIGHT) y = (y - SpeedRace.HEIGHT) - 2 * height;
        
        y += v;
    }
}
