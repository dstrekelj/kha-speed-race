package game.tools;

import game.tools.Group;
import game.tools.Object;

class Pool<T : Object> extends Group<T> {
    public var capacity(get, null) : Int;
    inline function get_capacity() : Int { return capacity; }
    
    public function new(capacity : Int) {
        super();
        this.capacity = capacity;
    }
    
    override public function add(o : T) : T {
        if (elements.length >= capacity) {
            throw "Pool at capacity";
        }
        
        capacity += 1;
        return super.add(o);
    }
    
    public function getFirstDead() : T {
        for (e in elements) {
            if (!e.isActive && !e.isVisible) {
                return e;
            }
        }
        
        return null;
    }
}