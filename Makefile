# Compiler Config
CXX   := g++
STD   := c++17
FLAGS := -Wall -Werror -Wextra
DBG_FLAG := -g
OPT_FLAG := -O3

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

# Release Configuration
RELEASE := release
R_OBJ   := $(patsubst $(SRC)/%.cpp, $(DIST)/$(RELEASE)/$(OBJ)/%.o, $(LIB_SRC))
R_MAIN  := $(patsubst $(SRC)/%.cpp, $(DIST)/$(RELEASE)/$(OBJ)/%.o, $(MAIN))
R_LIB   := ./$(DIST)/$(RELEASE)/release.lib
R_EXE   := ./$(DIST)/$(RELEASE)/release.out

.PHONY: run exe lib
run: $(R_EXE)
	@echo "Running release executable"
	$(R_EXE)

exe: $(R_EXE)

lib: $(R_LIB)

$(R_EXE): $(R_LIB) $(R_MAIN)
	@echo "LD: Creating release executable"
	@$(CXX) $(FLAGS) $(R_FLAG) -I$(INC) $(R_MAIN) $(R_LIB) -o $(R_EXE)

$(R_LIB): $(R_OBJ)
	@echo "AR: Creating release library"
	@ar rsc $(R_LIB) $(R_OBJ)

$(DIST)/$(RELEASE)/$(OBJ)/%.o: src/%.cpp
	@echo "CXX: Complining $<"
	@mkdir -p $(@D)
	@$(CXX) $(FLAGS) $(OPT_FLAG) -I$(INC) -c $< -o $@

.PHONY: debug dexe dlib
debug: $(DBG_EXE)
	@echo "Running debug executable"
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
