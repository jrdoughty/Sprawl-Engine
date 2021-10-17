package macros;
//http://discord.kode.tech/ticket.ejs?def7fcba-325d-444c-8c89-7ff941f9194b
#if macro 
import sys.FileSystem;
import sys.io.File;
import Sys;
import components.*;
import haxe.io.Path;
import Reflect;

/*
*Yeah, its super cool... but not conducive to serialization
if I need an id, I'm probably better off with a class that is ID and Value
I'm trying to think of a way that I wouldn't... that wouldn't also mean writing a heck of a macro
ideal scenario, it'd iterate over components, and any Abstract of a primitive would get saved as an Object that was an id/value...
wait...
I think that'd be the solution...
I could make a class that has a string id that takes the reflected class name, and the value would be 'Dynamic.'
I'd just have to make the entity know how to reverse those back into their abstract form.
which wouldn't be a nightmare
at least... not compared to learning macros
*/

class GetClasses {
    private static function populateClasses(sourceDir:String):Int {
        for(entry in FileSystem.readDirectory(sourceDir)) {
            var srcFile:String = Path.join([sourceDir, entry]);
            var fi = File.read(srcFile);
            var classText:String = fi.readAll().toString();
            fi.close();
            if(classText.indexOf('abstract') != -1)
            {
                Sys.println(entry.substring(0,entry.length-3));
                Sys.println(classText.substring(classText.indexOf('(') + 1, classText.indexOf(')')));
            }
            //Sys.println(Type.createInstance(Type.getClass(entry.substring(0,entry.length-3)),[8]));
        }
        return 1;
    }

    public static function getClasses() {
        var cwd:String = Sys.getCwd();
        var assetSrcFolder = Path.join([cwd,"..", "Sources","components"]);

        var numCopied = populateClasses(assetSrcFolder);
    }
}

#end