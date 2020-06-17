CXX=g++
CXXFLAGS=-std=c++17 -Wall -g
BIN_DIR=./bin/

%: %.cpp
	$(CXX) $< -o $(BIN_DIR)$@ $(CXXFLAGS)

clean:
	rm -f $(BIN_DIR)*
