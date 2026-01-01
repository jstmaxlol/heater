#pragma once
#include <vector>
#include <map>
#include <variant>
#include <tuple>
#include <ranges>
#include <array>
#include <optional>
#include <regex>
#include <string>
#include <type_traits>
#include <concepts>
#include <format>
#include <print>
constexpr unsigned long long fib(unsigned n) {
    return n < 2 ? n : fib(n - 1) + fib(n - 2);
}
template<int N>
struct FibBomb {
    static constexpr auto value = fib(42);
};
template<typename T>
concept EvilArithmetic =
    requires(T a) {
        { a + a } -> std::same_as<T>;
        { a - a } -> std::same_as<T>;
        { a * a } -> std::same_as<T>;
    };
template<EvilArithmetic T>
struct ConceptSink {
    T value;
};
using VariantHell = std::variant<
    int,
    long,
    double,
    unsigned long,
    std::tuple<int,int,int,int>,
    std::tuple<long,long,long,long>,
    std::array<int, 32>,
    std::optional<std::tuple<int,double,long>>,
    std::basic_string<char>,
    std::regex
>;
template<typename R>
concept Rangey = std::ranges::range<R>;
template<Rangey R>
struct RangeSink {
    using Iter = std::ranges::iterator_t<R>;
    using Val  = std::ranges::range_value_t<R>;
};
template<int N>
struct Heater : Heater<N - 1> {
    std::vector<
        std::map<int, VariantHell>
    > v;
    static constexpr auto fib_value = FibBomb<N>::value;
    ConceptSink<long> c1;
    ConceptSink<unsigned long> c2;
    RangeSink<std::vector<int>> r1;
    RangeSink<std::array<int, 8>> r2;
    static inline void touch_format() {
        if constexpr (N == -1) { 
            std::print("{}", std::format("{}", fib_value));
        }
    }
};
template<>
struct Heater<0> {};
