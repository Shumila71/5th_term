import unittest
from main import *

class TestStringFunctions(unittest.TestCase):

    def test_reverse_string(self):
        self.assertEqual(reverse_string("hello"), "olleh")
        self.assertEqual(reverse_string("world"), "dlrow")
        self.assertEqual(reverse_string(""), "")
        self.assertEqual(reverse_string("Python"), "nohtyP")

    def test_to_uppercase(self):
        self.assertEqual(to_uppercase("hello"), "HELLO")
        self.assertEqual(to_uppercase("world"), "WORLD")
        self.assertEqual(to_uppercase("Python"), "PYTHON")
        self.assertEqual(to_uppercase(""), "")

    def test_is_substring(self):
        self.assertTrue(is_substring("hello world", "world"))
        self.assertFalse(is_substring("hello world", "python"))
        self.assertTrue(is_substring("", ""))
        self.assertTrue(is_substring("test string", "string"))

    def test_concatenate_strings(self):
        self.assertEqual(concatenate_strings("hello", "world"), "helloworld")
        self.assertEqual(concatenate_strings("", "world"), "world")
        self.assertEqual(concatenate_strings("hello", ""), "hello")
        self.assertEqual(concatenate_strings("", ""), "")

    def test_count_vowels(self):
        self.assertEqual(count_vowels("hello"), 2)
        self.assertEqual(count_vowels("world"), 1)
        self.assertEqual(count_vowels("aeiou"), 5)
        self.assertEqual(count_vowels("bcdfg"), 0)
        self.assertEqual(count_vowels("AEIOU"), 5)

if __name__ == "__main__":
    unittest.main()
