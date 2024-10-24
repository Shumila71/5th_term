import unittest
import os
from main import *

class TestFileEncryption(unittest.TestCase):
    test_folder = 'D:\code\\5\Тестирование\\3\\test_folder'

    def test_encrypt_decrypt_file_caesar(self):
        encrypt_file(os.path.join(self.test_folder, "test.txt"), 3)
        with open(os.path.join(self.test_folder, "test.txt"), 'r') as f:
            content = f.read()
        self.assertEqual(content, "Khoor Zruog!")
        decrypt_file(os.path.join(self.test_folder, "test.txt"), 3)
        with open(os.path.join(self.test_folder, "test.txt"), 'r') as f:
            content = f.read()
        self.assertEqual(content, "Hello World!")

    def test_encrypt_decrypt_file_xor(self):
        encrypt_file_xor(os.path.join(self.test_folder, "test.txt"), 123)
        with open(os.path.join(self.test_folder, "test.txt"), 'r') as f:
            content = f.read()
        self.assertNotEqual(content, "3\x1e\x17\x17\x14[,\x14\t\x17\x1fC") 
        decrypt_file_xor(os.path.join(self.test_folder, "test.txt"), 123)
        with open(os.path.join(self.test_folder, "test.txt"), 'r') as f:
            content = f.read()
        self.assertEqual(content, "Hello World!")  

if __name__ == '__main__':
    unittest.main()