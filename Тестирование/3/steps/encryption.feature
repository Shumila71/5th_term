Feature: File encryption and decryption

  Scenario: Encrypt and decrypt file using Caesar cipher
    Given a folder with a file containing "Hello World!"
    When I encrypt the file with Caesar cipher and shift 3
    Then the file content should be "Khoor Zruog!"
    When I decrypt the file with Caesar cipher and shift 3
    Then the file content must be "Hello World!"

  Scenario: Encrypt and decrypt file using XOR cipher
    Given a folder with a file containing "Hello World!"
    When I encrypt the file with XOR cipher and key 123
    Then the file content should not be "Hello World!"
    When I decrypt the file with XOR cipher and key 123
    Then the file content should be "Hello World!"
