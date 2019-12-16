import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:convert/convert.dart';




abstract class CredentialConverter {
  String generateCredential(String email, String password);
  String md5Salt(String password);
}

class AccessTokenConverter implements CredentialConverter {
  final _utfEncoder = Utf8Encoder();
  final MD5 _md5Encoder = md5;
  final HexCodec _hexCodec = hex;
  final _base64codec = Latin1Codec().fuse(Base64Codec());

  String md5Salt(String password) {
    final passwordBytes = _utfEncoder.convert(password);
    final digest = _md5Encoder.convert(passwordBytes);
    final encoded = _hexCodec.encode(digest.bytes);
    return encoded;
  }

  @override
  String generateCredential(String email, String password) {
    final md5Password = md5Salt(password);
    final token = _base64codec.encode('$email:$md5Password');
    return token;
  }
}