# UnityiOSGameCenterPlugin
Plugin for Unity to interact with iOS Game Center. There’s already a bunch of these, but this one focuses on saving and loading games which none of the other plugins seem to do.

## About
This is a quick project I wipped up in order to add Game Center saving/loading to my Unity game. There’s tons of Game Center plugins for Unity, but none of them mention any ability to save/load.

## Usage
The `Example` folder is a complete Unity project that should work out of the box. If you deploy this Unity project to your device, you should get an error from Apple saying that iCloud hasn’t been configured. That means the plugin works!

To use in your own Unity project, open the Xcode project and select an `armXX` target (i.e. not a simulator target) and build (`Project` -> `Build` or just `Command`-`B`). The framework will be built rather quickly—if you’re experienced using Xcode the speed may surprise you and lead you to believe something went wrong. As long as you don’t get any errors, the Framework should’ve built and will be available in the `Products` folder.

Right click on the Framework and `Show in Finder`. Move the framework into your Unity project at the following path: `Assets`->`Plugins`->`iOS`. Unity will only include this framework in builds that target iOS/tvOS.

Add the `FrameworkHandler.cs` script to your Unity project. `Assets`->`Scripts` would be a good place. Ignore the fact that I just placed it directly in the `Assets` folder in my example Unity project—do as I say not as I do.

The `FrameworkHandler.cs` exposes three static methods, `saveGame`, `loadGame`, and `initializeDelegate`. It also exposed two callbacks, `GameLoadedHandler` and `GameSavedHandler`. Hopefully, the example `GameHandler.cs` script in the example Unity project will explain how to use these methods.

It is worth pointing out that this plugin doesn’t initialize the Game Center user. In the example Unity project I am using Unity’s built in Social APIs to do the user initialization.

## Notes
All this does is load/save a game named `default`. Not very exciting, but it’s a start. The `FrameworkHandler.cs` should really be renamed to something meaningful as that is the class that the Unity developer would interact with when using this plugin.

I am not the most experienced C# developer, so the way I implemented callbacks to get the save/load results maybe could use improving.

This code is hereby released into public domain. Feel free to submit a pull-request if you’re up to maturing this.
