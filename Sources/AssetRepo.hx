package;
import haxe.ds.StringMap;
import kha.Assets;

class AssetRepo {

    public static var images:StringMap<kha.Image> = new StringMap();
    public static var videos:StringMap<kha.Video> = new StringMap();
    public static var sounds:StringMap<kha.Sound> = new StringMap();
    public static var fonts:StringMap<kha.Font> = new StringMap();
    public static var blobs:StringMap<kha.Blob> = new StringMap();

    public static function init() {
        for(i in AssetList.images)
        {
            images.set(i, Assets.images.get(i));
        }
        for(i in AssetList.sounds)
        {
            sounds.set(i, Assets.sounds.get(i));
        }
        for(i in AssetList.videos)
        {
            videos.set(i, Assets.videos.get(i));
        }
        for(i in AssetList.fonts)
        {
            fonts.set(i, Assets.fonts.get(i));
        }
        for(i in AssetList.blobs)
        {
            blobs.set(i, Assets.blobs.get(i));
        }
    }
}