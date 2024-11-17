# Compiler and flags
CXX := g++
CXXFLAGS = -I./imgui -I./imgui/backends -I/usr/include/SDL2 -I/usr/include/GL -D_REENTRANT -std=c++11

# Directories
SRCDIR := src
INCLUDEDIR := include
BUILDDIR := build
IMGUI_DIR := imgui

# Output binary
TARGET := output

# Find all source files in src/ and third_party/imgui
SRC := $(wildcard $(SRCDIR)/*.cpp) \
       $(IMGUI_DIR)/imgui.cpp \
       $(IMGUI_DIR)/imgui_draw.cpp \
       $(IMGUI_DIR)/imgui_tables.cpp \
       $(IMGUI_DIR)/imgui_widgets.cpp \
       $(IMGUI_DIR)/backends/imgui_impl_sdl2.cpp \
       $(IMGUI_DIR)/backends/imgui_impl_opengl3.cpp

# Object files
OBJS := $(patsubst $(SRCDIR)/%.cpp, $(BUILDDIR)/%.o, $(SRC))
IMGUI_OBJS := $(patsubst $(IMGUI_DIR)/%.cpp, $(BUILDDIR)/%.o, $(SRC))

# Libraries
LIBS := -lSDL2 -lGLEW -lGL -lpthread -ldl

# Rules
all: $(BUILDDIR) $(TARGET)

$(BUILDDIR):
	mkdir -p $(BUILDDIR)

$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) $^ -o $@ $(LIBS)

$(BUILDDIR)/%.o: $(SRCDIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILDDIR)/%.o: $(IMGUI_DIR)/%.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	rm -rf $(BUILDDIR) $(TARGET)

run: all
	./$(TARGET)

.PHONY: all clean run
