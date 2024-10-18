import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';
import 'package:encrypt/encrypt_io.dart';

class Encrypt extends StatefulWidget {
  const Encrypt({super.key});

  @override
  State<Encrypt> createState() => _EncryptState();
}

class _EncryptState extends State<Encrypt> {
  TextEditingController textEditingController = TextEditingController();
  String encryptedText = '';
  String decryptedText = '';
  var encrypted;

  encrypt.Encrypter? encrypter;
  RSAPublicKey? publicKey;
  RSAPrivateKey? privateKey;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadKeys();
  }

  Future<void> _loadKeys() async {
    try {
      publicKey = await parseKeyFromFile<RSAPublicKey>('assets/public.pem');
      privateKey = await parseKeyFromFile<RSAPrivateKey>('assets/private.pem');

      encrypter = encrypt.Encrypter(
          encrypt.RSA(publicKey: publicKey!, privateKey: privateKey!));
    } catch (e) {
      print('Error loading keys: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RSA Encryption Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  labelText: 'Enter text to encrypt',
                ),
              ),
              const SizedBox(height: 20),
              Text('Encrypted String: $encryptedText'),
              const SizedBox(height: 20),
              Text('Decrypted String: $decryptedText'),
              const SizedBox(height: 20),
              if (isLoading) const Center(child: CircularProgressIndicator()),
              if (!isLoading)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: encrypter == null
                          ? null
                          : () {
                              try {
                                encrypted = encrypter!
                                    .encrypt(textEditingController.text);
                                print('Public Key: $publicKey');

                                setState(() {
                                  encryptedText = encrypted.base64;
                                  decryptedText = '';
                                  textEditingController.clear();
                                });
                              } catch (e) {
                                print('Encryption failed: $e');
                              }
                            },
                      child: const Text('Encrypt'),
                    ),
                    ElevatedButton(
                      onPressed: (encryptedText.isEmpty || encrypter == null)
                          ? null
                          : () {
                              try {
                                decryptedText = encrypter!.decrypt(encrypted);
                                setState(() {});
                              } catch (e) {
                                print('Decryption failed: $e');
                              }
                            },
                      child: const Text('Decrypt'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
