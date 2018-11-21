import 'package:collection/collection.dart';
import "package:convert/convert.dart";
import 'package:crypto/crypto.dart';
import "dart:convert";
import 'dart:typed_data';

Function eq = const ListEquality().equals;
Function deepEq = const DeepCollectionEquality().equals;
Function unOrdDeepEq = const DeepCollectionEquality.unordered().equals;

checkNotNull(var reference, String errorMessage) {
  if (reference == null) {
    throw new Exception(errorMessage);
  }
  return reference;
}

checkArgument(bool expression, String errorMessage) {
  if (!expression) {
    throw new Exception(errorMessage);
  }
}

class Util {

  static String bytesToHex(Uint8List raw) {
    return hex.encode(raw).toUpperCase();
  }

  static Uint8List hexToBytes(String s) {
    return hex.decode(s);
  }

  ///Returns SHA-256 hash of <code>data</code>.
  static Uint8List hash(Uint8List data) {
    return sha256
        .convert(data)
        .bytes;
  }

  ///Pads <code>bytes</code> array to <code>length</code> with zeros.
  static Uint8List paddedByteArray(Uint8List bytes, int length) {
    Uint8List finalBytes = Uint8List.fromList(List<int>.filled(length, 0x0));
    finalBytes.setAll(0, bytes);
    return finalBytes;
  }

  ///Pads <code>string</code> to <code>length</code> with zeros.
  static Uint8List paddedByteArrayString(String string, int length) {
    return Util.paddedByteArray(utf8.encode(string), length);
  }

  ///Remove zeros from the end of <code>bytes</code> array.
  static String paddedByteArrayToString(Uint8List bytes) {
    return String.fromCharCodes(bytes).split('\x00')[0];
  }
}
