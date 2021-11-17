package systems.cameras;

import echoes.System;
import echoes.View;
import kha.graphics2.Graphics;
import kha.Framebuffer;
import components.core.Position;
import components.core.Camera;
import components.core.Bounds2D;

class CameraTransformPusher extends System {

    var bufferCallback:Void->Framebuffer;
    var movableCameras:View<Camera, Bounds2D, Position>;

    public function new() {
        bufferCallback = Project.bufferCallback;
    }

    @d function draw() {
        var buffer = bufferCallback();

        if (buffer == null)
            return;
        
        var graphics = buffer.g2;

        for(movableCamera in movableCameras.entities) {
            var camera = movableCamera.get(Camera);
            var position = movableCamera.get(Position);
            var cameraBounds = movableCamera.get(Bounds2D);

            graphics.pushTransformation( movableCamera.get(Camera).transform);
            graphics.translate(-position.x + cameraBounds.w * 0.5, -position.y + cameraBounds.h * 0.5);
        }
    }
}