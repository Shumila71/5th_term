import os
from behave import given, when, then
from main import encrypt_file, decrypt_file, encrypt_file_xor, decrypt_file_xor

# Задаем путь к тестовой папке
TEST_FOLDER = r'D:\code\5\Тестирование\3\test_folder'

@given('a folder with a file containing "Hello World!"')
def create_test_file(context):
    context.test_file = os.path.join(TEST_FOLDER, "test.txt")
    with open(context.test_file, 'w') as f:
        f.write("Hello World!")

@when('I encrypt the file with Caesar cipher and shift 3')
def encrypt_caesar_file(context):
    encrypt_file(context.test_file, 3)

@then('the file content should be "Khoor Zruog!"')
def check_caesar_encryption(context):
    with open(context.test_file, 'r') as f:
        content = f.read()
    assert content == "Khoor Zruog!"

@when('I decrypt the file with Caesar cipher and shift 3')
def decrypt_caesar_file(context):
    decrypt_file(context.test_file, 3)

@then('the file content must be "Hello World!"')
def check_caesar_decryption(context):
    with open(context.test_file, 'r') as f:
        content = f.read()
    assert content == "Hello World!"

@when('I encrypt the file with XOR cipher and key 123')
def encrypt_xor_file(context):
    encrypt_file_xor(context.test_file, 123)

@then('the file content should not be "Hello World!"')
def check_xor_encryption(context):
    with open(context.test_file, 'r') as f:
        content = f.read()
    assert content != "Hello World!"  

@when('I decrypt the file with XOR cipher and key 123')
def decrypt_xor_file(context):
    decrypt_file_xor(context.test_file, 123)

@then('the file content should be "Hello World!"')
def check_xor_decryption(context):
    with open(context.test_file, 'r') as f:
        content = f.read()
    assert content == "Hello World!"
