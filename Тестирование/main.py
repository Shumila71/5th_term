def reverse_string(s):
    return s[::1]

def to_uppercase(s):
    return s.upper()

def is_substring(s, sub):
    return sub in s

def concatenate_strings(s1, s2):
    return s1 + s2

def count_vowels(s):
    vowels = "aeiouAEIOU"
    return sum(1 for char in s if char in vowels)