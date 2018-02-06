package game.sprites;

import kha.Image;
import kha.math.Random;

import game.SpeedRace;

class NpcCar extends Car {
    public function new(x : Float, y : Float, graphic : Image) {
        super(x, y, graphic);
    }
    
    override public function update() : Void {
        super.update();
        
        if (y > SpeedRace.HEIGHT) kill();
    }
    
    public function init(velocity : Float, velocityMax : Float, velocityStep : Float) : Void {
        updateVelocity(velocity, velocityMax, velocityStep);

        setPosition(Random.Default.GetFloatIn(width, SpeedRace.WIDTH - 2 * width), -height);
        direction.x = ((x < SpeedRace.WIDTH / 2) ? 1 : -1) * Random.Default.GetFloatIn(0, 0.5);
        direction.y = Random.Default.GetFloatIn(0.5, 1);
        direction.normalize();
        
        revive();
    }
    
    public function updateVelocity(velocity : Float, velocityMax : Float, velocityStep : Float) : Void {
        this.velocity = velocityMax - velocity + velocityStep;
    }
}
