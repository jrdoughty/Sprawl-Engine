package components.core;
import kha.Image;
abstract ImageComp(Image) from Image to Image {
    public function new(i:Image) {
        this = i;
    }
}