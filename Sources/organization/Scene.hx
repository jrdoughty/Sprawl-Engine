package organization;

import echoes.Entity;

class Scene {
    private var entities:haxe.ds.List<Entity>;

    public function new() {
        entities = new List<Entity>();
    }

    public function addEntity(entity:Entity) {
        entities.add(entity);
    }

    public function removeEntity(entity:Entity) {
        entities.remove(entity);
    }

    public function activate() {
        for( entity in entities) {
            entity.activate();
        }
    }

    public function deactivate() {
        for (entity in entities) {
            entity.deactivate();
        }
    }
}