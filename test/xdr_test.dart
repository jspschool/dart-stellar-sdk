import 'dart:convert';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:stellar/stellar.dart';

Function eq = const ListEquality().equals;

void testDecodeTxBody() {
// pubnet - ledgerseq 5845058, txid  d5ec6645d86cdcae8212cbe60feaefb8d6b1a8b7d11aeea590608b0863ace4de

  String txBody =
      "AAAAAERmsKL73CyLV/HvjyQCERDXXpWE70Xhyb6MR5qPO3yQAAAAZAAIbkEAACD7AAAAAAAAAAN43bSwpXw8tSAhl7TBtQeOZTQAXwAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAAAAAAAAADdVhDVFrUiS/jPrRpblXY4bAW9u4hbRI2Hhw+2ATsFpQAAAAAtPWvAAAAAAAAAAAGPO3yQAAAAQHGWVHCBsjTyap/OY9JjPHmzWtN2Y2sL98aMERc/xJ3hcWz6kdQAwjlEhilItCyokDHCrvALZy3v/1TlaDqprA0=";
  Uint8List bytes = base64Decode(txBody);

  XdrTransactionEnvelope transactionEnvelope =
      XdrTransactionEnvelope.decode(new XdrDataInputStream(bytes));
  assert(
      2373025265623291 == transactionEnvelope.tx.seqNum.sequenceNumber.int64);
}

void testDecodeTxResult() {
// pubnet - ledgerseq 5845058, txid  d5ec6645d86cdcae8212cbe60feaefb8d6b1a8b7d11aeea590608b0863ace4de

  String txResult =
      "1exmRdhs3K6CEsvmD+rvuNaxqLfRGu6lkGCLCGOs5N4AAAAAAAAAZAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAA==";
  Uint8List bytes = base64Decode(txResult);

  XdrTransactionResultPair transactionResult =
      XdrTransactionResultPair.decode(new XdrDataInputStream(bytes));
  assert(XdrTransactionResultCode.txSUCCESS ==
      transactionResult.result.result.discriminant);
}

void testDecodeTxMeta() {
// pubnet - ledgerseq 5845058, txid  d5ec6645d86cdcae8212cbe60feaefb8d6b1a8b7d11aeea590608b0863ace4de

  String txMeta =
      "AAAAAAAAAAEAAAADAAAAAABZMEIAAAAAAAAAAN1WENUWtSJL+M+tGluVdjhsBb27iFtEjYeHD7YBOwWlAAAAAC09a8AAWTBCAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAwBZL8QAAAAAAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAALU1gZ4V7UACD1BAAAAHgAAAAoAAAAAAAAAAAAAAAABAAAAAAAACgAAAAARC07BokpLTOF+/vVKBwiAlop7hHGJTNeGGlY4MoPykwAAAAEAAAAAK+Lzfd3yDD+Ov0GbYu1g7SaIBrKZeBUxoCunkLuI7aoAAAABAAAAAERmsKL73CyLV/HvjyQCERDXXpWE70Xhyb6MR5qPO3yQAAAAAQAAAABSORGwAdyuanN3sNOHqNSpACyYdkUM3L8VafUu69EvEgAAAAEAAAAAeCzqJNkMM/jLvyuMIfyFHljBlLCtDyj17RMycPuNtRMAAAABAAAAAIEi4R7juq15ymL00DNlAddunyFT4FyUD4muC4t3bobdAAAAAQAAAACaNpLL5YMfjOTdXVEqrAh99LM12sN6He6pHgCRAa1f1QAAAAEAAAAAqB+lfAPV9ak+Zkv4aTNZwGaFFAfui4+yhM3dGhoYJ+sAAAABAAAAAMNJrEvdMg6M+M+n4BDIdzsVSj/ZI9SvAp7mOOsvAD/WAAAAAQAAAADbHA6xiKB1+G79mVqpsHMOleOqKa5mxDpP5KEp/Xdz9wAAAAEAAAAAAAAAAAAAAAEAWTBCAAAAAAAAAAD9anuOI/ouLiE/mq2w+EA0AbfK8hHiXe2tI7JEN58A3gAC1NXZOuv1AAg9QQAAAB4AAAAKAAAAAAAAAAAAAAAAAQAAAAAAAAoAAAAAEQtOwaJKS0zhfv71SgcIgJaKe4RxiUzXhhpWODKD8pMAAAABAAAAACvi833d8gw/jr9Bm2LtYO0miAaymXgVMaArp5C7iO2qAAAAAQAAAABEZrCi+9wsi1fx748kAhEQ116VhO9F4cm+jEeajzt8kAAAAAEAAAAAUjkRsAHcrmpzd7DTh6jUqQAsmHZFDNy/FWn1LuvRLxIAAAABAAAAAHgs6iTZDDP4y78rjCH8hR5YwZSwrQ8o9e0TMnD7jbUTAAAAAQAAAACBIuEe47qtecpi9NAzZQHXbp8hU+BclA+JrguLd26G3QAAAAEAAAAAmjaSy+WDH4zk3V1RKqwIffSzNdrDeh3uqR4AkQGtX9UAAAABAAAAAKgfpXwD1fWpPmZL+GkzWcBmhRQH7ouPsoTN3RoaGCfrAAAAAQAAAADDSaxL3TIOjPjPp+AQyHc7FUo/2SPUrwKe5jjrLwA/1gAAAAEAAAAA2xwOsYigdfhu/ZlaqbBzDpXjqimuZsQ6T+ShKf13c/cAAAABAAAAAAAAAAA=";
  Uint8List bytes = base64Decode(txMeta);

  XdrTransactionMeta transactionMeta =
      XdrTransactionMeta.decode(new XdrDataInputStream(bytes));
  assert(1 == transactionMeta.operations.length);
}

void testTransactionEnvelopeWithMemo() {
  String transactionEnvelopeToDecode =
      "AAAAACq1Ixcw1fchtF5aLTSw1zaYAYjb3WbBRd4jqYJKThB9AAAAZAA8tDoAAAALAAAAAAAAAAEAAAAZR29sZCBwYXltZW50IGZvciBzZXJ2aWNlcwAAAAAAAAEAAAAAAAAAAQAAAAARREGslec48mbJJygIwZoLvRtL6/gGL4ss2TOpnOUOhgAAAAFHT0xEAAAAACq1Ixcw1fchtF5aLTSw1zaYAYjb3WbBRd4jqYJKThB9AAAAADuaygAAAAAAAAAAAA==";
  Uint8List bytes = base64Decode(transactionEnvelopeToDecode);

  XdrTransactionEnvelope transactionEnvelope =
      XdrTransactionEnvelope.decode(new XdrDataInputStream(bytes));
  assert(1 == transactionEnvelope.tx.operations.length);
  assert(eq(
      Uint8List.fromList("GOLD".codeUnits),
      transactionEnvelope
          .tx.operations[0].body.paymentOp.asset.alphaNum4.assetCode));
}

void testString() {
  Uint8List bytes = Uint8List.fromList(
      [0, 0, 0, 2, 'a'.codeUnitAt(0), 'b'.codeUnitAt(0), 1, 0]);

  try {
    XdrString32 xdrObject = XdrString32.decode(new XdrDataInputStream(bytes));
    throw Exception("Didn't throw IOException");
  } catch (expectedException) {
    assert(expectedException.toString().contains("non-zero padding"));
  }
}

void testVarOpaque() {
  Uint8List bytes = Uint8List.fromList(
      [0, 0, 0, 2, 'a'.codeUnitAt(0), 'b'.codeUnitAt(0), 1, 0]);

  try {
    XdrDataValue xdrObject = XdrDataValue.decode(new XdrDataInputStream(bytes));
    throw Exception("Didn't throw IOException");
  } catch (expectedException) {
    assert(expectedException.toString().contains("non-zero padding"));
  }
}

//helper for tests below.
String backAndForthXdrStreaming(String inputString) {
//String to XDR
  XdrDataOutputStream xdrOutputStream = new XdrDataOutputStream();
  xdrOutputStream.writeString(inputString);

  Uint8List xdrByteOutput = Uint8List.fromList(xdrOutputStream.bytes);

//XDR back to String
  XdrDataInputStream xdrInputStream = new XdrDataInputStream(xdrByteOutput);
  String outputString = xdrInputStream.readString();

  return outputString;
}

void backAndForthXdrStreamingWithStandardAscii() {
  String memo = "Dollar Sign \$";
  assert(memo == backAndForthXdrStreaming(memo));
}

void backAndForthXdrStreamingWithNonStandardAscii() {
  String memo = "Euro Sign €";
  assert(memo == backAndForthXdrStreaming(memo));
}

void backAndForthXdrStreamingWithAllNonStandardAscii() {
  String memo = "øûý™€♠♣♥†‡µ¢£€";
  assert(memo == backAndForthXdrStreaming(memo));
}

void main() {
//TransactionDecodeTest
  testDecodeTxBody();
  testDecodeTxResult();
  testDecodeTxMeta();
  testTransactionEnvelopeWithMemo();

//PaddingTest
  testString();
  testVarOpaque();

//XdrDataStreamTest
  backAndForthXdrStreamingWithStandardAscii();
  backAndForthXdrStreamingWithNonStandardAscii();
  backAndForthXdrStreamingWithAllNonStandardAscii();
}
