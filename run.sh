if [ ! -d "imgui" ]; then
  git clone https://github.com/ocornut/imgui.git imgui
fi
rm -rf buld
make clean
make
./output
