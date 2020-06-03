# Compiler Config
CXX   := g++
STD   := c++17
FLAGS := -Wall -Werror -Wextra
DBG_FLAG := -g

# Folder Structure Config
SRC  := src
INC  := include
DIST := dist
OBJ  := obj

# Source Files
ALL     := $(wildcard $(SRC)/**/*.cpp $(SRC)/*.cpp)
MAIN    := $(SRC)/Main.cpp
LIB_SRC := $(filter-out $(MAIN), $(ALL))

# Debug Configuration
DEBUG    := debug
DBG_OBJ  := $(patsubst $(SRC)/%.cpp, $(DIST)/$(DEBUG)/$(OBJ)/%.o, $(LIB_SRC))
DBG_MAIN := $(patsubst $(SRC)/%.cpp, $(DIST)/$(DEBUG)/$(OBJ)/%.o, $(MAIN))
DBG_LIB  := ./$(DIST)/$(DEBUG)/debug.lib
DBG_EXE  := ./$(DIST)/$(DEBUG)/debug.out

.PHONY: debug dexe dlib
debug: $(DBG_EXE)
	@echo "Running the executable"
	$(DBG_EXE)

dexe: $(DBG_EXE)

dlib: $(DBG_LIB)

$(DBG_EXE): $(DBG_LIB) $(DBG_MAIN)
	@echo "LD: Creating executable"
	@$(CXX) $(FLAGS) $(DBG_FLAG) -I$(INC) $(DBG_MAIN) $(DBG_LIB) -o $(DBG_EXE)

$(DBG_LIB): $(DBG_OBJ)
	@echo "AR: Creating debug library"
	@ar rsc $(DBG_LIB) $(DBG_OBJ)

$(DIST)/$(DEBUG)/$(OBJ)/%.o: src/%.cpp
	@echo "CXX: Complining $<"
	@mkdir -p $(@D)
	@$(CXX) $(FLAGS) $(DBG_FLAG) -I$(INC) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(DIST)
