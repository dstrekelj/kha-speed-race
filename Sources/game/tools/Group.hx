package game.tools;

import game.tools.Object;

import kha.graphics2.Graphics;

class Group<T : Object> {
    var elements : Array<T>;
    
    public function new() {
        elements = new Array<T>();
    }
    
    public function update() : Void {
        for (e in elements) {
            if (e.isActive) e.update();
        }
    }
    
    public function draw(g : Graphics) : Void {
        for (e in elements) {
            if (e.isVisible) e.draw(g);
        }
    }
    
    public function add(e : T) : T {
        elements.push(e);
        return e;
    }
    
    public function each(f : T->Void) {
        for (e in elements) f(e);
    }
}
