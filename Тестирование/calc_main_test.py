import pytest
from calc_main import *

@pytest.mark.parametrize("a, b, expected", [
    (2, 3, 5),
    (-1, 1, 0),
    (0, 0, 0),
])
def test_add(a, b, expected):
    assert add(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (5, 3, 2),
    (0, 5, -5),
    (-5, -3, -2),
])
def test_subtract(a, b, expected):
    assert subtract(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (2, 3, 6),
    (-1, 5, -5),
    (0, 100, 0),
])
def test_multiply(a, b, expected):
    assert multiply(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (6, 3, 2),
    (5, 2, 2.5),
    (-10, -2, 5),
    (10, 0, "Division by zero is undefined"),
])
def test_divide(a, b, expected):
    if b == 0:
        assert divide(a, b) == expected
    else:
        assert divide(a, b) == expected

@pytest.mark.parametrize("a, b, expected", [
    (2, 3, 8),
    (5, 0, 1),
])
def test_power(a, b, expected):
    assert power(a, b) == expected
