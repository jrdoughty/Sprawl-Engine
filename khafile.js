let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('Echoes');
project.addLibrary('hxbit');
project.addLibrary('slide');
project.windowOptions.width = 900;
project.windowOptions.height = 900;
resolve(project);
