import 'package:stellar/stellar.dart';
import "dart:typed_data";
import 'dart:convert';
import 'package:fixnum/fixnum.dart' as fixnum;
void testMemoNone() {
  MemoNone memo = Memo.none();
  assert(XdrMemoType.MEMO_NONE == memo.toXdr().discriminant);
}

void testMemoTextSuccess() {
  MemoText memo = Memo.text("test");
  assert(XdrMemoType.MEMO_TEXT == memo.toXdr().discriminant);
  assert("test" == memo.text);
}

void testMemoTextUtf8() {
  MemoText memo = Memo.text("三");
  assert(XdrMemoType.MEMO_TEXT == memo.toXdr().discriminant);
  assert("三" == memo.text);
}

void testMemoTextTooLong() {
  try {
    Memo.text("12345678901234567890123456789");
    throw Exception("fail");
  } catch (exception) {
    assert(exception.toString().contains("text must be <= 28 bytes."));
  }
}

void testMemoTextTooLongUtf8() {
  try {
    Memo.text("价值交易的开源协议!!");
    throw Exception("fail");
  } catch (exception) {
    assert(exception.toString().contains("text must be <= 28 bytes."));
  }
}

void testMemoId() {
  MemoId memo = Memo.id(9223372036854775807);
  assert(9223372036854775807 == memo.id);
  assert(XdrMemoType.MEMO_ID == memo.toXdr().discriminant);
  assert(9223372036854775807 == memo.toXdr().id.uint64);
}

 void testParseMemoId() {
  String longId = "10048071741004807174";
  var element = "{ \"memo_type\": \"id\", \"memo\": \"$longId\" }";

  TransactionResponse transactionResponse = TransactionResponse.fromJson(json.decode(element));
  MemoId memoId = transactionResponse.memo;
  assert(longId == fixnum.Int64(memoId.id).toRadixStringUnsigned(10));
}

void testMemoHashSuccess() {
  MemoHash memo = Memo.hashString("4142434445464748494a4b4c");
  assert(XdrMemoType.MEMO_HASH == memo.toXdr().discriminant);
  String test = "ABCDEFGHIJKL";
  assert(test == Util.paddedByteArrayToString(memo.bytes));
  assert("4142434445464748494a4b4c" == memo.trimmedHexValue);
}

void testMemoHashSuccessUppercase() {
  MemoHash memo = Memo.hashString("4142434445464748494a4b4c".toUpperCase());
  assert(XdrMemoType.MEMO_HASH == memo.toXdr().discriminant);
  String test = "ABCDEFGHIJKL";
  assert(test == Util.paddedByteArrayToString(memo.bytes));
  assert("4142434445464748494a4b4c" == memo.trimmedHexValue);
}

void testMemoHashBytesSuccess() {
  Uint8List bytes = Uint8List(10);
  bytes.fillRange(0, bytes.length, 'A'.codeUnitAt(0));
  MemoHash memo = Memo.hash(bytes);
  assert(XdrMemoType.MEMO_HASH == memo.toXdr().discriminant);
  assert("AAAAAAAAAA" == Util.paddedByteArrayToString(memo.bytes));
  assert("4141414141414141414100000000000000000000000000000000000000000000" ==
      memo.hexValue);
  assert("41414141414141414141" == memo.trimmedHexValue);
}

void testMemoHashTooLong() {
  Uint8List longer = Uint8List(33);
  longer.fillRange(0, longer.length, 0);
  try {
    Memo.hash(longer);
    throw Exception("fail");
  } catch (exception) {
    assert(exception
        .toString()
        .contains("MEMO_HASH can contain 32 bytes at max."));
  }
}

void testMemoHashInvalidHex() {
  try {
    Memo.hashString("test");
    throw Exception("fail");
  } catch (e) {
  }
}

void testMemoReturnHashSuccess() {
  MemoReturnHash memo = Memo.returnHashString("4142434445464748494a4b4c");
  XdrMemo memoXdr = memo.toXdr();
  assert(XdrMemoType.MEMO_RETURN == memoXdr.discriminant);
  assert(memoXdr.hash == null);
  assert("4142434445464748494a4b4c0000000000000000000000000000000000000000" ==
      Util.bytesToHex(memoXdr.retHash.hash).toLowerCase());
  assert("4142434445464748494a4b4c" == memo.trimmedHexValue);
}

void main() {
  testMemoNone();
  testMemoTextSuccess();
  testMemoTextUtf8();
  testMemoTextTooLong();
  testMemoTextTooLongUtf8();
  testMemoId();
  testParseMemoId();
  testMemoHashSuccess();
  testMemoHashSuccessUppercase();
  testMemoHashBytesSuccess();
  testMemoHashTooLong();
  testMemoHashInvalidHex();
  testMemoReturnHashSuccess();
}
