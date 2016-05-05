CC := g++-4.9
CPP_FILES := $(wildcard src/*.cpp)
C_FILES := $(wildcard src/*.c)
ACPP_FILES := $(wildcard src/*/*.cpp)
AC_FILES := $(wildcard src/*/*.c)
CPP_OBJ_FILES := $(addprefix obj/,$(notdir $(CPP_FILES:.cpp=.o)))
C_OBJ_FILES := $(addprefix obj/,$(notdir $(C_FILES:.c=.o)))
ACPP_OBJ_FILES := $(addprefix obj/,$(notdir $(ACPP_FILES:.cpp=.o)))
AC_OBJ_FILES := $(addprefix obj/,$(notdir $(AC_FILES:.c=.o)))
INCLUDE := -I ./include/ -I./tcup/include
CC_FLAGS :=  $(INCLUDE) -std=c++14
LIB := -lSDL2 -lz -ltcup
LD_FLAGS := -L./tcup
OUT := test

$(addprefix bin/,$(OUT)): $(C_OBJ_FILES) $(CPP_OBJ_FILES) $(AC_OBJ_FILES) $(ACPP_OBJ_FILES)
	$(CC) $(LD_FLAGS) $(LIB) -o $@ $^
	
obj/%.o: src/%.cpp
	$(CC) $(CC_FLAGS) -c -o $@ $< $(LIB)

obj/%.o: src/%.c
	$(CC) $(CC_FLAGS) -c -o $@ $< $(LIB)
	
obj/%.o: src/*/%.cpp
	$(CC) $(CC_FLAGS) -c -o $@ $< $(LIB)

obj/%.o: src/*/%.c
	$(CC) $(CC_FLAGS) -c -o $@ $< $(LIB)

tcuplib:
	cd ./tcup && $(MAKE)
tcuplibclean:
	cd ./tcup && $(MAKE) clean

.Phony:run clean
	
run:
	$(addprefix bin/,$(OUT))
clean:
	rm -r obj/*.o
	rm -r bin/$(OUT)
