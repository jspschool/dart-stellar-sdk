import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:stellar/stellar.dart';

Function eq = const ListEquality().equals;

void testBuilderSuccessTestnet() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  int sequenceNumber = 2908908335136768;
  Account account = new Account(source, sequenceNumber);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .build();

  transaction.sign(source);

  assert(
      "AAAAAF7FIiDToW1fOYUFBC0dmyufJbFTOa2GQESGz+S2h5ViAAAAZAAKVaMAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAAEqBfIAAAAAAAAAAABtoeVYgAAAEDLki9Oi700N60Lo8gUmEFHbKvYG4QSqXiLIt9T0ru2O5BphVl/jR9tYtHAD+UeDYhgXNgwUxqTEu1WukvEyYcD" ==
          transaction.toEnvelopeXdrBase64());

  assert(transaction.sourceAccount == source);
  assert(transaction.sequenceNumber == sequenceNumber + 1);
  assert(transaction.fee == 100);

  Transaction transaction2 =
      Transaction.fromEnvelopeXdr(transaction.toEnvelopeXdr());

  assert(transaction.sourceAccount.accountId ==
      transaction2.sourceAccount.accountId);
  assert(transaction.sequenceNumber == transaction2.sequenceNumber);
  assert(transaction.fee == transaction2.fee);
  assert((transaction.operations[0] as CreateAccountOperation)
          .startingBalance ==
      (transaction2.operations[0] as CreateAccountOperation).startingBalance);

  assert(eq(transaction.signatures, transaction2.signatures));
}

void testBuilderMemoText() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  Account account = new Account(source, 2908908335136768);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .addMemo(Memo.text("Hello world!"))
      .build();

  transaction.sign(source);

  assert(
      "AAAAAF7FIiDToW1fOYUFBC0dmyufJbFTOa2GQESGz+S2h5ViAAAAZAAKVaMAAAABAAAAAAAAAAEAAAAMSGVsbG8gd29ybGQhAAAAAQAAAAAAAAAAAAAAAO3gUmG83C+VCqO6FztuMtXJF/l7grZA7MjRzqdZ9W8QAAAABKgXyAAAAAAAAAAAAbaHlWIAAABAxzofBhoayuUnz8t0T1UNWrTgmJ+lCh9KaeOGu2ppNOz9UGw0abGLhv+9oWQsstaHx6YjwWxL+8GBvwBUVWRlBQ==" ==
          transaction.toEnvelopeXdrBase64());

  Transaction transaction2 =
      Transaction.fromEnvelopeXdr(transaction.toEnvelopeXdr());

  assert(transaction.sourceAccount.accountId ==
      transaction2.sourceAccount.accountId);
  assert(transaction.sequenceNumber == transaction2.sequenceNumber);
  assert(transaction.memo == transaction2.memo);
  assert(transaction.fee == transaction2.fee);
  assert((transaction.operations[0] as CreateAccountOperation)
          .startingBalance ==
      (transaction2.operations[0] as CreateAccountOperation).startingBalance);
}

void testBuilderTimeBounds() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  Account account = new Account(source, 2908908335136768);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .addTimeBounds(new TimeBounds(42, 1337))
      .addMemo(Memo.hash(utf8.encode("abcdef")))
      .build();

  transaction.sign(source);

// Convert transaction to binary XDR and back again to make sure timebounds are correctly de/serialized.
  XdrDataInputStream xdris =
      new XdrDataInputStream(base64Decode(transaction.toEnvelopeXdrBase64()));

  XdrTransaction decodedTransaction = XdrTransaction.decode(xdris);

  assert(decodedTransaction.timeBounds.minTime.uint64 == 42);
  assert(decodedTransaction.timeBounds.maxTime.uint64 == 1337);

  Transaction transaction2 =
      Transaction.fromEnvelopeXdr(transaction.toEnvelopeXdr());

  assert(transaction.sourceAccount.accountId ==
      transaction2.sourceAccount.accountId);
  assert(transaction.sequenceNumber == transaction2.sequenceNumber);
  assert(transaction.memo == transaction2.memo);
  assert(transaction.timeBounds == transaction2.timeBounds);
  assert(transaction.fee == transaction2.fee);
  assert((transaction.operations[0] as CreateAccountOperation)
          .startingBalance ==
      (transaction2.operations[0] as CreateAccountOperation).startingBalance);
}

void testBuilderTimeBoundsNoMaxTime() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  Account account = new Account(source, 2908908335136768);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .addTimeBounds(new TimeBounds(42, 0))
      .addMemo(Memo.hash(utf8.encode("abcdef")))
      .build();

  transaction.sign(source);

// Convert transaction to binary XDR and back again to make sure timebounds are correctly de/serialized.
  XdrDataInputStream xdris =
      new XdrDataInputStream(base64Decode(transaction.toEnvelopeXdrBase64()));
  XdrTransaction decodedTransaction = XdrTransaction.decode(xdris);

  assert(decodedTransaction.timeBounds.minTime.uint64 == 42);
  assert(decodedTransaction.timeBounds.maxTime.uint64 == 0);
}

void testBuilderSuccessPublic() {
  Network.usePublicNetwork();

// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  Account account = new Account(source, 2908908335136768);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .build();

  transaction.sign(source);

  assert(
      "AAAAAF7FIiDToW1fOYUFBC0dmyufJbFTOa2GQESGz+S2h5ViAAAAZAAKVaMAAAABAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAA7eBSYbzcL5UKo7oXO24y1ckX+XuCtkDsyNHOp1n1bxAAAAAEqBfIAAAAAAAAAAABtoeVYgAAAEDzfR5PgRFim5Wdvq9ImdZNWGBxBWwYkQPa9l5iiBdtPLzAZv6qj+iOfSrqinsoF0XrLkwdIcZQVtp3VRHhRoUE" ==
          transaction.toEnvelopeXdrBase64());
}

void testSha256HashSigning() {
  Network.usePublicNetwork();

  KeyPair source = KeyPair.fromAccountId(
      "GBBM6BKZPEHWYO3E3YKREDPQXMS4VK35YLNU7NFBRI26RAN7GI5POFBB");
  KeyPair destination = KeyPair.fromAccountId(
      "GDJJRRMBK4IWLEPJGIE6SXD2LP7REGZODU7WDC3I2D6MR37F4XSHBKX2");

  Account account = new Account(source, 0);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(new PaymentOperationBuilder(
              destination, new AssetTypeNative(), "2000")
          .build())
      .build();

  var preimage = new Uint8List(64);
  var rng = new Random.secure();
  for (var i = 0; i < 64; i++) {
    preimage[i] = rng.nextInt(256);
  }

  Uint8List hash = Util.hash(preimage);
  transaction.signHash(preimage);

  assert(eq(transaction.signatures[0].signature.signature, preimage));
  assert(eq(
      transaction.signatures[0].hint.signatureHint,
      Uint8List.fromList(
          hash.getRange(hash.length - 4, hash.length).toList())));
}

void testToBase64EnvelopeXdrBuilderNoSignatures() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  Account account = new Account(source, 2908908335136768);
  Transaction transaction = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .build();

  try {
    transaction.toEnvelopeXdrBase64();
    throw Exception("fail");
  } catch (exception) {
    assert(exception
        .toString()
        .contains("Transaction must be signed by at least one signer."));
  }
}

void testNoOperations() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");

  Account account = new Account(source, 2908908335136768);
  try {
    new TransactionBuilder(account).build();
    throw Exception("fail");
  } catch (exception) {
    assert(exception.toString().contains("At least one operation required"));
    assert(2908908335136768 == account.sequenceNumber);
  }
}

void testTryingToAddMemoTwice() {
// GBPMKIRA2OQW2XZZQUCQILI5TMVZ6JNRKM423BSAISDM7ZFWQ6KWEBC4
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  try {
    Account account = new Account(source, 2908908335136768);
    new TransactionBuilder(account)
        .addOperation(
            new CreateAccountOperationBuilder(destination, "2000").build())
        .addMemo(Memo.none())
        .addMemo(Memo.none());
    throw Exception("fail");
  } catch (exception) {
    assert(exception.toString().contains("Memo has been already added."));
  }
}

void main() {
  Network.useTestNetwork();

  testBuilderSuccessTestnet();
  testBuilderMemoText();
  testBuilderTimeBounds();
  testBuilderTimeBoundsNoMaxTime();
  testBuilderSuccessPublic();
  testSha256HashSigning();
  testToBase64EnvelopeXdrBuilderNoSignatures();
  testNoOperations();
  testTryingToAddMemoTwice();
}
