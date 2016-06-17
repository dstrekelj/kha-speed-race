package game.tools;

import game.tools.Object;

import kha.graphics2.Graphics;

class Group<T : Object> {
    var elements : Array<T>;
    
    public inline function new() {
        elements = new Array<T>();
    }
    
    public inline function update() : Void {
        for (e in elements) {
            if (e.isActive) e.update();
        }
    }
    
    public inline function draw(g : Graphics) : Void {
        for (e in elements) {
            if (e.isVisible) e.draw(g);
        }
    }
    
    public inline function add(e : T) : Void {
        elements.push(e);
    }
    
    public inline function each(f : T->Void) {
        for (e in elements) f(e);
    }
}
