import 'dart:typed_data';
import 'data_output.dart';
import 'data_input.dart';
import "dart:convert";

class XdrDataInputStream extends DataInput {
  XdrDataInputStream(Uint8List data) : super.fromUint8List(data);

  int read() {
    return readByte();
  }

  String readString() {
    int length = readInt();
    List<int> bytes = readBytes(length);
    return utf8.decode(bytes);
  }

  List<int> readIntArray() {
    var l = readInt();
    var result = List<int>(l);
    for (int i = 0; i < l; i++) {
      result[i] = readInt();
    }
    return result;
  }

  List<double> readFloatArray() {
    var l = readInt();
    var result = List<double>(l);
    for (int i = 0; i < l; i++) {
      result[i] = readFloat();
    }
    return result;
  }

  List<double> readDoubleArray() {
    var l = readInt();
    var result = List<double>(l);
    for (int i = 0; i < l; i++) {
      result[i] = readDouble();
    }
    return result;
  }
}

class XdrDataOutputStream extends DataOutput {
  writeString(String s) {
    if (s == null) throw ArgumentError("String cannot be null");
    List<int> bytesNeeded = utf8.encode(s);
    if (bytesNeeded.length > 65535)
      throw FormatException("Length cannot be greater than 65535");
    writeInt(bytesNeeded.length);
    write(bytesNeeded);
  }

  writeIntArray(List<int> a) {
    writeInt(a.length);
    for (int i = 0; i < a.length; i++) {
      writeInt(a[i]);
    }
  }

  writeFloatArray(List<double> a) {
    writeInt(a.length);
    for (int i = 0; i < a.length; i++) {
      writeFloat(a[i]);
    }
  }

  writeDoubleArray(List<double> a) {
    writeInt(a.length);
    for (int i = 0; i < a.length; i++) {
      writeDouble(a[i]);
    }
  }
}
