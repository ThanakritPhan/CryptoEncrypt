// import 'package:encrypt/encrypt.dart';
// import 'package:encrypt/encrypt_io.dart';
// import 'package:pointycastle/asymmetric/api.dart';

// Future<void> main() async {
//   final publicKey = await parseKeyFromFile<RSAPublicKey>('test/public.pem');
//   final privKey = await parseKeyFromFile<RSAPrivateKey>('test/private.pem');

//   final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
//   final encrypter = Encrypter(RSA(publicKey: publicKey, privateKey: privKey));

//   final encrypted = encrypter.encrypt(plainText);
//   final decrypted = encrypter.decrypt(encrypted);

//   print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
//   print(encrypted.base64); // kO9EbgbrSwiq0EYz0aBdljHSC/rci2854Qa+nugbhKjidlezNplsEqOxR+pr1RtICZGAtv0YGevJBaRaHS17eHuj7GXo1CM3PR6pjGxrorcwR5Q7/bVEePESsimMbhHWF+AkDIX4v0CwKx9lgaTBgC8/yJKiLmQkyDCj64J3JSE=
// }
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Encryption Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  encrypt.Key? key;
  encrypt.IV? iv;
  encrypt.Encrypter? encrypter;

  String plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  String _encryptedText = '';
  String _decryptedText = '';

  @override
  void initState() {
    super.initState();
    key = encrypt.Key.fromLength(32);
    iv = encrypt.IV.fromLength(16);
    encrypter = encrypt.Encrypter(encrypt.AES(key!));
    _encryptedText = plainText;

    _encryptText(_encryptedText);
    //print("555555555555555"+_encryptedText);
    _decryptText(_encryptedText);
  }

  void _encryptText(String text) {
    final encrypted = encrypter?.encrypt(text, iv: iv);
    setState(() {
      _encryptedText = encrypted!.base64;
    });
  }

  void _decryptText(String text) {
    final decrypted = encrypter?.decrypt64(text, iv: iv);
    setState(() {
      _decryptedText = decrypted!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Encryption Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Input Text: ${plainText}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('Key: ${key}', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text('IV: ${iv}', style: TextStyle(fontWeight: FontWeight.bold)),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Enter Text to Encrypt'),
            //   onChanged: _encryptText,
            // ),
            SizedBox(height: 20),
            Text('Encrypted Text:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_encryptedText),
            SizedBox(height: 20),
            // TextField(
            //   decoration: InputDecoration(labelText: 'Enter Text to Decrypt'),
            //   onChanged: _decryptText,
            // ),
            SizedBox(height: 20),
            Text('Decrypted Text:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text(_decryptedText),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    key = encrypt.Key.fromLength(32);
                    iv = encrypt.IV.fromLength(16);
                    _encryptedText = plainText;
                    _encryptText(_encryptedText);
                    _decryptText(_encryptedText);
                  });
                },
                child: Icon(Icons.lock_reset)),
          ],
        ),
      ),
    );
  }
}
