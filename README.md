##1) About
Jam Helper is a series of scripts that help creating new projects in various languages and was created as an aid for Google Code Jam.
It is implemented in the awesome language Lua, version 5.1 (it won't work with 5.2).

The project is still under development, but can be already a little helpful, since it already supports creating new projects on the following languages:
- C
- Lua

##2) Usage
The API can (and probably will) be changed at any time, but for now, the only supported feature is creating new projects, which is done with the command:
```bash
lua main.c -n $template $projname
```
where '$lang' is the name of the template (or the name of the language) and '$projname' is the name of the new project.
Note that the project will be created on the current directory.

##3)Author
This project was created and is mantained by Elias Tandel Barrionovo \<elias 'dot' tandel 'at' gmail 'dot' com\>.

##4) Bugs, Feature Requests and Contribution
If you find any bugs, or have any ideas on how to improve Jam Helper, feel free to contact me through GitHub (via the bug tracker or pull requests) or to report it to my personal email address (at the Author section of this readme).
