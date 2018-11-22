import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:stellar/stellar.dart';

Function eq = const ListEquality().equals;

void testCreateAccountOperation() {
  // GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
  // GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair destination = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");

  String startingAmount = "1000";
  CreateAccountOperation operation =
      CreateAccountOperationBuilder(destination, startingAmount)
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();
  CreateAccountOperation parsedOperation =
      Operation.fromXdr(xdrOp) as CreateAccountOperation;

  assert(10000000000 == xdrOp.body.createAccountOp.startingBalance.int64);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);
  assert(destination.accountId == parsedOperation.destination.accountId);
  assert(startingAmount == parsedOperation.startingBalance);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAAAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAACVAvkAA==" ==
          operation.toXdrBase64());
}

void testPaymentOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair destination = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");

  Asset asset = AssetTypeNative();
  String amount = "1000";

  PaymentOperation operation =
      PaymentOperationBuilder(destination, asset, amount)
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();
  PaymentOperation parsedOperation =
      Operation.fromXdr(xdrOp) as PaymentOperation;

  assert(10000000000 == xdrOp.body.paymentOp.amount.int64);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);
  assert(destination.accountId == parsedOperation.destination.accountId);
  assert(parsedOperation.asset is AssetTypeNative);
  assert(amount == parsedOperation.amount);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAEAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAAAAAAAAlQL5AA=" ==
          operation.toXdrBase64());
}

void testPathPaymentOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair destination = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");
// GCGZLB3X2B3UFOFSHHQ6ZGEPEX7XYPEH6SBFMIV74EUDOFZJA3VNL6X4
  KeyPair issuer = KeyPair.fromSecretSeed(
      "SBOBVZUN6WKVMI6KIL2GHBBEETEV6XKQGILITNH6LO6ZA22DBMSDCPAG");

// GAVAQKT2M7B4V3NN7RNNXPU5CWNDKC27MYHKLF5UNYXH4FNLFVDXKRSV
  KeyPair pathIssuer1 = KeyPair.fromSecretSeed(
      "SALDLG5XU5AEJWUOHAJPSC4HJ2IK3Z6BXXP4GWRHFT7P7ILSCFFQ7TC5");
// GBCP5W2VS7AEWV2HFRN7YYC623LTSV7VSTGIHFXDEJU7S5BAGVCSETRR
  KeyPair pathIssuer2 = KeyPair.fromSecretSeed(
      "SA64U7C5C7BS5IHWEPA7YWFN3Z6FE5L6KAMYUIT4AQ7KVTVLD23C6HEZ");

  Asset sendAsset = AssetTypeNative();
  String sendMax = "0.0001";
  Asset destAsset = AssetTypeCreditAlphaNum4("USD", issuer);
  String destAmount = "0.0001";
  List<Asset> path = [
    AssetTypeCreditAlphaNum4("USD", pathIssuer1),
    AssetTypeCreditAlphaNum12("TESTTEST", pathIssuer2)
  ];

  PathPaymentOperation operation = PathPaymentOperationBuilder(
          sendAsset, sendMax, destination, destAsset, destAmount)
      .setPath(path)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  PathPaymentOperation parsedOperation =
      Operation.fromXdr(xdrOp) as PathPaymentOperation;

  assert(1000 == xdrOp.body.pathPaymentOp.sendMax.int64);
  assert(1000 == xdrOp.body.pathPaymentOp.destAmount.int64);
  assert(parsedOperation.sendAsset is AssetTypeNative);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);
  assert(destination.accountId == parsedOperation.destination.accountId);
  assert(sendMax == parsedOperation.sendMax);
  assert(parsedOperation.destAsset is AssetTypeCreditAlphaNum4);
  assert(destAmount == parsedOperation.destAmount);
  assert(path.length == parsedOperation.path.length);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAIAAAAAAAAAAAAAA+gAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAABVVNEAAAAAACNlYd30HdCuLI54eyYjyX/fDyH9IJWIr/hKDcXKQbq1QAAAAAAAAPoAAAAAgAAAAFVU0QAAAAAACoIKnpnw8rtrfxa276dFZo1C19mDqWXtG4ufhWrLUd1AAAAAlRFU1RURVNUAAAAAAAAAABE/ttVl8BLV0csW/xgXtbXOVf1lMyDluMiafl0IDVFIg==" ==
          operation.toXdrBase64());
}

void testPathPaymentEmptyPathOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair destination = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");
// GCGZLB3X2B3UFOFSHHQ6ZGEPEX7XYPEH6SBFMIV74EUDOFZJA3VNL6X4
  KeyPair issuer = KeyPair.fromSecretSeed(
      "SBOBVZUN6WKVMI6KIL2GHBBEETEV6XKQGILITNH6LO6ZA22DBMSDCPAG");

  Asset sendAsset = AssetTypeNative();
  String sendMax = "0.0001";
  Asset destAsset = AssetTypeCreditAlphaNum4("USD", issuer);
  String destAmount = "0.0001";

  PathPaymentOperation operation = PathPaymentOperationBuilder(
          sendAsset, sendMax, destination, destAsset, destAmount)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  PathPaymentOperation parsedOperation =
      Operation.fromXdr(xdrOp) as PathPaymentOperation;

  assert(1000 == xdrOp.body.pathPaymentOp.sendMax.int64);
  assert(1000 == xdrOp.body.pathPaymentOp.destAmount.int64);
  assert(parsedOperation.sendAsset is AssetTypeNative);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);
  assert(destination.accountId == parsedOperation.destination.accountId);
  assert(sendMax == parsedOperation.sendMax);
  assert(parsedOperation.destAsset is AssetTypeCreditAlphaNum4);
  assert(destAmount == parsedOperation.destAmount);
  assert(0 == parsedOperation.path.length);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAIAAAAAAAAAAAAAA+gAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAABVVNEAAAAAACNlYd30HdCuLI54eyYjyX/fDyH9IJWIr/hKDcXKQbq1QAAAAAAAAPoAAAAAA==" ==
          operation.toXdrBase64());
}

void testChangeTrustOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  Asset asset = AssetTypeNative();
  String limit = "922337203685.4775807";

  ChangeTrustOperation operation = ChangeTrustOperationBuilder(asset, limit)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  ChangeTrustOperation parsedOperation =
      Operation.fromXdr(xdrOp) as ChangeTrustOperation;

  assert(9223372036854775807 == xdrOp.body.changeTrustOp.limit.int64);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);
  assert(parsedOperation.asset is AssetTypeNative);
  assert(limit == parsedOperation.limit);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAYAAAAAf/////////8=" ==
          operation.toXdrBase64());
}

void testAllowTrustOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair trustor = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");

  String assetCode = "USDA";
  bool authorize = true;

  AllowTrustOperation operation =
      AllowTrustOperationBuilder(trustor, assetCode, authorize)
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();
  AllowTrustOperation parsedOperation =
      Operation.fromXdr(xdrOp) as AllowTrustOperation;

  assert(source.accountId == parsedOperation.sourceAccount.accountId);
  assert(trustor.accountId == parsedOperation.trustor.accountId);
  assert(assetCode == parsedOperation.assetCode);
  assert(authorize == parsedOperation.authorize);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAcAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAABVVNEQQAAAAE=" ==
          operation.toXdrBase64());
}

void testAllowTrustOperationAssetCodeBuffer() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair trustor = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");

  String assetCode = "USDABC";
  bool authorize = true;

  AllowTrustOperation operation =
      AllowTrustOperationBuilder(trustor, assetCode, authorize)
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();
  AllowTrustOperation parsedOperation =
      Operation.fromXdr(xdrOp) as AllowTrustOperation;

  assert(assetCode == parsedOperation.assetCode);
}

void testSetOptionsOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair inflationDestination = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");
// GBCP5W2VS7AEWV2HFRN7YYC623LTSV7VSTGIHFXDEJU7S5BAGVCSETRR
  XdrSignerKey signer = SignerKey.ed25519PublicKey(KeyPair.fromSecretSeed(
      "SA64U7C5C7BS5IHWEPA7YWFN3Z6FE5L6KAMYUIT4AQ7KVTVLD23C6HEZ"));

  int clearFlags = 1;
  int setFlags = 1;
  int masterKeyWeight = 1;
  int lowThreshold = 2;
  int mediumThreshold = 3;
  int highThreshold = 4;
  String homeDomain = "stellar.org";
  int signerWeight = 1;

  SetOptionsOperation operation = SetOptionsOperationBuilder()
      .setInflationDestination(inflationDestination)
      .setClearFlags(clearFlags)
      .setSetFlags(setFlags)
      .setMasterKeyWeight(masterKeyWeight)
      .setLowThreshold(lowThreshold)
      .setMediumThreshold(mediumThreshold)
      .setHighThreshold(highThreshold)
      .setHomeDomain(homeDomain)
      .setSigner(signer, signerWeight)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  SetOptionsOperation parsedOperation =
      Operation.fromXdr(xdrOp) as SetOptionsOperation;

  assert(inflationDestination.accountId ==
      parsedOperation.inflationDestination.accountId);
  assert(clearFlags == parsedOperation.clearFlags);
  assert(setFlags == parsedOperation.setFlags);
  assert(masterKeyWeight == parsedOperation.masterKeyWeight);
  assert(lowThreshold == parsedOperation.lowThreshold);
  assert(mediumThreshold == parsedOperation.mediumThreshold);
  assert(highThreshold == parsedOperation.highThreshold);
  assert(homeDomain == parsedOperation.homeDomain);
  assert(
      signer.discriminant.value == parsedOperation.signer.discriminant.value);
  assert(signer.ed25519.uint256 == parsedOperation.signer.ed25519.uint256);
  assert(signerWeight == parsedOperation.signerWeight);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAUAAAABAAAAAO3gUmG83C+VCqO6FztuMtXJF/l7grZA7MjRzqdZ9W8QAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAIAAAABAAAAAwAAAAEAAAAEAAAAAQAAAAtzdGVsbGFyLm9yZwAAAAABAAAAAET+21WXwEtXRyxb/GBe1tc5V/WUzIOW4yJp+XQgNUUiAAAAAQ==" ==
          operation.toXdrBase64());
}

void testSetOptionsOperationSingleField() {
  // GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  String homeDomain = "stellar.org";

  SetOptionsOperation operation = SetOptionsOperationBuilder()
      .setHomeDomain(homeDomain)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  SetOptionsOperation parsedOperation =
      Operation.fromXdr(xdrOp) as SetOptionsOperation;

  assert(null == parsedOperation.inflationDestination);
  assert(null == parsedOperation.clearFlags);
  assert(null == parsedOperation.setFlags);
  assert(null == parsedOperation.masterKeyWeight);
  assert(null == parsedOperation.lowThreshold);
  assert(null == parsedOperation.mediumThreshold);
  assert(null == parsedOperation.highThreshold);
  assert(homeDomain == parsedOperation.homeDomain);
  assert(null == parsedOperation.signer);
  assert(null == parsedOperation.signerWeight);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAtzdGVsbGFyLm9yZwAAAAAA" ==
          operation.toXdrBase64());
}

void testSetOptionsOperationSignerSha256() {
  // GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  Uint8List preimage = utf8.encode("stellar.org");
  Uint8List hash = Util.hash(preimage);

  SetOptionsOperation operation = SetOptionsOperationBuilder()
      .setSigner(SignerKey.sha256Hash(hash), 10)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  SetOptionsOperation parsedOperation =
      Operation.fromXdr(xdrOp) as SetOptionsOperation;

  assert(null == parsedOperation.inflationDestination);
  assert(null == parsedOperation.clearFlags);
  assert(null == parsedOperation.setFlags);
  assert(null == parsedOperation.masterKeyWeight);
  assert(null == parsedOperation.lowThreshold);
  assert(null == parsedOperation.mediumThreshold);
  assert(null == parsedOperation.highThreshold);
  assert(null == parsedOperation.homeDomain);
  assert(hash == parsedOperation.signer.hashX.uint256);
  assert(10 == parsedOperation.signerWeight);
  assert(source.accountId == parsedOperation.sourceAccount.accountId);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAACbpRqMkaQAfCYSk/n3xIl4fCoHfKqxF34ht2iuvSYEJQAAAAK" ==
          operation.toXdrBase64());
}

void testSetOptionsOperationPreAuthTxSigner() {
  Network.useTestNetwork();

  // GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  int sequenceNumber = 2908908335136768;
  Account account = Account(source, sequenceNumber);
  Transaction transaction = Transaction.Builder(account)
      .addOperation(CreateAccountOperationBuilder(destination, "2000").build())
      .build();

  // GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair opSource = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  SetOptionsOperation operation = SetOptionsOperationBuilder()
      .setSigner(SignerKey.preAuthTx(transaction), 10)
      .setSourceAccount(opSource)
      .build();

  XdrOperation xdrOp = operation.toXdr();
  SetOptionsOperation parsedOperation =
      Operation.fromXdr(xdrOp) as SetOptionsOperation;

  assert(null == parsedOperation.inflationDestination);
  assert(null == parsedOperation.clearFlags);
  assert(null == parsedOperation.setFlags);
  assert(null == parsedOperation.masterKeyWeight);
  assert(null == parsedOperation.lowThreshold);
  assert(null == parsedOperation.mediumThreshold);
  assert(null == parsedOperation.highThreshold);
  assert(null == parsedOperation.homeDomain);
  assert(eq(transaction.hash(), parsedOperation.signer.preAuthTx.uint256));
  assert(10 == parsedOperation.signerWeight);
  assert(opSource.accountId == parsedOperation.sourceAccount.accountId);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAB1vRBIRC3w7ZH5rQa17hIBKUwZTvBP4kNmSP7jVyw1fQAAAAK" ==
          operation.toXdrBase64());
}

void testManageOfferOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GBCP5W2VS7AEWV2HFRN7YYC623LTSV7VSTGIHFXDEJU7S5BAGVCSETRR
  KeyPair issuer = KeyPair.fromSecretSeed(
      "SA64U7C5C7BS5IHWEPA7YWFN3Z6FE5L6KAMYUIT4AQ7KVTVLD23C6HEZ");

  Asset selling = AssetTypeNative();
  Asset buying = Asset.createNonNativeAsset("USD", issuer);
  String amount = "0.00001";
  String price = "0.85334384"; // n=5333399 d=6250000
  Price priceObj = Price.fromString(price);
  int offerId = 1;

  ManageOfferOperation operation =
      ManageOfferOperationBuilder(selling, buying, amount, price)
          .setOfferId(offerId)
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();
  ManageOfferOperation parsedOperation =
      Operation.fromXdr(xdrOp) as ManageOfferOperation;

  assert(100 == xdrOp.body.manageOfferOp.amount.int64);
  assert(parsedOperation.selling is AssetTypeNative);
  assert(parsedOperation.buying is AssetTypeCreditAlphaNum4);
  assert(parsedOperation.buying == buying);
  assert(amount == parsedOperation.amount);
  assert(price == parsedOperation.price);
  assert(priceObj.numerator == 5333399);
  assert(priceObj.denominator == 6250000);
  assert(offerId == parsedOperation.offerId);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAMAAAAAAAAAAVVTRAAAAAAARP7bVZfAS1dHLFv8YF7W1zlX9ZTMg5bjImn5dCA1RSIAAAAAAAAAZABRYZcAX14QAAAAAAAAAAE=" ==
          operation.toXdrBase64());
}

void testCreatePassiveOfferOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GBCP5W2VS7AEWV2HFRN7YYC623LTSV7VSTGIHFXDEJU7S5BAGVCSETRR
  KeyPair issuer = KeyPair.fromSecretSeed(
      "SA64U7C5C7BS5IHWEPA7YWFN3Z6FE5L6KAMYUIT4AQ7KVTVLD23C6HEZ");

  Asset selling = AssetTypeNative();
  Asset buying = Asset.createNonNativeAsset("USD", issuer);
  String amount = "0.00001";
  String price = "2.93850088"; // n=36731261 d=12500000
  Price priceObj = Price.fromString(price);

  CreatePassiveOfferOperation operation =
      CreatePassiveOfferOperationBuilder(selling, buying, amount, price)
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();
  CreatePassiveOfferOperation parsedOperation =
      Operation.fromXdr(xdrOp) as CreatePassiveOfferOperation;

  assert(100 == xdrOp.body.createPassiveOfferOp.amount.int64);
  assert(parsedOperation.selling is AssetTypeNative);
  assert(parsedOperation.buying is AssetTypeCreditAlphaNum4);
  assert(parsedOperation.buying == buying);
  assert(amount == parsedOperation.amount);
  assert(price == parsedOperation.price);
  assert(priceObj.numerator == 36731261);
  assert(priceObj.denominator == 12500000);

  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAQAAAAAAAAAAVVTRAAAAAAARP7bVZfAS1dHLFv8YF7W1zlX9ZTMg5bjImn5dCA1RSIAAAAAAAAAZAIweX0Avrwg" ==
          operation.toXdrBase64());
}

void testAccountMergeOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");
// GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR
  KeyPair destination = KeyPair.fromSecretSeed(
      "SDHZGHURAYXKU2KMVHPOXI6JG2Q4BSQUQCEOY72O3QQTCLR2T455PMII");

  AccountMergeOperation operation = AccountMergeOperationBuilder(destination)
      .setSourceAccount(source)
      .build();

  XdrOperation xdrOp = operation.toXdr();

  AccountMergeOperation parsedOperation =
      Operation.fromXdr(xdrOp) as AccountMergeOperation;

  assert(destination.accountId == parsedOperation.destination.accountId);
  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAgAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxA=" ==
          operation.toXdrBase64());
}

void testManageDataOperation() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  ManageDataOperation operation =
      ManageDataOperationBuilder("test", Uint8List.fromList([0, 1, 2, 3, 4]))
          .setSourceAccount(source)
          .build();

  XdrOperation xdrOp = operation.toXdr();

  ManageDataOperation parsedOperation =
      Operation.fromXdr(xdrOp) as ManageDataOperation;

  assert("test" == parsedOperation.name);
  assert(eq(Uint8List.fromList([0, 1, 2, 3, 4]), parsedOperation.value));
  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAoAAAAEdGVzdAAAAAEAAAAFAAECAwQAAAA=" ==
          operation.toXdrBase64());
}

void testManageDataOperationEmptyValue() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  ManageDataOperation operation =
      ManageDataOperationBuilder("test", null).setSourceAccount(source).build();

  XdrOperation xdrOp = operation.toXdr();

  ManageDataOperation parsedOperation =
      Operation.fromXdr(xdrOp) as ManageDataOperation;

  assert("test" == parsedOperation.name);
  assert(null == parsedOperation.value);
  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAoAAAAEdGVzdAAAAAA=" ==
          operation.toXdrBase64());
}

void testBumpSequence() {
// GC5SIC4E3V56VOHJ3OZAX5SJDTWY52JYI2AFK6PUGSXFVRJQYQXXZBZF
  KeyPair source = KeyPair.fromSecretSeed(
      "SC4CGETADVYTCR5HEAVZRB3DZQY5Y4J7RFNJTRA6ESMHIPEZUSTE2QDK");

  BumpSequenceOperation operation =
      BumpSequenceOperationBuilder(156).setSourceAccount(source).build();

  XdrOperation xdrOp = operation.toXdr();

  BumpSequenceOperation parsedOperation =
      Operation.fromXdr(xdrOp) as BumpSequenceOperation;

  assert(156 == parsedOperation.bumpTo);
  assert(
      "AAAAAQAAAAC7JAuE3XvquOnbsgv2SRztjuk4RoBVefQ0rlrFMMQvfAAAAAsAAAAAAAAAnA==" ==
          operation.toXdrBase64());
}

void testToXdrAmount() {
  assert(0 == Operation.toXdrAmount("0"));
  assert(1 == Operation.toXdrAmount("0.0000001"));
  assert(10000000 == Operation.toXdrAmount("1"));
  assert(11234567 == Operation.toXdrAmount("1.1234567"));
  assert(729912843007381 == Operation.toXdrAmount("72991284.3007381"));
  assert(729912843007381 == Operation.toXdrAmount("72991284.30073810"));
  assert(1014016711446800155 == Operation.toXdrAmount("101401671144.6800155"));
  assert(9223372036854775807 == Operation.toXdrAmount("922337203685.4775807"));

  try {
    Operation.toXdrAmount("0.00000001");
  } catch (exception) {
    assert(exception
        .toString()
        .contains("The decimal point cannot exceed seven digits."));
  }

  try {
    Operation.toXdrAmount("72991284.30073811");
  } catch (exception) {
    assert(exception
        .toString()
        .contains("The decimal point cannot exceed seven digits."));
  }
}

void testFromXdrAmount() {
  assert("0" == Operation.fromXdrAmount(0));
  assert("0.0000001" == Operation.fromXdrAmount(1));
  assert("1" == Operation.fromXdrAmount(10000000));
  assert("1.1234567" == Operation.fromXdrAmount(11234567));
  assert("72991284.3007381" == Operation.fromXdrAmount(729912843007381));
  assert(
      "101401671144.6800155" == Operation.fromXdrAmount(1014016711446800155));
  assert(
      "922337203685.4775807" == Operation.fromXdrAmount(9223372036854775807));
}

void main() {
  testCreateAccountOperation();
  testPaymentOperation();
  testPathPaymentOperation();
  testPathPaymentEmptyPathOperation();
  testCreatePassiveOfferOperation();
  testChangeTrustOperation();
  testAllowTrustOperation();
  testAllowTrustOperationAssetCodeBuffer();
  testSetOptionsOperation();
  testSetOptionsOperationSingleField();
  testSetOptionsOperationSignerSha256();
  testSetOptionsOperationPreAuthTxSigner();
  testManageOfferOperation();
  testAccountMergeOperation();
  testManageDataOperation();
  testManageDataOperationEmptyValue();
  testBumpSequence();
  testToXdrAmount();
  testFromXdrAmount();
}
