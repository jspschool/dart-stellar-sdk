import "dart:typed_data";
import 'xdr_data.dart';
import 'xdr_enum.dart';

class XdrInt32 {
  int _int32;
  XdrInt32() {}
  int get int32 => this._int32;
  set int32(int value) => this._int32 = value;

  static encode(XdrDataOutputStream stream, XdrInt32 encodedInt32) {
    stream.writeInt(encodedInt32.int32);
  }

  static XdrInt32 decode(XdrDataInputStream stream) {
    XdrInt32 decodedInt32 = XdrInt32();
    decodedInt32.int32 = stream.readInt();
    return decodedInt32;
  }
}

class XdrInt64 {
  int _int64;
  XdrInt64() {}
  int get int64 => this._int64;
  set int64(int value) => this._int64 = value;

  static encode(XdrDataOutputStream stream, XdrInt64 encodedInt64) {
    stream.writeLong(encodedInt64.int64);
  }

  static XdrInt64 decode(XdrDataInputStream stream) {
    XdrInt64 decodedInt64 = XdrInt64();
    decodedInt64.int64 = stream.readLong();
    return decodedInt64;
  }
}

class XdrUint32 {
  int _uint32;
  XdrUint32() {}
  int get uint32 => this._uint32;
  set uint32(int value) => this._uint32 = value;

  static encode(XdrDataOutputStream stream, XdrUint32 encodedUint32) {
    stream.writeInt(encodedUint32.uint32);
  }

  static XdrUint32 decode(XdrDataInputStream stream) {
    XdrUint32 decodedUint32 = XdrUint32();
    decodedUint32.uint32 = stream.readInt();
    return decodedUint32;
  }
}

class XdrUint64 {
  int _uint64;
  XdrUint64() {}
  int get uint64 => this._uint64;
  set uint64(int value) => this._uint64 = value;

  static encode(XdrDataOutputStream stream, XdrUint64 encodedUint64) {
    stream.writeLong(encodedUint64.uint64);
  }

  static XdrUint64 decode(XdrDataInputStream stream) {
    XdrUint64 decodedUint64 = XdrUint64();
    decodedUint64.uint64 = stream.readLong();
    return decodedUint64;
  }
}

class XdrUint256 {
  Uint8List _uint256;
  XdrUint256() {}
  Uint8List get uint256 => this._uint256;
  set uint256(Uint8List value) => this._uint256 = value;

  static encode(XdrDataOutputStream stream, XdrUint256 encodedUint256) {
    stream.write(encodedUint256.uint256);
  }

  static XdrUint256 decode(XdrDataInputStream stream) {
    XdrUint256 decodedUint256 = XdrUint256();
    int uint256size = 32;
    decodedUint256.uint256 = stream.readBytes(uint256size);
    return decodedUint256;
  }
}

class XdrString32 {
  String _string32;
  XdrString32() {}
  String get string32 => this._string32;
  set string32(String value) => this._string32 = value;

  static encode(XdrDataOutputStream stream, XdrString32 encodedString32) {
    stream.writeString(encodedString32.string32);
  }

  static XdrString32 decode(XdrDataInputStream stream) {
    XdrString32 decodedString32 = XdrString32();
    decodedString32.string32 = stream.readString();
    return decodedString32;
  }
}

class XdrString64 {
  String _string64;
  XdrString64() {}
  String get string64 => this._string64;
  set string64(String value) => this._string64 = value;

  static encode(XdrDataOutputStream stream, XdrString64 encodedString64) {
    stream.writeString(encodedString64.string64);
  }

  static XdrString64 decode(XdrDataInputStream stream) {
    XdrString64 decodedString64 = XdrString64();
    decodedString64.string64 = stream.readString();
    return decodedString64;
  }
}

class XdrHash {
  Uint8List _hash;
  XdrHash() {}
  Uint8List get hash => this._hash;
  set hash(Uint8List value) => this._hash = value;

  static encode(XdrDataOutputStream stream, XdrHash encodedHash) {
    stream.write(encodedHash.hash);
  }

  static XdrHash decode(XdrDataInputStream stream) {
    XdrHash decodedHash = XdrHash();
    int Hashsize = 32;
    decodedHash.hash = stream.readBytes(Hashsize);
    return decodedHash;
  }
}

class XdrCurve25519Public {
  Uint8List _key;
  XdrCurve25519Public() {}
  Uint8List get key => this._key;
  set key(Uint8List value) => this._key = value;

  static encode(
      XdrDataOutputStream stream, XdrCurve25519Public encodedCurve25519Public) {
    stream.write(encodedCurve25519Public.key);
  }

  static XdrCurve25519Public decode(XdrDataInputStream stream) {
    XdrCurve25519Public decodedCurve25519Public = XdrCurve25519Public();
    int keysize = 32;
    decodedCurve25519Public.key = stream.readBytes(keysize);
    return decodedCurve25519Public;
  }
}

class XdrHmacSha256Key {
  Uint8List _key;
  XdrHmacSha256Key() {}
  Uint8List get key => this._key;
  set key(Uint8List value) => this._key = value;

  static encode(
      XdrDataOutputStream stream, XdrHmacSha256Key encodedHmacSha256Key) {
    stream.write(encodedHmacSha256Key.key);
  }

  static XdrHmacSha256Key decode(XdrDataInputStream stream) {
    XdrHmacSha256Key decodedHmacSha256Key = XdrHmacSha256Key();
    int keysize = 32;
    decodedHmacSha256Key.key = stream.readBytes(keysize);
    return decodedHmacSha256Key;
  }
}

class XdrHmacSha256Mac {
  Uint8List _key;
  XdrHmacSha256Mac() {}
  Uint8List get key => this._key;
  set key(Uint8List value) => this._key = value;

  static encode(
      XdrDataOutputStream stream, XdrHmacSha256Mac encodedHmacSha256Mac) {
    stream.write(encodedHmacSha256Mac.key);
  }

  static XdrHmacSha256Mac decode(XdrDataInputStream stream) {
    XdrHmacSha256Mac decodedHmacSha256Mac = XdrHmacSha256Mac();
    int keysize = 32;
    decodedHmacSha256Mac.key = stream.readBytes(keysize);
    return decodedHmacSha256Mac;
  }
}

class XdrCurve25519Secret {
  Uint8List _key;
  XdrCurve25519Secret() {}
  Uint8List get key => this._key;
  set key(Uint8List value) => this._key = value;

  static encode(
      XdrDataOutputStream stream, XdrCurve25519Secret encodedCurve25519Secret) {
    stream.write(encodedCurve25519Secret.key);
  }

  static XdrCurve25519Secret decode(XdrDataInputStream stream) {
    XdrCurve25519Secret decodedCurve25519Secret = XdrCurve25519Secret();
    int keysize = 32;
    decodedCurve25519Secret.key = stream.readBytes(keysize);
    return decodedCurve25519Secret;
  }
}

class XdrThresholds {
  Uint8List _thresholds;
  XdrThresholds() {}
  Uint8List get thresholds => this._thresholds;
  set thresholds(Uint8List value) => this._thresholds = value;

  static encode(XdrDataOutputStream stream, XdrThresholds encodedThresholds) {
    stream.write(encodedThresholds.thresholds);
  }

  static XdrThresholds decode(XdrDataInputStream stream) {
    XdrThresholds decodedThresholds = XdrThresholds();
    int thresholdssize = 4;
    decodedThresholds.thresholds = stream.readBytes(thresholdssize);
    return decodedThresholds;
  }
}

class XdrSignatureHint {
  Uint8List _signatureHint;
  XdrSignatureHint() {}
  Uint8List get signatureHint => this._signatureHint;
  set signatureHint(Uint8List value) => this._signatureHint = value;

  static encode(
      XdrDataOutputStream stream, XdrSignatureHint encodedSignatureHint) {
    stream.write(encodedSignatureHint.signatureHint);
  }

  static XdrSignatureHint decode(XdrDataInputStream stream) {
    XdrSignatureHint decodedSignatureHint = XdrSignatureHint();
    int signatureHintsize = 4;
    decodedSignatureHint.signatureHint = stream.readBytes(signatureHintsize);
    return decodedSignatureHint;
  }
}

class XdrSignature {
  Uint8List _signature;
  XdrSignature() {}
  Uint8List get signature => this._signature;
  set signature(Uint8List value) => this._signature = value;

  static encode(XdrDataOutputStream stream, XdrSignature encodedSignature) {
    int signaturesize = encodedSignature.signature.length;
    stream.writeInt(signaturesize);
    stream.write(encodedSignature.signature);
  }

  static XdrSignature decode(XdrDataInputStream stream) {
    XdrSignature decodedSignature = XdrSignature();
    int signaturesize = stream.readInt();
    decodedSignature.signature = stream.readBytes(signaturesize);
    return decodedSignature;
  }
}

class XdrUpgradeType {
  Uint8List _upgradeType;
  XdrUpgradeType() {}
  Uint8List get upgradeType => this._upgradeType;
  set upgradeType(Uint8List value) => this._upgradeType = value;

  static encode(XdrDataOutputStream stream, XdrUpgradeType encodedUpgradeType) {
    int upgradeTypesize = encodedUpgradeType.upgradeType.length;
    stream.writeInt(upgradeTypesize);
    stream.write(encodedUpgradeType.upgradeType);
  }

  static XdrUpgradeType decode(XdrDataInputStream stream) {
    XdrUpgradeType decodedUpgradeType = XdrUpgradeType();
    int upgradeTypesize = stream.readInt();
    decodedUpgradeType.upgradeType = stream.readBytes(upgradeTypesize);
    return decodedUpgradeType;
  }
}

class XdrDataValue {
  Uint8List _dataValue;
  XdrDataValue() {}
  Uint8List get dataValue => this._dataValue;
  set dataValue(Uint8List value) => this._dataValue = value;

  static encode(XdrDataOutputStream stream, XdrDataValue encodedDataValue) {
    int dataValuesize = encodedDataValue.dataValue.length;
    stream.writeInt(dataValuesize);
    stream.write(encodedDataValue.dataValue);
  }

  static XdrDataValue decode(XdrDataInputStream stream) {
    XdrDataValue decodedDataValue = XdrDataValue();
    int dataValuesize = stream.readInt();
    decodedDataValue.dataValue = stream.readBytes(dataValuesize);
    return decodedDataValue;
  }
}

class XdrPublicKey {
  XdrPublicKey() {}
  XdrPublicKeyType _type;
  XdrPublicKeyType getDiscriminant() => this._type;
  void setDiscriminant(XdrPublicKeyType value) => this._type = value;

  XdrUint256 _ed25519;
  XdrUint256 getEd25519() => this._ed25519;
  void setEd25519(XdrUint256 value) => this._ed25519 = value;

  static void encode(
      XdrDataOutputStream stream, XdrPublicKey encodedPublicKey) {
    stream.writeInt(encodedPublicKey.getDiscriminant().value);
    switch (encodedPublicKey.getDiscriminant()) {
      case XdrPublicKeyType.PUBLIC_KEY_TYPE_ED25519:
        XdrUint256.encode(stream, encodedPublicKey._ed25519);
        break;
    }
  }

  static XdrPublicKey decode(XdrDataInputStream stream) {
    XdrPublicKey decodedPublicKey = XdrPublicKey();
    XdrPublicKeyType discriminant = XdrPublicKeyType.decode(stream);
    decodedPublicKey.setDiscriminant(discriminant);
    switch (decodedPublicKey.getDiscriminant()) {
      case XdrPublicKeyType.PUBLIC_KEY_TYPE_ED25519:
        decodedPublicKey._ed25519 = XdrUint256.decode(stream);
        break;
    }
    return decodedPublicKey;
  }
}

class XdrValue {
  Uint8List _value;
  XdrValue() {}
  Uint8List get value => this._value;
  set value(Uint8List value) => this._value = value;

  static encode(XdrDataOutputStream stream, XdrValue encodedValue) {
    int valuesize = encodedValue.value.length;
    stream.writeInt(valuesize);
    stream.write(encodedValue.value);
  }

  static XdrValue decode(XdrDataInputStream stream) {
    XdrValue decodedValue = XdrValue();
    int valuesize = stream.readInt();
    decodedValue.value = stream.readBytes(valuesize);
    return decodedValue;
  }
}

class XdrSequenceNumber {
  XdrInt64 _sequenceNumber;
  XdrInt64 get sequenceNumber => this._sequenceNumber;
  set sequenceNumber(XdrInt64 value) => this._sequenceNumber = value;

  static void encode(
      XdrDataOutputStream stream, XdrSequenceNumber encodedSequenceNumber) {
    XdrInt64.encode(stream, encodedSequenceNumber._sequenceNumber);
  }

  static XdrSequenceNumber decode(XdrDataInputStream stream) {
    XdrSequenceNumber decodedSequenceNumber = XdrSequenceNumber();
    decodedSequenceNumber._sequenceNumber = XdrInt64.decode(stream);
    return decodedSequenceNumber;
  }
}

class XdrSignerKey {
  XdrSignerKey() {}
  XdrSignerKeyType _type;
  XdrSignerKeyType get discriminant => this._type;
  set discriminant(XdrSignerKeyType value) => this._type = value;

  XdrUint256 _ed25519;
  XdrUint256 get ed25519 => this._ed25519;
  set ed25519(XdrUint256 value) => this._ed25519 = value;

  XdrUint256 _preAuthTx;
  XdrUint256 get preAuthTx => this._preAuthTx;
  set preAuthTx(XdrUint256 value) => this._preAuthTx = value;

  XdrUint256 _hashX;
  XdrUint256 get hashX => this._hashX;
  set hashX(XdrUint256 value) => this._hashX = value;

  static void encode(
      XdrDataOutputStream stream, XdrSignerKey encodedSignerKey) {
    stream.writeInt(encodedSignerKey.discriminant.value);
    switch (encodedSignerKey.discriminant) {
      case XdrSignerKeyType.SIGNER_KEY_TYPE_ED25519:
        XdrUint256.encode(stream, encodedSignerKey.ed25519);
        break;
      case XdrSignerKeyType.SIGNER_KEY_TYPE_PRE_AUTH_TX:
        XdrUint256.encode(stream, encodedSignerKey.preAuthTx);
        break;
      case XdrSignerKeyType.SIGNER_KEY_TYPE_HASH_X:
        XdrUint256.encode(stream, encodedSignerKey.hashX);
        break;
    }
  }

  static XdrSignerKey decode(XdrDataInputStream stream) {
    XdrSignerKey decodedSignerKey = XdrSignerKey();
    XdrSignerKeyType discriminant = XdrSignerKeyType.decode(stream);
    decodedSignerKey.discriminant = discriminant;
    switch (decodedSignerKey.discriminant) {
      case XdrSignerKeyType.SIGNER_KEY_TYPE_ED25519:
        decodedSignerKey.ed25519 = XdrUint256.decode(stream);
        break;
      case XdrSignerKeyType.SIGNER_KEY_TYPE_PRE_AUTH_TX:
        decodedSignerKey.preAuthTx = XdrUint256.decode(stream);
        break;
      case XdrSignerKeyType.SIGNER_KEY_TYPE_HASH_X:
        decodedSignerKey.hashX = XdrUint256.decode(stream);
        break;
    }
    return decodedSignerKey;
  }
}

class XdrSigner {
  XdrSigner() {}
  XdrSignerKey _key;
  XdrSignerKey get key => this._key;
  set key(XdrSignerKey value) => this._key = value;

  XdrUint32 _weight;
  XdrUint32 get weight => this._weight;
  set weight(XdrUint32 value) => this._weight = value;

  static void encode(XdrDataOutputStream stream, XdrSigner encodedSigner) {
    XdrSignerKey.encode(stream, encodedSigner.key);
    XdrUint32.encode(stream, encodedSigner.weight);
  }

  static XdrSigner decode(XdrDataInputStream stream) {
    XdrSigner decodedSigner = XdrSigner();
    decodedSigner.key = XdrSignerKey.decode(stream);
    decodedSigner.weight = XdrUint32.decode(stream);
    return decodedSigner;
  }
}
