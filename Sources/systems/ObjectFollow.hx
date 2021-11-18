package systems;

import echoes.View;
import components.core.Position;
import components.ObjectFollowTarget;
import components.ObjectFollower;

class ObjectFollow extends echoes.System {
    private var followers:View<ObjectFollower,Position>;
    private var followTargets:View<ObjectFollowTarget,Position>;
    
    public function new() { 

    }

    @u public function update(deltaTime:Float) {
        for(follower in followers.entities) {
            var followerComponent = follower.get(ObjectFollower);
            var followerPosition = follower.get(Position);

            for (followTarget in followTargets.entities) {
                var objectFollowTargetComponent = followTarget.get(ObjectFollowTarget);
                
                if (objectFollowTargetComponent.id == followerComponent.id) {
                    var objectFollowTargetPosition = followTarget.get(Position);
                    followerPosition.x = lerp(followerPosition.x, objectFollowTargetPosition.x, deltaTime * followerComponent.followSpeed);
                    followerPosition.y = lerp(followerPosition.y, objectFollowTargetPosition.y, deltaTime * followerComponent.followSpeed);
                }
            }
        }
    }

    private function lerp(source:Float, target:Float, fraction:Float):Float {
        return (source * (1.0 - fraction)) + (target * fraction);
    }
}