import 'xdr/xdr_enum.dart';
import 'xdr/xdr_other.dart';
import 'xdr/xdr_asset.dart';
import 'key_pair.dart';
import 'util.dart';

///Base Assets class.
abstract class Asset {
  Asset() {}

  static Asset create(String type, String code, String issuer) {
    if (type == "native") {
      return AssetTypeNative();
    } else {
      return Asset.createNonNativeAsset(code, KeyPair.fromAccountId(issuer));
    }
  }

  ///Creates one of AssetTypeCreditAlphaNum4 or AssetTypeCreditAlphaNum12 object based on a <code>code</code> length
  static Asset createNonNativeAsset(String code, KeyPair issuer) {
    if (code.length >= 1 && code.length <= 4) {
      return new AssetTypeCreditAlphaNum4(code, issuer);
    } else if (code.length >= 5 && code.length <= 12) {
      return new AssetTypeCreditAlphaNum12(code, issuer);
    } else {
      throw new AssetCodeLengthInvalidException();
    }
  }

  ///Generates Asset object from a given XDR object
  static Asset fromXdr(XdrAsset xdr_asset) {
    switch (xdr_asset.discriminant) {
      case XdrAssetType.ASSET_TYPE_NATIVE:
        return new AssetTypeNative();
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM4:
        String assetCode4 =
            Util.paddedByteArrayToString(xdr_asset.alphaNum4.assetCode);
        KeyPair issuer4 =
            KeyPair.fromXdrPublicKey(xdr_asset.alphaNum4.issuer.accountID);
        return AssetTypeCreditAlphaNum4(assetCode4, issuer4);
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM12:
        String assetCode12 =
            Util.paddedByteArrayToString(xdr_asset.alphaNum12.assetCode);
        KeyPair issuer12 =
            KeyPair.fromXdrPublicKey(xdr_asset.alphaNum12.issuer.accountID);
        return AssetTypeCreditAlphaNum12(assetCode12, issuer12);
      default:
        throw Exception(
            "Unknown asset type ${xdr_asset.discriminant.toString()}");
    }
  }

  ///Returns asset type. Possible types:
  ///<ul>
  ///<li><code>native</code></li>
  ///<li><code>credit_alphanum4</code></li>
  ///<li><code>credit_alphanum12</code></li>
  ///</ul>
  String get type;

  int get hashCode;

  bool operator ==(Object object);

  ///Generates XDR object from a given Asset object
  XdrAsset toXdr();

  factory Asset.fromJson(Map<String, dynamic> json) {
    if (json['asset_type'] == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(json['asset_issuer']);
      return Asset.createNonNativeAsset(json['asset_code'], issuer);
    }
  }
}

///Indicates that asset code is not valid for a specified asset class
class AssetCodeLengthInvalidException implements Exception {
  final message;

  AssetCodeLengthInvalidException([this.message]);

  String toString() {
    if (message == null) return "AssetCodeLengthInvalidException";
    return "AssetCodeLengthInvalidException: $message";
  }
}

///Base class for AssetTypeCreditAlphaNum4 and AssetTypeCreditAlphaNum12 subclasses.
abstract class AssetTypeCreditAlphaNum extends Asset {
  String _mCode;
  KeyPair _mIssuer;

  AssetTypeCreditAlphaNum(String code, KeyPair issuer) {
    checkNotNull(code, "code cannot be null");
    checkNotNull(issuer, "issuer cannot be null");
    _mCode = code;
    _mIssuer = KeyPair.fromAccountId(issuer.accountId);
  }

  ///Returns asset code
  String get code => String.fromCharCodes(_mCode.codeUnits);

  ///Returns asset issuer
  KeyPair get issuer => KeyPair.fromAccountId(_mIssuer.accountId);

  @override
  int get hashCode {
    return "${this.code}\$${this.issuer.accountId}".hashCode;
  }

  @override
  bool operator ==(Object object) {
    if (!(object is AssetTypeCreditAlphaNum)) {
      return false;
    }

    AssetTypeCreditAlphaNum o = object as AssetTypeCreditAlphaNum;

    return (this.code == o.code) &&
        (this.issuer.accountId == o.issuer.accountId);
  }
}

///Represents all assets with codes 1-4 characters long.
class AssetTypeCreditAlphaNum4 extends AssetTypeCreditAlphaNum {
  AssetTypeCreditAlphaNum4(String code, KeyPair issuer) : super(code, issuer) {
    if (code.length < 1 || code.length > 4) {
      throw new AssetCodeLengthInvalidException();
    }
  }

  @override
  String get type => "credit_alphanum4";

  @override
  XdrAsset toXdr() {
    XdrAsset xdr_asset = XdrAsset();
    xdr_asset.discriminant = XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM4;
    XdrAssetAlphaNum4 credit = XdrAssetAlphaNum4();
    credit.assetCode = Util.paddedByteArrayString(_mCode, 4);
    XdrAccountID accountID = XdrAccountID();
    accountID.accountID = _mIssuer.xdrPublicKey;
    credit.issuer = accountID;
    xdr_asset.alphaNum4 = credit;
    return xdr_asset;
  }
}

///Represents all assets with codes 5-12 characters long.
class AssetTypeCreditAlphaNum12 extends AssetTypeCreditAlphaNum {
  AssetTypeCreditAlphaNum12(String code, KeyPair issuer) : super(code, issuer) {
    if (code.length < 5 || code.length > 12) {
      throw new AssetCodeLengthInvalidException();
    }
  }

  @override
  String get type => "credit_alphanum12";

  @override
  XdrAsset toXdr() {
    XdrAsset xdr_asset = XdrAsset();
    xdr_asset.discriminant = XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM12;
    XdrAssetAlphaNum12 credit = XdrAssetAlphaNum12();
    credit.assetCode = Util.paddedByteArrayString(_mCode, 12);
    XdrAccountID accountID = XdrAccountID();
    accountID.accountID = _mIssuer.xdrPublicKey;
    credit.issuer = accountID;
    xdr_asset.alphaNum12 = credit;
    return xdr_asset;
  }
}

///Represents Stellar native asset - <a href="https://www.stellar.org/developers/learn/concepts/assets.html" target="_blank">lumens (XLM)</a>
class AssetTypeNative extends Asset {
  AssetTypeNative() {}

  @override
  String get type => "native";

  @override
  bool operator ==(Object object) {
    return object is AssetTypeNative;
  }

  @override
  int get hashCode {
    return 0;
  }

  @override
  XdrAsset toXdr() {
    XdrAsset xdr_asset = XdrAsset();
    xdr_asset.discriminant = XdrAssetType.ASSET_TYPE_NATIVE;
    return xdr_asset;
  }
}
