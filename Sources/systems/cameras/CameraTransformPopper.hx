package systems.cameras;

import echoes.System;
import echoes.View;
import kha.graphics2.Graphics;
import kha.Framebuffer;
import components.core.Position;
import components.core.Camera;

class CameraTransformPopper extends System {

    var bufferCallback:Void->Framebuffer;
    var movableCameras:View<Camera,Position>;

    public function new() {
        bufferCallback = Project.bufferCallback;
    }

    @d function draw() {
        var buffer = bufferCallback();

        if (buffer == null)
            return;
        
        var graphics = buffer.g2;
        for(movableCamera in movableCameras.entities) {
            graphics.popTransformation();
        }
    }
}