package game.sprites;

import kha.Image;

class PlayerCar extends Car {
    public function new(graphic : Image) {
        super(0, 0, graphic);
    }
    
    public function updateMovement(velocity : Float, direction : Int) : Void {
        this.velocity = velocity;
        this.direction.x = direction;
    }
}
