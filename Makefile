# ---- config knobs ----
NUM_FILES ?= 64
HEAT_DEPTH ?= 131072

CXX ?= g++
CXXFLAGS := -std=c++23 -O3 -march=native -Wall -Wextra -pedantic -flto \
			-ftemplate-depth=262144 -g3 -ggdb -fvar-tracking-assignments \
			-fconcepts -fconstexpr-ops-limit=262144

HEAT_SRCS := $(shell seq 1 $(NUM_FILES) | sed 's/.*/heat&.cpp/')
OBJS := $(HEAT_SRCS:.cpp=.o) main.o
BIN := heater

# ---- default ----
all: generate $(BIN)

# ---- generate sources ----
generate:
	@./mkheat.sh $(NUM_FILES) $(HEAT_DEPTH)

# ---- link ----
$(BIN): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^

# ---- compile ----
%.o: %.cpp heat.hpp | generate
	$(CXX) $(CXXFLAGS) -c $< -o $@

# ---- cleanup ----
clean:
	rm -f heat*.cpp heat*.o main.o $(BIN)

.PHONY: all generate clean

