import 'dart:convert';
import 'dart:typed_data';

import 'package:basic_utils/basic_utils.dart';
import 'package:pointycastle/export.dart';

class Cryptom {
  /// String Public Key
  String publickey = "";


  String encrypt(String plaintext, String publicKeys) {

    publickey = publicKeys;
    publickey = publickey.replaceAll("-----BEGIN PUBLIC KEY-----", "");
    publickey = publickey.replaceAll("-----END PUBLIC KEY-----", "");

    var pem =
        '-----BEGIN RSA PUBLIC KEY-----\n$publickey\n-----END RSA PUBLIC KEY-----';
    var public = CryptoUtils.rsaPublicKeyFromPem(pem);

    /// Initializing Cipher
    var cipher = PKCS1Encoding(RSAEngine());
    cipher.init(true, PublicKeyParameter<RSAPublicKey>(public));

    /// Converting into a [Unit8List] from List<int>
    /// Then Encoding into Base64
    Uint8List output =
    cipher.process(Uint8List.fromList(utf8.encode(plaintext)));
    var base64EncodedText = base64Encode(output);
    return base64EncodedText;
  }

  String text(String text,String key) {
    return encrypt(text, key);
  }
}