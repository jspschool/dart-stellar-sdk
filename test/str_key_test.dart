import 'dart:typed_data';
import 'package:stellar/stellar.dart';

void testDecodeEncode(){
  String seed = "SDJHRQF4GCMIIKAAAQ6IHY42X73FQFLHUULAPSKKD4DFDM7UXWWCRHBE";
  Uint8List secret = StrKey.decodeCheck(VersionByte.SEED, seed);
  String encoded = StrKey.encodeCheck(VersionByte.SEED, secret);
  assert(seed == encoded);
}


void testDecodeInvalidVersionByte() {
  String address = "GCZHXL5HXQX5ABDM26LHYRCQZ5OJFHLOPLZX47WEBP3V2PF5AVFK2A5D";
  try {
    StrKey.decodeCheck(VersionByte.SEED, address);
    throw Exception("fail");
  }on FormatException catch(e) {
  }
}

void testDecodeInvalidSeed() {
  String seed = "SAA6NXOBOXP3RXGAXBW6PGFI5BPK4ODVAWITS4VDOMN5C2M4B66ZML";
  try {
    StrKey.decodeCheck(VersionByte.SEED, seed);
    throw Exception("fail");
  } catch (e) {
  }
}

void main() {
  testDecodeEncode();
  testDecodeInvalidVersionByte();
  testDecodeInvalidSeed();
}