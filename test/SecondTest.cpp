#include <catch2/catch.hpp>

#include "Math.h"

TEST_CASE("Addition", "[add]")
{
    REQUIRE(add(1, 0) == 1);
    REQUIRE(add(1, 2) == 3);
    REQUIRE(add(2, 3) == 5);
    REQUIRE(add(4, 5) == 9);
}
