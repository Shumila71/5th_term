def caesar_cipher(text, shift):
    encrypted = ""
    for char in text:
        if char.isalpha():
            shift_base = 65 if char.isupper() else 97
            encrypted += chr((ord(char) + shift - shift_base) % 26 + shift_base)
        else:
            encrypted += char
    return encrypted

def encrypt_file(file_path, shift):
    with open(file_path, 'r') as file:
        content = file.read()
    encrypted_content = caesar_cipher(content, shift)
    with open(file_path, 'w') as file:
        file.write(encrypted_content)

def decrypt_file(file_path, shift):
    with open(file_path, 'r') as file:
        content = file.read()
    decrypted_content = caesar_cipher(content, -shift)
    with open(file_path, 'w') as file:
        file.write(decrypted_content)
        
def xor_cipher(text, key):
    encrypted = "".join(chr(ord(char) ^ key) for char in text)
    return encrypted

def encrypt_file_xor(file_path, key):
    with open(file_path, 'r') as file:
        content = file.read()
    encrypted_content = xor_cipher(content, key)
    with open(file_path, 'w') as file:
        file.write(encrypted_content)

def decrypt_file_xor(file_path, key):
    with open(file_path, 'r') as file:
        content = file.read()
    decrypted_content = xor_cipher(content, key)  
    with open(file_path, 'w') as file:
        file.write(decrypted_content)
        
