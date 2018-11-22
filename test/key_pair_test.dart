import "dart:convert";
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:stellar/stellar.dart';

Function eq = const ListEquality().equals;
Function deepEq = const DeepCollectionEquality().equals;
Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

final String SEED =
    "1123740522f11bfef6b3671f51e159ccf589ccf8965262dd5f97d1721d383dd4";

void testSign() {
  String expectedSig =
      "587d4b472eeef7d07aafcd0b049640b0bb3f39784118c2e2b73a04fa2f64c9c538b4b2d0f5335e968a480021fdc23e98c0ddf424cb15d8131df8cb6c4bb58309";
  KeyPair keypair = KeyPair.fromSecretSeedList(Util.hexToBytes(SEED));
  String data = "hello world";
  Uint8List sig = keypair.sign(utf8.encode(data));
  assert(eq(Util.hexToBytes(expectedSig), sig.toList()));
}

void testVerifyTrue() {
  String sig =
      "587d4b472eeef7d07aafcd0b049640b0bb3f39784118c2e2b73a04fa2f64c9c538b4b2d0f5335e968a480021fdc23e98c0ddf424cb15d8131df8cb6c4bb58309";
  String data = "hello world";
  KeyPair keypair = KeyPair.fromSecretSeedList(Util.hexToBytes(SEED));
  assert(keypair.verify(utf8.encode(data), Util.hexToBytes(sig)) == true);
}

void testVerifyFalse() {
  String badSig =
      "687d4b472eeef7d07aafcd0b049640b0bb3f39784118c2e2b73a04fa2f64c9c538b4b2d0f5335e968a480021fdc23e98c0ddf424cb15d8131df8cb6c4bb58309";
  Uint8List corrupt = Uint8List.fromList([0x00]);
  String data = "hello world";
  KeyPair keypair = KeyPair.fromSecretSeedList(Util.hexToBytes(SEED));
  assert(keypair.verify(utf8.encode(data), Util.hexToBytes(badSig)) == false);
  assert(keypair.verify(utf8.encode(data), corrupt) == false);
}

void testFromSecretSeed() {
  Map<String, String> keypairs = Map<String, String>();
  keypairs["SDJHRQF4GCMIIKAAAQ6IHY42X73FQFLHUULAPSKKD4DFDM7UXWWCRHBE"] =
      "GCZHXL5HXQX5ABDM26LHYRCQZ5OJFHLOPLZX47WEBP3V2PF5AVFK2A5D";
  keypairs["SDTQN6XUC3D2Z6TIG3XLUTJIMHOSON2FMSKCTM2OHKKH2UX56RQ7R5Y4"] =
      "GDEAOZWTVHQZGGJY6KG4NAGJQ6DXATXAJO3AMW7C4IXLKMPWWB4FDNFZ";
  keypairs["SDIREFASXYQVEI6RWCQW7F37E6YNXECQJ4SPIOFMMMJRU5CMDQVW32L5"] =
      "GD2EVR7DGDLNKWEG366FIKXO2KCUAIE3HBUQP4RNY7LEZR5LDKBYHMM6";
  keypairs["SDAPE6RHEJ7745VQEKCI2LMYKZB3H6H366I33A42DG7XKV57673XLCC2"] =
      "GDLXVH2BTLCLZM53GF7ELZFF4BW4MHH2WXEA4Z5Z3O6DPNZNR44A56UJ";
  keypairs["SDYZ5IYOML3LTWJ6WIAC2YWORKVO7GJRTPPGGNJQERH72I6ZCQHDAJZN"] =
      "GABXJTV7ELEB2TQZKJYEGXBUIG6QODJULKJDI65KZMIZZG2EACJU5EA7";

  for (String seed in keypairs.keys) {
    String accountId = keypairs[seed];
    KeyPair keypair = KeyPair.fromSecretSeed(seed);

    assert(accountId == keypair.accountId);
    assert(seed == keypair.secretSeed);
  }
}

void testCanSign() {
  KeyPair keypair;
  keypair = KeyPair.fromSecretSeed(
      "SDJHRQF4GCMIIKAAAQ6IHY42X73FQFLHUULAPSKKD4DFDM7UXWWCRHBE");
  assert(keypair.canSign() == true);
  keypair = KeyPair.fromAccountId(
      "GABXJTV7ELEB2TQZKJYEGXBUIG6QODJULKJDI65KZMIZZG2EACJU5EA7");
  assert(keypair.canSign() == false);
}

void testSignWithoutSecret() {
  KeyPair keypair = KeyPair.fromAccountId(
      "GDEAOZWTVHQZGGJY6KG4NAGJQ6DXATXAJO3AMW7C4IXLKMPWWB4FDNFZ");
  String data = "hello world";
  try {
    keypair.sign(utf8.encode(data));
  } catch (e) {
    assert(
        "KeyPair does not contain secret key. Use KeyPair.fromSecretSeed method to create a new KeyPair with a secret key." ==
            e.message);
  }
}

void main() {
  testSign();
  testVerifyTrue();
  testVerifyFalse();
  testFromSecretSeed();
  testCanSign();
  testSignWithoutSecret();
}
