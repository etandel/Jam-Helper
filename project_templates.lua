local lfs = require'lfs'

local function generate_c(name)
    local main_content =
[[
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

int main (int argc, char **argv){
    FILE *input = fopen(argv[1], "r");
    FILE *out   = fopen("output.out", "w");

    fclose(input);
    fclose(out);

    return 0;
}
]]

    local makefile_content = 
([[
IDIR =.
CC=gcc
CFLAGS=-I$(IDIR) -Wall -ggdb -fopenmp

ODIR=obj
LDIR=../lib

LIBS=-lm

_DEPS = 
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = main.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))


$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

%name%: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f %name% *.txt $(ODIR)/*.o *~ $(INCDIR)/*~
]]):gsub('%%name%%', name)

    lfs.mkdir(name)
    lfs.chdir(name)
    lfs.mkdir('obj')
    local makefile = io.open('Makefile', 'w')
    makefile:write(makefile_content)
    makefile:close()

    local main = io.open('main.c', 'w')
    main:write(main_content)
    main:close()

    lfs.chdir('..')
end


local function generate_lua(name)
    lfs.mkdir(name)
    lfs.chdir(name)


    local main_name = name .. '.lua'
    local main_content =
[[
#!/usr/bin/lua

input = io.open(arg[1], 'r')
out   = io.open('output.out', 'w')

input:close()
out:close()
]]

    local main = io.open(main_name, 'w')
    os.execute('chmod +x ' .. main_name)
    main:write(main_content)
    main:close()

    lfs.chdir('..')
end

local function generate_moonscript(name)
    lfs.mkdir(name)
    lfs.chdir(name)


    local main_name = name .. '.moon'
    local main_content =
[[
#!/usr/bin/moon

input = io.open arg[1], 'r'
out   = io.open 'output.out', 'w'

input\close!
out\close!
]]

    local main = io.open(main_name, 'w')
    main:write(main_content)
    main:close()
    os.execute('chmod +x ' .. main_name)

    lfs.chdir('..')
end

local template_gen = {
    c   = generate_c,
    lua = generate_lua,
    moonscript = generate_moonscript,
    moon = generate_moonscript, -- alias for moonscript
}

return template_gen
