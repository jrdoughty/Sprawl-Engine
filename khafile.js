let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('Echoes');
project.addLibrary('hxbit');
project.addLibrary('slide');
project.addLibrary('nape-haxe4');
// hxmath support
project.addLibrary('hxmath');
project.addDefine('ECHO_USE_HXMATH');
project.windowOptions.width = 900;
project.windowOptions.height = 900;
resolve(project);
