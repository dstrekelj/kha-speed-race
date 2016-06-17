package game.sprites;

import game.tools.Sprite;

import kha.Image;
import kha.math.Vector2;

class Car extends Sprite {
    var direction : Vector2;
    var velocity : Float;
    
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic);
        
        direction = new Vector2(0, 0);
    }
    
    override public function update() : Void {
        super.update();
        
        x += direction.x * velocity;
        y += direction.y * velocity;
    }
}
