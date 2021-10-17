let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('Echoes');
project.addLibrary('hxbit');
project.addParameter('--macro macros.GetClasses.getClasses()');
project.windowOptions.width = 900;
project.windowOptions.height = 900;
resolve(project);
