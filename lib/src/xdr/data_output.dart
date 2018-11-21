import "dart:typed_data";
import "dart:convert";

class DataOutput {
  List<int> data = List();
  int offset = 0;
  int get fileLength => data.length;

  Uint8List _buffer = Uint8List(8);
  ByteData _view;

  DataOutput() {
    _view = ByteData.view(_buffer.buffer);
  }

  void write(List<int> bytes) {
    int blength = bytes.length;
    data.addAll(bytes);
    offset += blength;
    pad();
  }

  //add xdr
  void pad() {
    int pad = 0;
    int mod = offset % 4;
    if (mod > 0) {
      pad = 4 - mod;
    }
    while (pad-- > 0) {
      writeByte(0);
    }
  }

  void writeBoolean(bool v, [Endian endian = Endian.big]) {
    writeByte(v ? 1 : 0, endian);
  }

  void writeByte(int v, [Endian endian = Endian.big]) {
    data.add(v);
    offset += 1;
  }

  void writeChar(int v, [Endian endian = Endian.big]) {
    writeShort(v, endian);
  }

  void writeChars(String s, [Endian endian = Endian.big]) {
    for (int x = 0; x <= s.length; x++) {
      writeChar(s.codeUnitAt(x), endian);
    }
  }

  void writeFloat(double v, [Endian endian = Endian.big]) {
    _view.setFloat32(0, v, endian);
    write(_buffer.getRange(0, 4).toList());
  }

  void writeDouble(double v, [Endian endian = Endian.big]) {
    _view.setFloat64(0, v, endian);
    write(_buffer.getRange(0, 8).toList());
  }

  void writeShort(int v, [Endian endian = Endian.big]) {
    _view.setInt16(0, v, endian);
    write(_buffer.getRange(0, 2).toList());
  }

  void writeInt(int v, [Endian endian = Endian.big]) {
    _view.setInt32(0, v, endian);
    write(_buffer.getRange(0, 4).toList());
  }

  void writeLong(int v, [Endian endian = Endian.big]) {
    _view.setInt64(0, v, endian);
    write(_buffer.getRange(0, 8).toList());
  }

  void writeUTF(String s, [Endian endian = Endian.big]) {
    if (s == null) throw ArgumentError("String cannot be null");
    List<int> bytesNeeded = utf8.encode(s);
    if (bytesNeeded.length > 65535)
      throw FormatException("Length cannot be greater than 65535");
    writeShort(bytesNeeded.length, endian);
    write(bytesNeeded);
  }

  List<int> get bytes => data;

}
