package macros;
//http://discord.kode.tech/ticket.ejs?def7fcba-325d-444c-8c89-7ff941f9194b
#if macro 
import sys.FileSystem;
import sys.io.File;
import Sys;
import components.*;
import haxe.io.Path;
import Reflect;

import haxe.macro.Context;
import haxe.macro.Expr;
/**
 * 
 */
 typedef Field = {
    var name:String;
    @:optional var doc:Null<String>;
    @:optional var access:Array<Access>;
    var kind:FieldType;
    var pos:Position;
    @:optional var meta:Metadata;
}
class Assets {

    public static function addAssetList():Array<Field> {
        // get all the fields in the class at this point
        // this is an array describing the variables, properties,
        // and methods in the class.
        var fields:Array<Field> = Context.getBuildFields();
        if(fields == null) fields = [];
        var cwd:String = Sys.getCwd();
        var assetSrcFolder = Path.join([cwd,"..", "Assets"]);

        var files:Array<Expr> = [];
        for(entry in FileSystem.readDirectory(assetSrcFolder)) {
            if( Std.parseInt(entry.charAt(0)) != null)
                entry = '_'+entry;
            if(entry.indexOf('.ttf') != -1)
            {    
                files.push(macro $v{entry.substring(0,entry.length-4)});
            }
        }
        // TODO: modify the fields
        // add the fields to the class
        fields.push({
            name: 'fonts',
            //doc: 'Relative path for file ${files}',
            access: [Access.APublic, Access.AStatic],
            pos: Context.currentPos(),
            kind: FieldType.FVar(macro: Array<String>, macro $a{files})
        });

        
        files = [];
        for(entry in FileSystem.readDirectory(assetSrcFolder)) {
            if( Std.parseInt(entry.charAt(0)) != null)
                entry = '_'+entry;
            if(entry.indexOf('.png') != -1 || entry.indexOf('.jpg') != -1 || entry.indexOf('.gif') != -1)
            {    
                files.push(macro $v{entry.substring(0,entry.length-4)});
            }
        }
        // TODO: modify the fields
        // add the fields to the class
        fields.push({
            name: 'images',
            //doc: 'Relative path for file ${files}',
            access: [Access.APublic, Access.AStatic],
            pos: Context.currentPos(),
            kind: FieldType.FVar(macro: Array<String>, macro $a{files})
        });

        
        files = [];
        for(entry in FileSystem.readDirectory(assetSrcFolder)) {
            if( Std.parseInt(entry.charAt(0)) != null)
                entry = '_'+entry;
            if(entry.indexOf('.ogg') != -1 || entry.indexOf('.wav') != -1 || entry.indexOf('.mp3') != -1)
            {    
                files.push(macro $v{entry.substring(0,entry.length-4)});
            }
        }
        // TODO: modify the fields
        // add the fields to the class
        fields.push({
            name: 'sounds',
            //doc: 'Relative path for file ${files}',
            access: [Access.APublic, Access.AStatic],
            pos: Context.currentPos(),
            kind: FieldType.FVar(macro: Array<String>, macro $a{files})
        });
        
        files = [];
        for(entry in FileSystem.readDirectory(assetSrcFolder)) {
            if( Std.parseInt(entry.charAt(0)) != null)
                entry = '_'+entry;
            if(entry.indexOf('.txt') != -1 )
            {    
                files.push(macro $v{entry.substring(0,entry.length-4)+'_txt'});
            } 
            else if(entry.indexOf('.sav') != -1 )
            {    
                files.push(macro $v{entry.substring(0,entry.length-4)+'_sav'});
            }
        }
        // TODO: modify the fields
        // add the fields to the class
        fields.push({
            name: 'blobs',
            //doc: 'Relative path for file ${files}',
            access: [Access.APublic, Access.AStatic],
            pos: Context.currentPos(),
            kind: FieldType.FVar(macro: Array<String>, macro $a{files})
        });

        
        files = [];
        for(entry in FileSystem.readDirectory(assetSrcFolder)) {
            if( Std.parseInt(entry.charAt(0)) != null)
                entry = '_'+entry;
            if(entry.indexOf('.mkv') != -1 || entry.indexOf('.mp4') != -1 || entry.indexOf('.ogv') != -1)
            {    
                files.push(macro $v{entry.substring(0,entry.length-4)});
            }
        }
        // TODO: modify the fields
        // add the fields to the class
        fields.push({
            name: 'videos',
            //doc: 'Relative path for file ${files}',
            access: [Access.APublic, Access.AStatic],
            pos: Context.currentPos(),
            kind: FieldType.FVar(macro: Array<String>, macro $a{files})
        });
        // and we're done 
        return fields;

        
    }

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
}

#end