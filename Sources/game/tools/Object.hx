package game.tools;

import kha.graphics2.Graphics;

class Object {
    public var x : Float;
    public var y : Float;
    public var width : Float;
    public var height : Float;
    public var isActive : Bool;
    public var isVisible : Bool;
    
    public function new(x : Float, y : Float, width : Float, height : Float) {
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
        
        isActive = true;
        isVisible = true;
    }
    
    public function update() : Void {}
    
    public function draw(g : Graphics) : Void {}
    
    public inline function setPosition(x : Float, y : Float) : Void {
        this.x = x;
        this.y = y;
    }
    
    public inline function setCenterPosition(x : Float, y : Float) : Void {
        this.x = x - width / 2;
        this.y = y - height / 2;
    }
    
    public function kill() : Void {
        isActive = false;
        isVisible = false;
    }
    
    public function revive() : Void {
        isActive = true;
        isVisible = true;
    }
}
