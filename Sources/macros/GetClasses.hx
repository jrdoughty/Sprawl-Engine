package macros;
//http://discord.kode.tech/ticket.ejs?def7fcba-325d-444c-8c89-7ff941f9194b
#if macro 
import sys.FileSystem;
import sys.io.File;
import Sys;
import components.*;
import haxe.io.Path;
import Reflect;

/**
 * 
 */

class GetClasses {
    private static function populateClasses(sourceDir:String):Int {
        for(entry in FileSystem.readDirectory(sourceDir)) {
            if(entry.indexOf('.') == -1)
            {
                populateClasses(Path.join([sourceDir,entry]));
            }
            else 
            {
                var srcFile:String = Path.join([sourceDir, entry]);
                var fi = File.read(srcFile);
                var classText:String = fi.readAll().toString();
                fi.close();
                if(classText.indexOf('abstract') != -1)
                {
                    Sys.println(entry.substring(0,entry.length-4));
                    Sys.println(classText.substring(classText.indexOf('(') + 1, classText.indexOf(')')));
                }
                //Sys.println(Type.createInstance(Type.getClass(entry.substring(0,entry.length-3)),[8]));
            }
        }
        return 1;
    }
    private static function populateAssets(sourceDir:String):Int {
        for(entry in FileSystem.readDirectory(sourceDir)) {
            if(entry.indexOf('.ttf') != -1)
                Sys.println(entry.substring(0,entry.length-4));
        }
        return 1;
    }

    public static function getClasses() {
        var cwd:String = Sys.getCwd();
        var assetSrcFolder = Path.join([cwd,"..", "Assets"]);

        var numCopied = populateAssets(assetSrcFolder);

        
    }
}

#end