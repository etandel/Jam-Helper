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
    local main_content = '#!/usr/bin/lua\n'
    local main = io.open(main_name, 'w')
    os.execute('chmod +x ' .. main_name)
    main:write(main_content)
    main:close()

    lfs.chdir('..')
end

local template_gen = {
    c   = generate_c,
    lua = generate_lua,
}

return template_gen
