import 'xdr_asset.dart';
import 'xdr_type.dart';
import 'xdr_enum.dart';
import 'xdr_data.dart';
import 'xdr_other.dart';
import 'xdr_entry.dart';
import "dart:typed_data";

class XdrAllowTrustOp {
  XdrAllowTrustOp() {}
  XdrAccountID _trustor;
  XdrAccountID get trustor => this._trustor;
  set trustor(XdrAccountID value) => this._trustor = value;

  XdrAllowTrustOpAsset _asset;
  XdrAllowTrustOpAsset get asset => this._asset;
  set asset(XdrAllowTrustOpAsset value) => this._asset = value;

  bool _authorize;
  bool get authorize => this._authorize;
  set authorize(bool value) => this._authorize = value;

  static void encode(
      XdrDataOutputStream stream, XdrAllowTrustOp encodedAllowTrustOp) {
    XdrAccountID.encode(stream, encodedAllowTrustOp.trustor);
    XdrAllowTrustOpAsset.encode(stream, encodedAllowTrustOp.asset);
    stream.writeInt(encodedAllowTrustOp.authorize ? 1 : 0);
  }

  static XdrAllowTrustOp decode(XdrDataInputStream stream) {
    XdrAllowTrustOp decodedAllowTrustOp = XdrAllowTrustOp();
    decodedAllowTrustOp.trustor = XdrAccountID.decode(stream);
    decodedAllowTrustOp.asset = XdrAllowTrustOpAsset.decode(stream);
    decodedAllowTrustOp.authorize = stream.readInt() == 1 ? true : false;
    return decodedAllowTrustOp;
  }
}

class XdrAllowTrustOpAsset {
  XdrAllowTrustOpAsset() {}
  XdrAssetType _type;
  XdrAssetType get discriminant => this._type;
  set discriminant(XdrAssetType value) => this._type = value;

  Uint8List _assetCode4;
  Uint8List get assetCode4 => this._assetCode4;
  set assetCode4(Uint8List value) => this._assetCode4 = value;

  Uint8List _assetCode12;
  Uint8List get assetCode12 => this._assetCode12;
  set assetCode12(Uint8List value) => this._assetCode12 = value;

  static void encode(XdrDataOutputStream stream,
      XdrAllowTrustOpAsset encodedAllowTrustOpAsset) {
    stream.writeInt(encodedAllowTrustOpAsset.discriminant.value);
    switch (encodedAllowTrustOpAsset.discriminant) {
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM4:
        stream.write(encodedAllowTrustOpAsset.assetCode4);
        break;
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM12:
        stream.write(encodedAllowTrustOpAsset.assetCode12);
        break;
    }
  }

  static XdrAllowTrustOpAsset decode(XdrDataInputStream stream) {
    XdrAllowTrustOpAsset decodedAllowTrustOpAsset = XdrAllowTrustOpAsset();
    XdrAssetType discriminant = XdrAssetType.decode(stream);
    decodedAllowTrustOpAsset.discriminant = discriminant;
    switch (decodedAllowTrustOpAsset.discriminant) {
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM4:
        int assetCode4size = 4;
        decodedAllowTrustOpAsset.assetCode4 = stream.readBytes(assetCode4size);
        break;
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM12:
        int assetCode12size = 12;
        decodedAllowTrustOpAsset.assetCode12 =
            stream.readBytes(assetCode12size);
        break;
    }
    return decodedAllowTrustOpAsset;
  }
}

class XdrAllowTrustResult {
  XdrAllowTrustResult() {}
  XdrAllowTrustResultCode _code;
  XdrAllowTrustResultCode get discriminant => this._code;
  set discriminant(XdrAllowTrustResultCode value) => this._code = value;

  static void encode(
      XdrDataOutputStream stream, XdrAllowTrustResult encodedAllowTrustResult) {
    stream.writeInt(encodedAllowTrustResult.discriminant.value);
    switch (encodedAllowTrustResult.discriminant) {
      case XdrAllowTrustResultCode.ALLOW_TRUST_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrAllowTrustResult decode(XdrDataInputStream stream) {
    XdrAllowTrustResult decodedAllowTrustResult = XdrAllowTrustResult();
    XdrAllowTrustResultCode discriminant =
        XdrAllowTrustResultCode.decode(stream);
    decodedAllowTrustResult.discriminant = discriminant;
    switch (decodedAllowTrustResult.discriminant) {
      case XdrAllowTrustResultCode.ALLOW_TRUST_SUCCESS:
        break;
      default:
        break;
    }
    return decodedAllowTrustResult;
  }
}

class XdrBumpSequenceOp {
  XdrBumpSequenceOp() {}
  XdrSequenceNumber _bumpTo;
  XdrSequenceNumber get bumpTo => this._bumpTo;
  set bumpTo(XdrSequenceNumber value) => this._bumpTo = value;

  static void encode(
      XdrDataOutputStream stream, XdrBumpSequenceOp encodedBumpSequenceOp) {
    XdrSequenceNumber.encode(stream, encodedBumpSequenceOp.bumpTo);
  }

  static XdrBumpSequenceOp decode(XdrDataInputStream stream) {
    XdrBumpSequenceOp decodedBumpSequenceOp = XdrBumpSequenceOp();
    decodedBumpSequenceOp.bumpTo = XdrSequenceNumber.decode(stream);
    return decodedBumpSequenceOp;
  }
}

class XdrBumpSequenceResult {
  XdrBumpSequenceResult() {}
  XdrBumpSequenceResultCode _code;
  XdrBumpSequenceResultCode get discriminant => this._code;
  set discriminant(XdrBumpSequenceResultCode value) => this._code = value;

  static void encode(XdrDataOutputStream stream,
      XdrBumpSequenceResult encodedBumpSequenceResult) {
    stream.writeInt(encodedBumpSequenceResult.discriminant.value);
    switch (encodedBumpSequenceResult.discriminant) {
      case XdrBumpSequenceResultCode.BUMP_SEQUENCE_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrBumpSequenceResult decode(XdrDataInputStream stream) {
    XdrBumpSequenceResult decodedBumpSequenceResult = XdrBumpSequenceResult();
    XdrBumpSequenceResultCode discriminant =
        XdrBumpSequenceResultCode.decode(stream);
    decodedBumpSequenceResult.discriminant = discriminant;
    switch (decodedBumpSequenceResult.discriminant) {
      case XdrBumpSequenceResultCode.BUMP_SEQUENCE_SUCCESS:
        break;
      default:
        break;
    }
    return decodedBumpSequenceResult;
  }
}

class XdrChangeTrustOp {
  XdrChangeTrustOp() {}
  XdrAsset _line;
  XdrAsset get line => this._line;
  set line(XdrAsset value) => this._line = value;

  XdrInt64 _limit;
  XdrInt64 get limit => this._limit;
  set limit(XdrInt64 value) => this._limit = value;

  static void encode(
      XdrDataOutputStream stream, XdrChangeTrustOp encodedChangeTrustOp) {
    XdrAsset.encode(stream, encodedChangeTrustOp.line);
    XdrInt64.encode(stream, encodedChangeTrustOp.limit);
  }

  static XdrChangeTrustOp decode(XdrDataInputStream stream) {
    XdrChangeTrustOp decodedChangeTrustOp = XdrChangeTrustOp();
    decodedChangeTrustOp.line = XdrAsset.decode(stream);
    decodedChangeTrustOp.limit = XdrInt64.decode(stream);
    return decodedChangeTrustOp;
  }
}

class XdrChangeTrustResult {
  XdrChangeTrustResult() {}
  XdrChangeTrustResultCode _code;
  XdrChangeTrustResultCode get discriminant => this._code;
  set discriminant(XdrChangeTrustResultCode value) => this._code = value;

  static void encode(XdrDataOutputStream stream,
      XdrChangeTrustResult encodedChangeTrustResult) {
    stream.writeInt(encodedChangeTrustResult.discriminant.value);
    switch (encodedChangeTrustResult.discriminant) {
      case XdrChangeTrustResultCode.CHANGE_TRUST_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrChangeTrustResult decode(XdrDataInputStream stream) {
    XdrChangeTrustResult decodedChangeTrustResult = XdrChangeTrustResult();
    XdrChangeTrustResultCode discriminant =
        XdrChangeTrustResultCode.decode(stream);
    decodedChangeTrustResult.discriminant = discriminant;
    switch (decodedChangeTrustResult.discriminant) {
      case XdrChangeTrustResultCode.CHANGE_TRUST_SUCCESS:
        break;
      default:
        break;
    }
    return decodedChangeTrustResult;
  }
}

class XdrCreateAccountOp {
  XdrCreateAccountOp() {}
  XdrAccountID _destination;
  XdrAccountID get destination => this._destination;
  set destination(XdrAccountID value) => this._destination = value;

  XdrInt64 _startingBalance;
  XdrInt64 get startingBalance => this._startingBalance;
  set startingBalance(XdrInt64 value) => this._startingBalance = value;

  static void encode(
      XdrDataOutputStream stream, XdrCreateAccountOp encodedCreateAccountOp) {
    XdrAccountID.encode(stream, encodedCreateAccountOp.destination);
    XdrInt64.encode(stream, encodedCreateAccountOp.startingBalance);
  }

  static XdrCreateAccountOp decode(XdrDataInputStream stream) {
    XdrCreateAccountOp decodedCreateAccountOp = XdrCreateAccountOp();
    decodedCreateAccountOp.destination = XdrAccountID.decode(stream);
    decodedCreateAccountOp.startingBalance = XdrInt64.decode(stream);
    return decodedCreateAccountOp;
  }
}

class XdrCreateAccountResult {
  XdrCreateAccountResult() {}
  XdrCreateAccountResultCode _code;
  XdrCreateAccountResultCode get discriminant => this._code;
  set discriminant(XdrCreateAccountResultCode value) => this._code = value;

  static void encode(XdrDataOutputStream stream,
      XdrCreateAccountResult encodedCreateAccountResult) {
    stream.writeInt(encodedCreateAccountResult.discriminant.value);
    switch (encodedCreateAccountResult.discriminant) {
      case XdrCreateAccountResultCode.CREATE_ACCOUNT_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrCreateAccountResult decode(XdrDataInputStream stream) {
    XdrCreateAccountResult decodedCreateAccountResult =
        XdrCreateAccountResult();
    XdrCreateAccountResultCode discriminant =
        XdrCreateAccountResultCode.decode(stream);
    decodedCreateAccountResult.discriminant = discriminant;
    switch (decodedCreateAccountResult.discriminant) {
      case XdrCreateAccountResultCode.CREATE_ACCOUNT_SUCCESS:
        break;
      default:
        break;
    }
    return decodedCreateAccountResult;
  }
}

class XdrCreatePassiveOfferOp {
  XdrCreatePassiveOfferOp() {}
  XdrAsset _selling;
  XdrAsset get selling => this._selling;
  set selling(XdrAsset value) => this._selling = value;

  XdrAsset _buying;
  XdrAsset get buying => this._buying;
  set buying(XdrAsset value) => this._buying = value;

  XdrInt64 _amount;
  XdrInt64 get amount => this._amount;
  set amount(XdrInt64 value) => this._amount = value;

  XdrPrice _price;
  XdrPrice get price => this._price;
  set price(XdrPrice value) => this._price = value;

  static void encode(XdrDataOutputStream stream,
      XdrCreatePassiveOfferOp encodedCreatePassiveOfferOp) {
    XdrAsset.encode(stream, encodedCreatePassiveOfferOp.selling);
    XdrAsset.encode(stream, encodedCreatePassiveOfferOp.buying);
    XdrInt64.encode(stream, encodedCreatePassiveOfferOp.amount);
    XdrPrice.encode(stream, encodedCreatePassiveOfferOp.price);
  }

  static XdrCreatePassiveOfferOp decode(XdrDataInputStream stream) {
    XdrCreatePassiveOfferOp decodedCreatePassiveOfferOp =
        XdrCreatePassiveOfferOp();
    decodedCreatePassiveOfferOp.selling = XdrAsset.decode(stream);
    decodedCreatePassiveOfferOp.buying = XdrAsset.decode(stream);
    decodedCreatePassiveOfferOp.amount = XdrInt64.decode(stream);
    decodedCreatePassiveOfferOp.price = XdrPrice.decode(stream);
    return decodedCreatePassiveOfferOp;
  }
}

class XdrInflationPayout {
  XdrInflationPayout() {}
  XdrAccountID _destination;
  XdrAccountID get destination => this._destination;
  set destination(XdrAccountID value) => this._destination = value;

  XdrInt64 _amount;
  XdrInt64 get amount => this._amount;
  set amount(XdrInt64 value) => this._amount = value;

  static void encode(
      XdrDataOutputStream stream, XdrInflationPayout encodedInflationPayout) {
    XdrAccountID.encode(stream, encodedInflationPayout.destination);
    XdrInt64.encode(stream, encodedInflationPayout.amount);
  }

  static XdrInflationPayout decode(XdrDataInputStream stream) {
    XdrInflationPayout decodedInflationPayout = XdrInflationPayout();
    decodedInflationPayout.destination = XdrAccountID.decode(stream);
    decodedInflationPayout.amount = XdrInt64.decode(stream);
    return decodedInflationPayout;
  }
}

class XdrInflationResult {
  XdrInflationResult() {}
  XdrInflationResultCode _code;
  XdrInflationResultCode get discriminant => this._code;
  set discriminant(XdrInflationResultCode value) => this._code = value;

  List<XdrInflationPayout> _payouts;
  List<XdrInflationPayout> get payouts => this._payouts;
  set payouts(List<XdrInflationPayout> value) => this._payouts = value;

  static void encode(
      XdrDataOutputStream stream, XdrInflationResult encodedInflationResult) {
    stream.writeInt(encodedInflationResult.discriminant.value);
    switch (encodedInflationResult.discriminant) {
      case XdrInflationResultCode.INFLATION_SUCCESS:
        int payoutssize = encodedInflationResult.payouts.length;
        stream.writeInt(payoutssize);
        for (int i = 0; i < payoutssize; i++) {
          XdrInflationPayout.encode(stream, encodedInflationResult.payouts[i]);
        }
        break;
      default:
        break;
    }
  }

  static XdrInflationResult decode(XdrDataInputStream stream) {
    XdrInflationResult decodedInflationResult = XdrInflationResult();
    XdrInflationResultCode discriminant = XdrInflationResultCode.decode(stream);
    decodedInflationResult.discriminant = discriminant;
    switch (decodedInflationResult.discriminant) {
      case XdrInflationResultCode.INFLATION_SUCCESS:
        int payoutssize = stream.readInt();
        decodedInflationResult.payouts = List<XdrInflationPayout>(payoutssize);
        for (int i = 0; i < payoutssize; i++) {
          decodedInflationResult.payouts[i] = XdrInflationPayout.decode(stream);
        }
        break;
      default:
        break;
    }
    return decodedInflationResult;
  }
}

class XdrManageDataOp {
  XdrManageDataOp() {}
  XdrString64 _dataName;
  XdrString64 get dataName => this._dataName;
  set dataName(XdrString64 value) => this._dataName = value;

  XdrDataValue _dataValue;
  XdrDataValue get dataValue => this._dataValue;
  set dataValue(XdrDataValue value) => this._dataValue = value;

  static void encode(
      XdrDataOutputStream stream, XdrManageDataOp encodedManageDataOp) {
    XdrString64.encode(stream, encodedManageDataOp.dataName);
    if (encodedManageDataOp.dataValue != null) {
      stream.writeInt(1);
      XdrDataValue.encode(stream, encodedManageDataOp.dataValue);
    } else {
      stream.writeInt(0);
    }
  }

  static XdrManageDataOp decode(XdrDataInputStream stream) {
    XdrManageDataOp decodedManageDataOp = XdrManageDataOp();
    decodedManageDataOp.dataName = XdrString64.decode(stream);
    int dataValuePresent = stream.readInt();
    if (dataValuePresent != 0) {
      decodedManageDataOp.dataValue = XdrDataValue.decode(stream);
    }
    return decodedManageDataOp;
  }
}

class XdrManageDataResult {
  XdrManageDataResult() {}
  XdrManageDataResultCode _code;
  XdrManageDataResultCode get discriminant => this._code;
  set discriminant(XdrManageDataResultCode value) => this._code = value;

  static void encode(
      XdrDataOutputStream stream, XdrManageDataResult encodedManageDataResult) {
    stream.writeInt(encodedManageDataResult.discriminant.value);
    switch (encodedManageDataResult.discriminant) {
      case XdrManageDataResultCode.MANAGE_DATA_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrManageDataResult decode(XdrDataInputStream stream) {
    XdrManageDataResult decodedManageDataResult = XdrManageDataResult();
    XdrManageDataResultCode discriminant =
        XdrManageDataResultCode.decode(stream);
    decodedManageDataResult.discriminant = discriminant;
    switch (decodedManageDataResult.discriminant) {
      case XdrManageDataResultCode.MANAGE_DATA_SUCCESS:
        break;
      default:
        break;
    }
    return decodedManageDataResult;
  }
}

class XdrManageOfferOp {
  XdrManageOfferOp() {}
  XdrAsset _selling;
  XdrAsset get selling => this._selling;
  set selling(XdrAsset value) => this._selling = value;

  XdrAsset _buying;
  XdrAsset get buying => this._buying;
  set buying(XdrAsset value) => this._buying = value;

  XdrInt64 _amount;
  XdrInt64 get amount => this._amount;
  set amount(XdrInt64 value) => this._amount = value;

  XdrPrice _price;
  XdrPrice get price => this._price;
  set price(XdrPrice value) => this._price = value;

  XdrUint64 _offerID;
  XdrUint64 get offerID => this._offerID;
  set offerID(XdrUint64 value) => this._offerID = value;

  static void encode(
      XdrDataOutputStream stream, XdrManageOfferOp encodedManageOfferOp) {
    XdrAsset.encode(stream, encodedManageOfferOp.selling);
    XdrAsset.encode(stream, encodedManageOfferOp.buying);
    XdrInt64.encode(stream, encodedManageOfferOp.amount);
    XdrPrice.encode(stream, encodedManageOfferOp.price);
    XdrUint64.encode(stream, encodedManageOfferOp.offerID);
  }

  static XdrManageOfferOp decode(XdrDataInputStream stream) {
    XdrManageOfferOp decodedManageOfferOp = XdrManageOfferOp();
    decodedManageOfferOp.selling = XdrAsset.decode(stream);
    decodedManageOfferOp.buying = XdrAsset.decode(stream);
    decodedManageOfferOp.amount = XdrInt64.decode(stream);
    decodedManageOfferOp.price = XdrPrice.decode(stream);
    decodedManageOfferOp.offerID = XdrUint64.decode(stream);
    return decodedManageOfferOp;
  }
}

class XdrManageOfferResult {
  XdrManageOfferResult() {}
  XdrManageOfferResultCode _code;
  XdrManageOfferResultCode get discriminant => this._code;
  set discriminant(XdrManageOfferResultCode value) => this._code = value;

  XdrManageOfferSuccessResult _success;
  XdrManageOfferSuccessResult get success => this._success;
  set success(XdrManageOfferSuccessResult value) => this._success = value;

  static void encode(XdrDataOutputStream stream,
      XdrManageOfferResult encodedManageOfferResult) {
    stream.writeInt(encodedManageOfferResult.discriminant.value);
    switch (encodedManageOfferResult.discriminant) {
      case XdrManageOfferResultCode.MANAGE_OFFER_SUCCESS:
        XdrManageOfferSuccessResult.encode(
            stream, encodedManageOfferResult.success);
        break;
      default:
        break;
    }
  }

  static XdrManageOfferResult decode(XdrDataInputStream stream) {
    XdrManageOfferResult decodedManageOfferResult = XdrManageOfferResult();
    XdrManageOfferResultCode discriminant =
        XdrManageOfferResultCode.decode(stream);
    decodedManageOfferResult.discriminant = discriminant;
    switch (decodedManageOfferResult.discriminant) {
      case XdrManageOfferResultCode.MANAGE_OFFER_SUCCESS:
        decodedManageOfferResult.success =
            XdrManageOfferSuccessResult.decode(stream);
        break;
      default:
        break;
    }
    return decodedManageOfferResult;
  }
}

class XdrManageOfferSuccessResult {
  XdrManageOfferSuccessResult() {}
  List<XdrClaimOfferAtom> _offersClaimed;
  List<XdrClaimOfferAtom> get offersClaimed => this._offersClaimed;
  set offersClaimed(List<XdrClaimOfferAtom> value) =>
      this._offersClaimed = value;

  XdrManageOfferSuccessResultOffer _offer;
  XdrManageOfferSuccessResultOffer get offer => this._offer;
  set offer(XdrManageOfferSuccessResultOffer value) => this._offer = value;

  static void encode(XdrDataOutputStream stream,
      XdrManageOfferSuccessResult encodedManageOfferSuccessResult) {
    int offersClaimedsize =
        encodedManageOfferSuccessResult.offersClaimed.length;
    stream.writeInt(offersClaimedsize);
    for (int i = 0; i < offersClaimedsize; i++) {
      XdrClaimOfferAtom.encode(
          stream, encodedManageOfferSuccessResult.offersClaimed[i]);
    }
    XdrManageOfferSuccessResultOffer.encode(
        stream, encodedManageOfferSuccessResult.offer);
  }

  static XdrManageOfferSuccessResult decode(XdrDataInputStream stream) {
    XdrManageOfferSuccessResult decodedManageOfferSuccessResult =
        XdrManageOfferSuccessResult();
    int offersClaimedsize = stream.readInt();
    decodedManageOfferSuccessResult.offersClaimed =
        List<XdrClaimOfferAtom>(offersClaimedsize);
    for (int i = 0; i < offersClaimedsize; i++) {
      decodedManageOfferSuccessResult.offersClaimed[i] =
          XdrClaimOfferAtom.decode(stream);
    }
    decodedManageOfferSuccessResult.offer =
        XdrManageOfferSuccessResultOffer.decode(stream);
    return decodedManageOfferSuccessResult;
  }
}

class XdrManageOfferSuccessResultOffer {
  XdrManageOfferSuccessResultOffer() {}
  XdrManageOfferEffect _effect;
  XdrManageOfferEffect get discriminant => this._effect;
  set discriminant(XdrManageOfferEffect value) => this._effect = value;

  XdrOfferEntry _offer;
  XdrOfferEntry get offer => this._offer;
  set offer(XdrOfferEntry value) => this._offer = value;

  static void encode(XdrDataOutputStream stream,
      XdrManageOfferSuccessResultOffer encodedManageOfferSuccessResultOffer) {
    stream.writeInt(encodedManageOfferSuccessResultOffer.discriminant.value);
    switch (encodedManageOfferSuccessResultOffer.discriminant) {
      case XdrManageOfferEffect.MANAGE_OFFER_CREATED:
      case XdrManageOfferEffect.MANAGE_OFFER_UPDATED:
        XdrOfferEntry.encode(
            stream, encodedManageOfferSuccessResultOffer.offer);
        break;
      default:
        break;
    }
  }

  static XdrManageOfferSuccessResultOffer decode(XdrDataInputStream stream) {
    XdrManageOfferSuccessResultOffer decodedManageOfferSuccessResultOffer =
        XdrManageOfferSuccessResultOffer();
    XdrManageOfferEffect discriminant = XdrManageOfferEffect.decode(stream);
    decodedManageOfferSuccessResultOffer.discriminant = discriminant;
    switch (decodedManageOfferSuccessResultOffer.discriminant) {
      case XdrManageOfferEffect.MANAGE_OFFER_CREATED:
      case XdrManageOfferEffect.MANAGE_OFFER_UPDATED:
        decodedManageOfferSuccessResultOffer.offer =
            XdrOfferEntry.decode(stream);
        break;
      default:
        break;
    }
    return decodedManageOfferSuccessResultOffer;
  }
}

class XdrPathPaymentOp {
  XdrPathPaymentOp() {}
  XdrAsset _sendAsset;
  XdrAsset get sendAsset => this._sendAsset;
  set sendAsset(XdrAsset value) => this._sendAsset = value;

  XdrInt64 _sendMax;
  XdrInt64 get sendMax => this._sendMax;
  set sendMax(XdrInt64 value) => this._sendMax = value;

  XdrAccountID _destination;
  XdrAccountID get destination => this._destination;
  set destination(XdrAccountID value) => this._destination = value;

  XdrAsset _destAsset;
  XdrAsset get destAsset => this._destAsset;
  set destAsset(XdrAsset value) => this._destAsset = value;

  XdrInt64 _destAmount;
  XdrInt64 get destAmount => this._destAmount;
  set destAmount(XdrInt64 value) => this._destAmount = value;

  List<XdrAsset> _path;
  List<XdrAsset> get path => this._path;
  set path(List<XdrAsset> value) => this._path = value;

  static void encode(
      XdrDataOutputStream stream, XdrPathPaymentOp encodedPathPaymentOp) {
    XdrAsset.encode(stream, encodedPathPaymentOp.sendAsset);
    XdrInt64.encode(stream, encodedPathPaymentOp.sendMax);
    XdrAccountID.encode(stream, encodedPathPaymentOp.destination);
    XdrAsset.encode(stream, encodedPathPaymentOp.destAsset);
    XdrInt64.encode(stream, encodedPathPaymentOp.destAmount);
    int pathsize = encodedPathPaymentOp.path.length;
    stream.writeInt(pathsize);
    for (int i = 0; i < pathsize; i++) {
      XdrAsset.encode(stream, encodedPathPaymentOp.path[i]);
    }
  }

  static XdrPathPaymentOp decode(XdrDataInputStream stream) {
    XdrPathPaymentOp decodedPathPaymentOp = XdrPathPaymentOp();
    decodedPathPaymentOp.sendAsset = XdrAsset.decode(stream);
    decodedPathPaymentOp.sendMax = XdrInt64.decode(stream);
    decodedPathPaymentOp.destination = XdrAccountID.decode(stream);
    decodedPathPaymentOp.destAsset = XdrAsset.decode(stream);
    decodedPathPaymentOp.destAmount = XdrInt64.decode(stream);
    int pathsize = stream.readInt();
    decodedPathPaymentOp.path = List<XdrAsset>(pathsize);
    for (int i = 0; i < pathsize; i++) {
      decodedPathPaymentOp.path[i] = XdrAsset.decode(stream);
    }
    return decodedPathPaymentOp;
  }
}

class XdrPathPaymentResult {
  XdrPathPaymentResult() {}
  XdrPathPaymentResultCode _code;
  XdrPathPaymentResultCode get discriminant => this._code;
  set discriminant(XdrPathPaymentResultCode value) => this._code = value;

  XdrPathPaymentResultSuccess _success;
  XdrPathPaymentResultSuccess get success => this._success;
  set success(XdrPathPaymentResultSuccess value) => this._success = value;

  XdrAsset _noIssuer;
  XdrAsset get noIssuer => this._noIssuer;
  set noIssuer(XdrAsset value) => this._noIssuer = value;

  static void encode(XdrDataOutputStream stream,
      XdrPathPaymentResult encodedPathPaymentResult) {
    stream.writeInt(encodedPathPaymentResult.discriminant.value);
    switch (encodedPathPaymentResult.discriminant) {
      case XdrPathPaymentResultCode.PATH_PAYMENT_SUCCESS:
        XdrPathPaymentResultSuccess.encode(
            stream, encodedPathPaymentResult.success);
        break;
      case XdrPathPaymentResultCode.PATH_PAYMENT_NO_ISSUER:
        XdrAsset.encode(stream, encodedPathPaymentResult.noIssuer);
        break;
      default:
        break;
    }
  }

  static XdrPathPaymentResult decode(XdrDataInputStream stream) {
    XdrPathPaymentResult decodedPathPaymentResult = XdrPathPaymentResult();
    XdrPathPaymentResultCode discriminant =
        XdrPathPaymentResultCode.decode(stream);
    decodedPathPaymentResult.discriminant = discriminant;
    switch (decodedPathPaymentResult.discriminant) {
      case XdrPathPaymentResultCode.PATH_PAYMENT_SUCCESS:
        decodedPathPaymentResult.success =
            XdrPathPaymentResultSuccess.decode(stream);
        break;
      case XdrPathPaymentResultCode.PATH_PAYMENT_NO_ISSUER:
        decodedPathPaymentResult.noIssuer = XdrAsset.decode(stream);
        break;
      default:
        break;
    }
    return decodedPathPaymentResult;
  }
}

class XdrPathPaymentResultSuccess {
  XdrPathPaymentResultSuccess() {}
  List<XdrClaimOfferAtom> _offers;
  List<XdrClaimOfferAtom> get offers => this._offers;
  set offers(List<XdrClaimOfferAtom> value) => this._offers = value;

  XdrSimplePaymentResult _last;
  XdrSimplePaymentResult get last => this._last;
  set last(XdrSimplePaymentResult value) => this._last = value;

  static void encode(XdrDataOutputStream stream,
      XdrPathPaymentResultSuccess encodedPathPaymentResultSuccess) {
    int offerssize = encodedPathPaymentResultSuccess.offers.length;
    stream.writeInt(offerssize);
    for (int i = 0; i < offerssize; i++) {
      XdrClaimOfferAtom.encode(
          stream, encodedPathPaymentResultSuccess.offers[i]);
    }
    XdrSimplePaymentResult.encode(stream, encodedPathPaymentResultSuccess.last);
  }

  static XdrPathPaymentResultSuccess decode(XdrDataInputStream stream) {
    XdrPathPaymentResultSuccess decodedPathPaymentResultSuccess =
        XdrPathPaymentResultSuccess();
    int offerssize = stream.readInt();
    decodedPathPaymentResultSuccess.offers =
        List<XdrClaimOfferAtom>(offerssize);
    for (int i = 0; i < offerssize; i++) {
      decodedPathPaymentResultSuccess.offers[i] =
          XdrClaimOfferAtom.decode(stream);
    }
    decodedPathPaymentResultSuccess.last =
        XdrSimplePaymentResult.decode(stream);
    return decodedPathPaymentResultSuccess;
  }
}

class XdrSimplePaymentResult {
  XdrSimplePaymentResult() {}
  XdrAccountID _destination;
  XdrAccountID get destination => this._destination;
  set destination(XdrAccountID value) => this._destination = value;

  XdrAsset _asset;
  XdrAsset get asset => this._asset;
  set asset(XdrAsset value) => this._asset = value;

  XdrInt64 _amount;
  XdrInt64 get amount => this._amount;
  set amount(XdrInt64 value) => this._amount = value;

  static void encode(XdrDataOutputStream stream,
      XdrSimplePaymentResult encodedSimplePaymentResult) {
    XdrAccountID.encode(stream, encodedSimplePaymentResult.destination);
    XdrAsset.encode(stream, encodedSimplePaymentResult.asset);
    XdrInt64.encode(stream, encodedSimplePaymentResult.amount);
  }

  static XdrSimplePaymentResult decode(XdrDataInputStream stream) {
    XdrSimplePaymentResult decodedSimplePaymentResult =
        XdrSimplePaymentResult();
    decodedSimplePaymentResult.destination = XdrAccountID.decode(stream);
    decodedSimplePaymentResult.asset = XdrAsset.decode(stream);
    decodedSimplePaymentResult.amount = XdrInt64.decode(stream);
    return decodedSimplePaymentResult;
  }
}

class XdrPaymentOp {
  XdrPaymentOp() {}
  XdrAccountID _destination;
  XdrAccountID get destination => this._destination;
  set destination(XdrAccountID value) => this._destination = value;

  XdrAsset _asset;
  XdrAsset get asset => this._asset;
  set asset(XdrAsset value) => this._asset = value;

  XdrInt64 _amount;
  XdrInt64 get amount => this._amount;
  set amount(XdrInt64 value) => this._amount = value;

  static void encode(
      XdrDataOutputStream stream, XdrPaymentOp encodedPaymentOp) {
    XdrAccountID.encode(stream, encodedPaymentOp.destination);
    XdrAsset.encode(stream, encodedPaymentOp.asset);
    XdrInt64.encode(stream, encodedPaymentOp.amount);
  }

  static XdrPaymentOp decode(XdrDataInputStream stream) {
    XdrPaymentOp decodedPaymentOp = XdrPaymentOp();
    decodedPaymentOp.destination = XdrAccountID.decode(stream);
    decodedPaymentOp.asset = XdrAsset.decode(stream);
    decodedPaymentOp.amount = XdrInt64.decode(stream);
    return decodedPaymentOp;
  }
}

class XdrPaymentResult {
  XdrPaymentResult() {}
  XdrPaymentResultCode _code;
  XdrPaymentResultCode get discriminant => this._code;
  set discriminant(XdrPaymentResultCode value) => this._code = value;

  static void encode(
      XdrDataOutputStream stream, XdrPaymentResult encodedPaymentResult) {
    stream.writeInt(encodedPaymentResult.discriminant.value);
    switch (encodedPaymentResult.discriminant) {
      case XdrPaymentResultCode.PAYMENT_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrPaymentResult decode(XdrDataInputStream stream) {
    XdrPaymentResult decodedPaymentResult = XdrPaymentResult();
    XdrPaymentResultCode discriminant = XdrPaymentResultCode.decode(stream);
    decodedPaymentResult.discriminant = discriminant;
    switch (decodedPaymentResult.discriminant) {
      case XdrPaymentResultCode.PAYMENT_SUCCESS:
        break;
      default:
        break;
    }
    return decodedPaymentResult;
  }
}

class XdrSetOptionsOp {
  XdrSetOptionsOp() {}
  XdrAccountID _inflationDest;
  XdrAccountID get inflationDest => this._inflationDest;
  void set inflationDest(XdrAccountID value) => this._inflationDest = value;

  XdrUint32 _clearFlags;
  XdrUint32 get clearFlags => this._clearFlags;
  set clearFlags(XdrUint32 value) => this._clearFlags = value;

  XdrUint32 _setFlags;
  XdrUint32 get setFlags => this._setFlags;
  set setFlags(XdrUint32 value) => this._setFlags = value;

  XdrUint32 _masterWeight;
  XdrUint32 get masterWeight => this._masterWeight;
  set masterWeight(XdrUint32 value) => this._masterWeight = value;

  XdrUint32 _lowThreshold;
  XdrUint32 get lowThreshold => this._lowThreshold;
  set lowThreshold(XdrUint32 value) => this._lowThreshold = value;

  XdrUint32 _medThreshold;
  XdrUint32 get medThreshold => this._medThreshold;
  set medThreshold(XdrUint32 value) => this._medThreshold = value;

  XdrUint32 _highThreshold;
  XdrUint32 get highThreshold => this._highThreshold;
  set highThreshold(XdrUint32 value) => this._highThreshold = value;

  XdrString32 _homeDomain;
  XdrString32 get homeDomain => this._homeDomain;
  set homeDomain(XdrString32 value) => this._homeDomain = value;

  XdrSigner _signer;
  XdrSigner get signer => this._signer;
  set signer(XdrSigner value) => this._signer = value;

  static void encode(
      XdrDataOutputStream stream, XdrSetOptionsOp encodedSetOptionsOp) {
    if (encodedSetOptionsOp.inflationDest != null) {
      stream.writeInt(1);
      XdrAccountID.encode(stream, encodedSetOptionsOp.inflationDest);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.clearFlags != null) {
      stream.writeInt(1);
      XdrUint32.encode(stream, encodedSetOptionsOp.clearFlags);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.setFlags != null) {
      stream.writeInt(1);
      XdrUint32.encode(stream, encodedSetOptionsOp.setFlags);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.masterWeight != null) {
      stream.writeInt(1);
      XdrUint32.encode(stream, encodedSetOptionsOp.masterWeight);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.lowThreshold != null) {
      stream.writeInt(1);
      XdrUint32.encode(stream, encodedSetOptionsOp.lowThreshold);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.medThreshold != null) {
      stream.writeInt(1);
      XdrUint32.encode(stream, encodedSetOptionsOp.medThreshold);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.highThreshold != null) {
      stream.writeInt(1);
      XdrUint32.encode(stream, encodedSetOptionsOp.highThreshold);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.homeDomain != null) {
      stream.writeInt(1);
      XdrString32.encode(stream, encodedSetOptionsOp.homeDomain);
    } else {
      stream.writeInt(0);
    }
    if (encodedSetOptionsOp.signer != null) {
      stream.writeInt(1);
      XdrSigner.encode(stream, encodedSetOptionsOp.signer);
    } else {
      stream.writeInt(0);
    }
  }

  static XdrSetOptionsOp decode(XdrDataInputStream stream) {
    XdrSetOptionsOp decodedSetOptionsOp = XdrSetOptionsOp();
    int inflationDestPresent = stream.readInt();
    if (inflationDestPresent != 0) {
      decodedSetOptionsOp.inflationDest = XdrAccountID.decode(stream);
    }
    int clearFlagsPresent = stream.readInt();
    if (clearFlagsPresent != 0) {
      decodedSetOptionsOp.clearFlags = XdrUint32.decode(stream);
    }
    int setFlagsPresent = stream.readInt();
    if (setFlagsPresent != 0) {
      decodedSetOptionsOp.setFlags = XdrUint32.decode(stream);
    }
    int masterWeightPresent = stream.readInt();
    if (masterWeightPresent != 0) {
      decodedSetOptionsOp.masterWeight = XdrUint32.decode(stream);
    }
    int lowThresholdPresent = stream.readInt();
    if (lowThresholdPresent != 0) {
      decodedSetOptionsOp.lowThreshold = XdrUint32.decode(stream);
    }
    int medThresholdPresent = stream.readInt();
    if (medThresholdPresent != 0) {
      decodedSetOptionsOp.medThreshold = XdrUint32.decode(stream);
    }
    int highThresholdPresent = stream.readInt();
    if (highThresholdPresent != 0) {
      decodedSetOptionsOp.highThreshold = XdrUint32.decode(stream);
    }
    int homeDomainPresent = stream.readInt();
    if (homeDomainPresent != 0) {
      decodedSetOptionsOp.homeDomain = XdrString32.decode(stream);
    }
    int signerPresent = stream.readInt();
    if (signerPresent != 0) {
      decodedSetOptionsOp.signer = XdrSigner.decode(stream);
    }
    return decodedSetOptionsOp;
  }
}

class XdrSetOptionsResult {
  XdrSetOptionsResult() {}
  XdrSetOptionsResultCode _code;
  XdrSetOptionsResultCode get discriminant => this._code;
  set discriminant(XdrSetOptionsResultCode value) => this._code = value;

  static void encode(
      XdrDataOutputStream stream, XdrSetOptionsResult encodedSetOptionsResult) {
    stream.writeInt(encodedSetOptionsResult.discriminant.value);
    switch (encodedSetOptionsResult.discriminant) {
      case XdrSetOptionsResultCode.SET_OPTIONS_SUCCESS:
        break;
      default:
        break;
    }
  }

  static XdrSetOptionsResult decode(XdrDataInputStream stream) {
    XdrSetOptionsResult decodedSetOptionsResult = XdrSetOptionsResult();
    XdrSetOptionsResultCode discriminant =
        XdrSetOptionsResultCode.decode(stream);
    decodedSetOptionsResult.discriminant = discriminant;
    switch (decodedSetOptionsResult.discriminant) {
      case XdrSetOptionsResultCode.SET_OPTIONS_SUCCESS:
        break;
      default:
        break;
    }
    return decodedSetOptionsResult;
  }
}

class XdrOperation {
  XdrOperation() {}
  XdrAccountID _sourceAccount;
  XdrAccountID get sourceAccount => this._sourceAccount;
  set sourceAccount(XdrAccountID value) => this._sourceAccount = value;

  XdrOperationBody _body;
  XdrOperationBody get body => this._body;
  set body(XdrOperationBody value) => this._body = value;

  static void encode(
      XdrDataOutputStream stream, XdrOperation encodedOperation) {
    if (encodedOperation.sourceAccount != null) {
      stream.writeInt(1);
      XdrAccountID.encode(stream, encodedOperation.sourceAccount);
    } else {
      stream.writeInt(0);
    }
    XdrOperationBody.encode(stream, encodedOperation.body);
  }

  static XdrOperation decode(XdrDataInputStream stream) {
    XdrOperation decodedOperation = XdrOperation();
    int sourceAccountPresent = stream.readInt();
    if (sourceAccountPresent != 0) {
      decodedOperation.sourceAccount = XdrAccountID.decode(stream);
    }
    decodedOperation.body = XdrOperationBody.decode(stream);
    return decodedOperation;
  }
}

class XdrOperationBody {
  XdrOperationBody() {}
  XdrOperationType _type;
  XdrOperationType get discriminant => this._type;
  set discriminant(XdrOperationType value) => this._type = value;

  XdrCreateAccountOp _createAccountOp;
  XdrCreateAccountOp get createAccountOp => this._createAccountOp;
  set createAccountOp(XdrCreateAccountOp value) =>
      this._createAccountOp = value;

  XdrPaymentOp _paymentOp;
  XdrPaymentOp get paymentOp => this._paymentOp;
  set paymentOp(XdrPaymentOp value) => this._paymentOp = value;

  XdrPathPaymentOp _pathPaymentOp;
  XdrPathPaymentOp get pathPaymentOp => this._pathPaymentOp;
  set pathPaymentOp(XdrPathPaymentOp value) => this._pathPaymentOp = value;

  XdrManageOfferOp _manageOfferOp;
  XdrManageOfferOp get manageOfferOp => this._manageOfferOp;
  set manageOfferOp(XdrManageOfferOp value) => this._manageOfferOp = value;

  XdrCreatePassiveOfferOp _createPassiveOfferOp;
  XdrCreatePassiveOfferOp get createPassiveOfferOp =>
      this._createPassiveOfferOp;
  set createPassiveOfferOp(XdrCreatePassiveOfferOp value) =>
      this._createPassiveOfferOp = value;

  XdrSetOptionsOp _setOptionsOp;
  XdrSetOptionsOp get setOptionsOp => this._setOptionsOp;
  set setOptionsOp(XdrSetOptionsOp value) => this._setOptionsOp = value;

  XdrChangeTrustOp _changeTrustOp;
  XdrChangeTrustOp get changeTrustOp => this._changeTrustOp;
  set changeTrustOp(XdrChangeTrustOp value) => this._changeTrustOp = value;

  XdrAllowTrustOp _allowTrustOp;
  XdrAllowTrustOp get allowTrustOp => this._allowTrustOp;
  set allowTrustOp(XdrAllowTrustOp value) => this._allowTrustOp = value;

  XdrAccountID _destination;
  XdrAccountID get destination => this._destination;
  set destination(XdrAccountID value) => this._destination = value;

  XdrManageDataOp _manageDataOp;
  XdrManageDataOp get manageDataOp => this._manageDataOp;
  set manageDataOp(XdrManageDataOp value) => this._manageDataOp = value;

  XdrBumpSequenceOp _bumpSequenceOp;
  XdrBumpSequenceOp get bumpSequenceOp => this._bumpSequenceOp;
  set bumpSequenceOp(XdrBumpSequenceOp value) => this._bumpSequenceOp = value;

  static void encode(
      XdrDataOutputStream stream, XdrOperationBody encodedOperationBody) {
    stream.writeInt(encodedOperationBody.discriminant.value);
    switch (encodedOperationBody.discriminant) {
      case XdrOperationType.CREATE_ACCOUNT:
        XdrCreateAccountOp.encode(stream, encodedOperationBody.createAccountOp);
        break;
      case XdrOperationType.PAYMENT:
        XdrPaymentOp.encode(stream, encodedOperationBody.paymentOp);
        break;
      case XdrOperationType.PATH_PAYMENT:
        XdrPathPaymentOp.encode(stream, encodedOperationBody.pathPaymentOp);
        break;
      case XdrOperationType.MANAGE_OFFER:
        XdrManageOfferOp.encode(stream, encodedOperationBody.manageOfferOp);
        break;
      case XdrOperationType.CREATE_PASSIVE_OFFER:
        XdrCreatePassiveOfferOp.encode(
            stream, encodedOperationBody.createPassiveOfferOp);
        break;
      case XdrOperationType.SET_OPTIONS:
        XdrSetOptionsOp.encode(stream, encodedOperationBody.setOptionsOp);
        break;
      case XdrOperationType.CHANGE_TRUST:
        XdrChangeTrustOp.encode(stream, encodedOperationBody.changeTrustOp);
        break;
      case XdrOperationType.ALLOW_TRUST:
        XdrAllowTrustOp.encode(stream, encodedOperationBody.allowTrustOp);
        break;
      case XdrOperationType.ACCOUNT_MERGE:
        XdrAccountID.encode(stream, encodedOperationBody.destination);
        break;
      case XdrOperationType.INFLATION:
        break;
      case XdrOperationType.MANAGE_DATA:
        XdrManageDataOp.encode(stream, encodedOperationBody.manageDataOp);
        break;
      case XdrOperationType.BUMP_SEQUENCE:
        XdrBumpSequenceOp.encode(stream, encodedOperationBody.bumpSequenceOp);
        break;
    }
  }

  static XdrOperationBody decode(XdrDataInputStream stream) {
    XdrOperationBody decodedOperationBody = XdrOperationBody();
    XdrOperationType discriminant = XdrOperationType.decode(stream);
    decodedOperationBody.discriminant = discriminant;
    switch (decodedOperationBody.discriminant) {
      case XdrOperationType.CREATE_ACCOUNT:
        decodedOperationBody.createAccountOp =
            XdrCreateAccountOp.decode(stream);
        break;
      case XdrOperationType.PAYMENT:
        decodedOperationBody.paymentOp = XdrPaymentOp.decode(stream);
        break;
      case XdrOperationType.PATH_PAYMENT:
        decodedOperationBody.pathPaymentOp = XdrPathPaymentOp.decode(stream);
        break;
      case XdrOperationType.MANAGE_OFFER:
        decodedOperationBody.manageOfferOp = XdrManageOfferOp.decode(stream);
        break;
      case XdrOperationType.CREATE_PASSIVE_OFFER:
        decodedOperationBody.createPassiveOfferOp =
            XdrCreatePassiveOfferOp.decode(stream);
        break;
      case XdrOperationType.SET_OPTIONS:
        decodedOperationBody.setOptionsOp = XdrSetOptionsOp.decode(stream);
        break;
      case XdrOperationType.CHANGE_TRUST:
        decodedOperationBody.changeTrustOp = XdrChangeTrustOp.decode(stream);
        break;
      case XdrOperationType.ALLOW_TRUST:
        decodedOperationBody.allowTrustOp = XdrAllowTrustOp.decode(stream);
        break;
      case XdrOperationType.ACCOUNT_MERGE:
        decodedOperationBody.destination = XdrAccountID.decode(stream);
        break;
      case XdrOperationType.INFLATION:
        break;
      case XdrOperationType.MANAGE_DATA:
        decodedOperationBody.manageDataOp = XdrManageDataOp.decode(stream);
        break;
      case XdrOperationType.BUMP_SEQUENCE:
        decodedOperationBody.bumpSequenceOp = XdrBumpSequenceOp.decode(stream);
        break;
    }
    return decodedOperationBody;
  }
}

class XdrOperationMeta {
  XdrOperationMeta() {}
  XdrLedgerEntryChanges _changes;
  XdrLedgerEntryChanges get changes => this._changes;
  set changes(XdrLedgerEntryChanges value) => this._changes = value;

  static void encode(
      XdrDataOutputStream stream, XdrOperationMeta encodedOperationMeta) {
    XdrLedgerEntryChanges.encode(stream, encodedOperationMeta.changes);
  }

  static XdrOperationMeta decode(XdrDataInputStream stream) {
    XdrOperationMeta decodedOperationMeta = XdrOperationMeta();
    decodedOperationMeta.changes = XdrLedgerEntryChanges.decode(stream);
    return decodedOperationMeta;
  }
}

class XdrOperationResult {
  XdrOperationResult() {}
  XdrOperationResultCode _code;
  XdrOperationResultCode get discriminant => this._code;
  set discriminant(XdrOperationResultCode value) => this._code = value;

  XdrOperationResultTr _tr;
  XdrOperationResultTr get tr => this._tr;
  set tr(XdrOperationResultTr value) => this._tr = value;

  static void encode(
      XdrDataOutputStream stream, XdrOperationResult encodedOperationResult) {
    stream.writeInt(encodedOperationResult.discriminant.value);
    switch (encodedOperationResult.discriminant) {
      case XdrOperationResultCode.opINNER:
        XdrOperationResultTr.encode(stream, encodedOperationResult.tr);
        break;
      default:
        break;
    }
  }

  static XdrOperationResult decode(XdrDataInputStream stream) {
    XdrOperationResult decodedOperationResult = XdrOperationResult();
    XdrOperationResultCode discriminant = XdrOperationResultCode.decode(stream);
    decodedOperationResult.discriminant = discriminant;
    switch (decodedOperationResult.discriminant) {
      case XdrOperationResultCode.opINNER:
        decodedOperationResult.tr = XdrOperationResultTr.decode(stream);
        break;
      default:
        break;
    }
    return decodedOperationResult;
  }
}

class XdrOperationResultTr {
  XdrOperationResultTr() {}
  XdrOperationType _type;
  XdrOperationType get discriminant => this._type;
  set discriminant(XdrOperationType value) => this._type = value;

  XdrCreateAccountResult _createAccountResult;
  XdrCreateAccountResult get createAccountResult => this._createAccountResult;
  set createAccountResult(XdrCreateAccountResult value) =>
      this._createAccountResult = value;

  XdrPaymentResult _paymentResult;
  XdrPaymentResult get paymentResult => this._paymentResult;
  set paymentResult(XdrPaymentResult value) => this._paymentResult = value;

  XdrPathPaymentResult _pathPaymentResult;
  XdrPathPaymentResult get pathPaymentResult => this._pathPaymentResult;
  set pathPaymentResult(XdrPathPaymentResult value) =>
      this._pathPaymentResult = value;

  XdrManageOfferResult _manageOfferResult;
  XdrManageOfferResult get manageOfferResult => this._manageOfferResult;
  set manageOfferResult(XdrManageOfferResult value) =>
      this._manageOfferResult = value;

  XdrManageOfferResult _createPassiveOfferResult;
  XdrManageOfferResult get createPassiveOfferResult =>
      this._createPassiveOfferResult;
  set createPassiveOfferResult(XdrManageOfferResult value) =>
      this._createPassiveOfferResult = value;

  XdrSetOptionsResult _setOptionsResult;
  XdrSetOptionsResult get setOptionsResult => this._setOptionsResult;
  set setOptionsResult(XdrSetOptionsResult value) =>
      this._setOptionsResult = value;

  XdrChangeTrustResult _changeTrustResult;
  XdrChangeTrustResult get changeTrustResult => this._changeTrustResult;
  set changeTrustResult(XdrChangeTrustResult value) =>
      this._changeTrustResult = value;

  XdrAllowTrustResult _allowTrustResult;
  XdrAllowTrustResult get allowTrustResult => this._allowTrustResult;
  set allowTrustResult(XdrAllowTrustResult value) =>
      this._allowTrustResult = value;

  XdrAccountMergeResult _accountMergeResult;
  XdrAccountMergeResult get accountMergeResult => this._accountMergeResult;
  set accountMergeResult(XdrAccountMergeResult value) =>
      this._accountMergeResult = value;

  XdrInflationResult _inflationResult;
  XdrInflationResult get inflationResult => this._inflationResult;
  set inflationResult(XdrInflationResult value) =>
      this._inflationResult = value;

  XdrManageDataResult _manageDataResult;
  XdrManageDataResult get manageDataResult => this._manageDataResult;
  set manageDataResult(XdrManageDataResult value) =>
      this._manageDataResult = value;

  XdrBumpSequenceResult _bumpSeqResult;
  XdrBumpSequenceResult get bumpSeqResult => this._bumpSeqResult;
  set bumpSeqResult(XdrBumpSequenceResult value) => this._bumpSeqResult = value;

  static void encode(XdrDataOutputStream stream,
      XdrOperationResultTr encodedOperationResultTr) {
    stream.writeInt(encodedOperationResultTr.discriminant.value);
    switch (encodedOperationResultTr.discriminant) {
      case XdrOperationType.CREATE_ACCOUNT:
        XdrCreateAccountResult.encode(
            stream, encodedOperationResultTr.createAccountResult);
        break;
      case XdrOperationType.PAYMENT:
        XdrPaymentResult.encode(stream, encodedOperationResultTr.paymentResult);
        break;
      case XdrOperationType.PATH_PAYMENT:
        XdrPathPaymentResult.encode(
            stream, encodedOperationResultTr.pathPaymentResult);
        break;
      case XdrOperationType.MANAGE_OFFER:
        XdrManageOfferResult.encode(
            stream, encodedOperationResultTr.manageOfferResult);
        break;
      case XdrOperationType.CREATE_PASSIVE_OFFER:
        XdrManageOfferResult.encode(
            stream, encodedOperationResultTr.createPassiveOfferResult);
        break;
      case XdrOperationType.SET_OPTIONS:
        XdrSetOptionsResult.encode(
            stream, encodedOperationResultTr.setOptionsResult);
        break;
      case XdrOperationType.CHANGE_TRUST:
        XdrChangeTrustResult.encode(
            stream, encodedOperationResultTr.changeTrustResult);
        break;
      case XdrOperationType.ALLOW_TRUST:
        XdrAllowTrustResult.encode(
            stream, encodedOperationResultTr.allowTrustResult);
        break;
      case XdrOperationType.ACCOUNT_MERGE:
        XdrAccountMergeResult.encode(
            stream, encodedOperationResultTr.accountMergeResult);
        break;
      case XdrOperationType.INFLATION:
        XdrInflationResult.encode(
            stream, encodedOperationResultTr.inflationResult);
        break;
      case XdrOperationType.MANAGE_DATA:
        XdrManageDataResult.encode(
            stream, encodedOperationResultTr.manageDataResult);
        break;
      case XdrOperationType.BUMP_SEQUENCE:
        XdrBumpSequenceResult.encode(
            stream, encodedOperationResultTr.bumpSeqResult);
        break;
    }
  }

  static XdrOperationResultTr decode(XdrDataInputStream stream) {
    XdrOperationResultTr decodedOperationResultTr = XdrOperationResultTr();
    XdrOperationType discriminant = XdrOperationType.decode(stream);
    decodedOperationResultTr.discriminant = discriminant;
    switch (decodedOperationResultTr.discriminant) {
      case XdrOperationType.CREATE_ACCOUNT:
        decodedOperationResultTr.createAccountResult =
            XdrCreateAccountResult.decode(stream);
        break;
      case XdrOperationType.PAYMENT:
        decodedOperationResultTr.paymentResult =
            XdrPaymentResult.decode(stream);
        break;
      case XdrOperationType.PATH_PAYMENT:
        decodedOperationResultTr.pathPaymentResult =
            XdrPathPaymentResult.decode(stream);
        break;
      case XdrOperationType.MANAGE_OFFER:
        decodedOperationResultTr.manageOfferResult =
            XdrManageOfferResult.decode(stream);
        break;
      case XdrOperationType.CREATE_PASSIVE_OFFER:
        decodedOperationResultTr.createPassiveOfferResult =
            XdrManageOfferResult.decode(stream);
        break;
      case XdrOperationType.SET_OPTIONS:
        decodedOperationResultTr.setOptionsResult =
            XdrSetOptionsResult.decode(stream);
        break;
      case XdrOperationType.CHANGE_TRUST:
        decodedOperationResultTr.changeTrustResult =
            XdrChangeTrustResult.decode(stream);
        break;
      case XdrOperationType.ALLOW_TRUST:
        decodedOperationResultTr.allowTrustResult =
            XdrAllowTrustResult.decode(stream);
        break;
      case XdrOperationType.ACCOUNT_MERGE:
        decodedOperationResultTr.accountMergeResult =
            XdrAccountMergeResult.decode(stream);
        break;
      case XdrOperationType.INFLATION:
        decodedOperationResultTr.inflationResult =
            XdrInflationResult.decode(stream);
        break;
      case XdrOperationType.MANAGE_DATA:
        decodedOperationResultTr.manageDataResult =
            XdrManageDataResult.decode(stream);
        break;
      case XdrOperationType.BUMP_SEQUENCE:
        decodedOperationResultTr.bumpSeqResult =
            XdrBumpSequenceResult.decode(stream);
        break;
    }
    return decodedOperationResultTr;
  }
}
