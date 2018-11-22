import 'package:stellar/stellar.dart';

void testAssetTypeNative() {
  AssetTypeNative asset = AssetTypeNative();
  XdrAsset xdr_asset = asset.toXdr();
  Asset parsedAsset = Asset.fromXdr(xdr_asset);
  assert(parsedAsset is AssetTypeNative);
}

void testAssetTypeCreditAlphaNum4() {
  String code = "USDA";
  KeyPair issuer = KeyPair.random();
  AssetTypeCreditAlphaNum4 asset = AssetTypeCreditAlphaNum4(code, issuer);
  XdrAsset xdr_asset = asset.toXdr();
  AssetTypeCreditAlphaNum4 parsedAsset =
      Asset.fromXdr(xdr_asset) as AssetTypeCreditAlphaNum4;
  assert(code == asset.code);
  assert(issuer.accountId == parsedAsset.issuer.accountId);
}

void testAssetTypeCreditAlphaNum12() {
  String code = "TESTTEST";
  KeyPair issuer = KeyPair.random();
  AssetTypeCreditAlphaNum12 asset = AssetTypeCreditAlphaNum12(code, issuer);
  XdrAsset xdr_asset = asset.toXdr();
  AssetTypeCreditAlphaNum12 parsedAsset =
      Asset.fromXdr(xdr_asset) as AssetTypeCreditAlphaNum12;
  assert(code == asset.code);
  assert(issuer.accountId == parsedAsset.issuer.accountId);
}

void testHashCode() {
  KeyPair issuer1 = KeyPair.random();
  KeyPair issuer2 = KeyPair.random();

  // Equal
  assert(AssetTypeNative().hashCode == AssetTypeNative().hashCode);
  assert(AssetTypeCreditAlphaNum4("USD", issuer1).hashCode ==
      AssetTypeCreditAlphaNum4("USD", issuer1).hashCode);
  assert(AssetTypeCreditAlphaNum12("ABCDE", issuer1).hashCode ==
      AssetTypeCreditAlphaNum12("ABCDE", issuer1).hashCode);

  // Not equal
  assert(AssetTypeNative().hashCode !=
      AssetTypeCreditAlphaNum4("USD", issuer1).hashCode);
  assert(AssetTypeNative().hashCode !=
      AssetTypeCreditAlphaNum12("ABCDE", issuer1).hashCode);
  assert(AssetTypeCreditAlphaNum4("EUR", issuer1).hashCode !=
      AssetTypeCreditAlphaNum4("USD", issuer1).hashCode);
  assert(AssetTypeCreditAlphaNum4("EUR", issuer1).hashCode !=
      AssetTypeCreditAlphaNum4("EUR", issuer2).hashCode);
  assert(AssetTypeCreditAlphaNum4("EUR", issuer1).hashCode !=
      AssetTypeCreditAlphaNum12("EUROPE", issuer1).hashCode);
  assert(AssetTypeCreditAlphaNum4("EUR", issuer1).hashCode !=
      AssetTypeCreditAlphaNum12("EUROPE", issuer2).hashCode);
  assert(AssetTypeCreditAlphaNum12("ABCDE", issuer1).hashCode !=
      AssetTypeCreditAlphaNum12("EDCBA", issuer1).hashCode);
  assert(AssetTypeCreditAlphaNum12("ABCDE", issuer1).hashCode !=
      AssetTypeCreditAlphaNum12("ABCDE", issuer2).hashCode);
}

void testAssetEquals() {
  KeyPair issuer1 = KeyPair.random();
  KeyPair issuer2 = KeyPair.random();

  assert(AssetTypeNative() == AssetTypeNative());
  assert(AssetTypeCreditAlphaNum4("USD", issuer1) ==
      (AssetTypeCreditAlphaNum4("USD", issuer1)));
  assert(AssetTypeCreditAlphaNum12("ABCDE", issuer1) ==
      (AssetTypeCreditAlphaNum12("ABCDE", issuer1)));

  assert(!(AssetTypeNative() == (AssetTypeCreditAlphaNum4("USD", issuer1))));
  assert(!(AssetTypeNative() == (AssetTypeCreditAlphaNum12("ABCDE", issuer1))));
  assert(!(AssetTypeCreditAlphaNum4("EUR", issuer1) ==
      (AssetTypeCreditAlphaNum4("USD", issuer1))));
  assert(!(AssetTypeCreditAlphaNum4("EUR", issuer1) ==
      (AssetTypeCreditAlphaNum4("EUR", issuer2))));
  assert(!(AssetTypeCreditAlphaNum12("ABCDE", issuer1) ==
      (AssetTypeCreditAlphaNum12("EDCBA", issuer1))));
  assert(!(AssetTypeCreditAlphaNum12("ABCDE", issuer1) ==
      (AssetTypeCreditAlphaNum12("ABCDE", issuer2))));
}

void main() {
  testAssetTypeNative();
  testAssetTypeCreditAlphaNum4();
  testAssetTypeCreditAlphaNum12();
  testHashCode();
  testAssetEquals();
}
