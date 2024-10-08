# LOVE VSCode Game Template
[Original](https://github.com/Keyslam/LOVE-VSCode-Game-Template)
A fully configured VSCode template for LOVE

## Structure
```
├── /Game
│   ├── /assets         Contains the game's assets
│   ├── /lib            Contains external libraries
│   └── /src            Contains the game's source code
│
├── Tools
│   ├── /build          Contains the makelove.toml
│   └── package.json    Contains all scripts to use with NPM Scripts
│
├── Resources           Contains resources for you game that should not be shipped, like raw audio
│
├── Builds              Contains the builds of your game made with makelove
│
└── Root                Root access to the workspace
```


1. Install the [Sumneko Lua Language Server](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) and [Local Lua Debugger](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode) extensions.

2. In the same folder as your `main.lua`, create a folder named `.vscode`

3. In the `.vscode` folder, create a file named `settings.json` and copy the following contents into it:
```
{
	"Lua.workspace.library": [
		"${3rd}/love2d/library",
		"lib"
	],
	"Lua.runtime.version": "LuaJIT",
	"Lua.workspace.checkThirdParty": false,
}
```

4. In the `.vscode` folder, create a file named `launch.json` and copy the following contents into it:
```
{
	"version": "0.2.0",
	"configurations": [
		{
			"type": "lua-local",
			"request": "launch",
			"name": "Release",
			"program": {
				"command": "love"
			},
			"args": [
				".",
			],
		},
	]
}
```

You can use this template as a basis for how to add additional features such as debugging, code styles, folder structures, automatic builds, et cetera.
