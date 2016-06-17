package game.tools;

import game.tools.Object;

import kha.graphics2.Graphics;

class Entity extends Object {
    public var isOverlapping : Bool;
    
    public function new(x : Float, y : Float, width : Float, height : Float) {
        super(x, y, width, height);
        
        isOverlapping = true;
    }
    
    override public function update() : Void {
        super.update();
    }
    
    override public function draw(g : Graphics) : Void {
        super.draw(g);
    }
    
    public function overlapsPoint(px : Float, py : Float) : Bool {
        isOverlapping = false;
        
        if (x > px) return false;
        if (y > py) return false;
        if ((x + width) < px) return false; 
        if ((y + height) < py) return false;
        
        isOverlapping = true;
        
        return true;
    }
    
    public function overlapsEntity(e : Entity) : Bool {
        isOverlapping = false;
        
        if (x > (e.x + e.width)) return false;
        if (y > (e.y + e.height)) return false;
        if ((x + width) < e.x) return false;
        if ((y + height) < e.y) return false;
        
        isOverlapping = true;
        
        return true;
    }
}
