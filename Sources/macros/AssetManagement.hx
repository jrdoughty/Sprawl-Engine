package macros;
//http://discord.kode.tech/ticket.ejs?def7fcba-325d-444c-8c89-7ff941f9194b
#if macro 
import sys.FileSystem;
import sys.io.File;
import Sys;
import haxe.io.Path;

class AssetManagement {
    private static function copy(sourceDir:String, targetDir:String):Int {
        var numCopied:Int = 0;

        if(!FileSystem.exists(targetDir))
            FileSystem.createDirectory(targetDir);

        for(entry in FileSystem.readDirectory(sourceDir)) {
            var srcFile:String = Path.join([sourceDir, entry]);
            var dstFile:String = Path.join([targetDir, entry]);
            if(FileSystem.isDirectory(srcFile))
                numCopied += copy(srcFile, dstFile);
            else {
                File.copy(srcFile, dstFile);
                numCopied++;
            }
        }
        return numCopied;
    }

    public static function copyProjectAssets() {
        var cwd:String = Sys.getCwd();
        var assetSrcFolder = Path.join([cwd,"..", "Sources"]);
        var assetsDstFolder = Path.join([cwd, "bin", "hx"]);

        // make sure the assets folder exists
        if(!FileSystem.exists(assetsDstFolder))
            FileSystem.createDirectory(assetsDstFolder);

        // copy it!
        trace(assetSrcFolder);
        var numCopied = copy(assetSrcFolder, assetsDstFolder);
        Sys.println('Copied ${numCopied} project assets to ${assetsDstFolder}!');
    }
}

#end