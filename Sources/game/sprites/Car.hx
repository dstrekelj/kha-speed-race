package game.sprites;

import game.SpeedRace;

import game.tools.Sprite;

import kha.Image;
import kha.math.Vector2;

class Car extends Sprite {
    public static var X_MIN : Float = 0;
    public static var X_MAX : Float = SpeedRace.WIDTH;
    
    var direction : Vector2;
    var velocity : Float;
    
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic);
        
        direction = new Vector2(0, 0);
        velocity = 0;
    }
    
    override public function update() : Void {
        super.update();
        
        x += direction.x * velocity;
        y += direction.y * velocity;
        
        if (x < X_MIN) x = X_MIN;
        if (x > (X_MAX - width)) x = X_MAX - width;
    }
}
