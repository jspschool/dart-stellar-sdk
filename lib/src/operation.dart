import 'package:fixnum/fixnum.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'assets.dart';
import 'key_pair.dart';
import 'util.dart';
import 'xdr/xdr_asset.dart';
import 'xdr/xdr_enum.dart';
import 'xdr/xdr_data.dart';
import 'xdr/xdr_operation.dart';
import 'xdr/xdr_other.dart';
import 'xdr/xdr_type.dart';

///Abstract class for operations.
abstract class Operation {
  Operation() {}

  KeyPair _sourceAccount;

  static final BigInt ONE = BigInt.from(10).pow(7);

  static int toXdrAmount(String value) {
    value = checkNotNull(value, "value cannot be null");

    List<String> two = value.split(".");
    BigInt amount = BigInt.parse(two[0]) * BigInt.from(10000000);

    if (two.length == 2) {
      int pos = 0;
      String point = two[1];
      for (int i = point.length - 1; i >= 0; i--) {
        if (point[i] == '0')
          pos++;
        else
          break;
      }
      point = point.substring(0, point.length - pos);
      int length = 7 - point.length;
      if (length < 0)
        throw Exception("The decimal point cannot exceed seven digits.");
      for (length; length > 0; length--) point += "0";
      amount += BigInt.parse(point);
    }

    return amount.toInt();
  }

  static String fromXdrAmount(int value) {
    String amoutString = value.toString();
    if (amoutString.length > 7) {
      amoutString = amoutString.substring(0, amoutString.length - 7) +
          "." +
          amoutString.substring(amoutString.length - 7, amoutString.length);
    } else {
      int length = 7 - amoutString.length;
      String point = "0.";
      for (length; length > 0; length--) point += "0";
      amoutString = point + amoutString;
    }
    return removeTailZero(amoutString);
  }

  ///Generates Operation XDR object.
  XdrOperation toXdr() {
    XdrOperation xdrOp = XdrOperation();
    if (sourceAccount != null) {
      XdrAccountID xdrAccountID = XdrAccountID();
      xdrAccountID.accountID = sourceAccount.xdrPublicKey;
      xdrOp.sourceAccount = xdrAccountID;
    }
    xdrOp.body = toOperationBody();
    return xdrOp;
  }

  ///Returns base64-encoded Operation XDR object.
  String toXdrBase64() {
    try {
      XdrOperation operation = this.toXdr();
      var xdrOutputStream = XdrDataOutputStream();
      XdrOperation.encode(xdrOutputStream, operation);
      return base64Encode(xdrOutputStream.data);
    } catch (e) {
      throw AssertionError(e);
    }
  }

  ///Returns Operation object from Operation XDR object.
  static Operation fromXdr(XdrOperation xdrOp) {
    XdrOperationBody body = xdrOp.body;
    Operation operation;
    switch (body.discriminant) {
      case XdrOperationType.CREATE_ACCOUNT:
        operation =
            CreateAccountOperation.Builder(body.createAccountOp).build();
        break;
      case XdrOperationType.PAYMENT:
        operation = PaymentOperation.Builder(body.paymentOp).build();
        break;
      case XdrOperationType.PATH_PAYMENT:
        operation = PathPaymentOperation.Builder(body.pathPaymentOp).build();
        break;
      case XdrOperationType.MANAGE_OFFER:
        operation = ManageOfferOperation.Builder(body.manageOfferOp).build();
        break;
      case XdrOperationType.CREATE_PASSIVE_OFFER:
        operation =
            CreatePassiveOfferOperation.Builder(body.createPassiveOfferOp)
                .build();
        break;
      case XdrOperationType.SET_OPTIONS:
        operation = SetOptionsOperation.Builder(body.setOptionsOp).build();
        break;
      case XdrOperationType.CHANGE_TRUST:
        operation = ChangeTrustOperation.Builder(body.changeTrustOp).build();
        break;
      case XdrOperationType.ALLOW_TRUST:
        operation = AllowTrustOperation.Builder(body.allowTrustOp).build();
        break;
      case XdrOperationType.ACCOUNT_MERGE:
        operation = AccountMergeOperation.Builder(body).build();
        break;
      case XdrOperationType.MANAGE_DATA:
        operation = ManageDataOperation.Builder(body.manageDataOp).build();
        break;
      case XdrOperationType.BUMP_SEQUENCE:
        operation = BumpSequenceOperation.Builder(body.bumpSequenceOp).build();
        break;
      default:
        throw Exception("Unknown operation body ${body.discriminant}");
    }
    if (xdrOp.sourceAccount != null) {
      operation.sourceAccount =
          KeyPair.fromXdrPublicKey(xdrOp.sourceAccount.accountID);
    }
    return operation;
  }

  ///Returns operation source account.
  KeyPair get sourceAccount => _sourceAccount;

  ///Sets operation source account.
  set sourceAccount(KeyPair keypair) {
    _sourceAccount = checkNotNull(keypair, "keypair cannot be null");
  }

  ///Generates OperationBody XDR object
  XdrOperationBody toOperationBody();
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#create-account" target="_blank">CreateAccount</a> operation.
class CreateAccountOperation extends Operation {
  KeyPair _destination;
  String _startingBalance;

  CreateAccountOperation(KeyPair destination, String startingBalance) {
    this._destination = checkNotNull(destination, "destination cannot be null");
    this._startingBalance =
        checkNotNull(startingBalance, "startingBalance cannot be null");
  }

  ///Amount of XLM to send to the newly created account.
  String get startingBalance => _startingBalance;

  ///Account that is created and funded
  KeyPair get destination => _destination;

  @override
  XdrOperationBody toOperationBody() {
    XdrCreateAccountOp op = XdrCreateAccountOp();
    XdrAccountID destination = XdrAccountID();
    destination.accountID = this.destination.xdrPublicKey;
    op.destination = destination;
    XdrInt64 startingBalance = XdrInt64();
    startingBalance.int64 = Operation.toXdrAmount(this.startingBalance);
    op.startingBalance = startingBalance;

    XdrOperationBody body = XdrOperationBody();
    body.discriminant = XdrOperationType.CREATE_ACCOUNT;
    body.createAccountOp = op;
    return body;
  }

  ///Builds CreateAccount operation.
  static CreateAccountOperationBuilder Builder(XdrCreateAccountOp op) {
    return CreateAccountOperationBuilder(
        KeyPair.fromXdrPublicKey(op.destination.accountID),
        Operation.fromXdrAmount(op.startingBalance.int64.toInt()));
  }
}

class CreateAccountOperationBuilder {
  KeyPair _destination;
  String _startingBalance;

  KeyPair _mSourceAccount;

  ///Creates a CreateAccount builder.
  CreateAccountOperationBuilder(KeyPair destination, String startingBalance) {
    this._destination = destination;
    this._startingBalance = startingBalance;
  }

  ///Sets the source account for this operation.
  CreateAccountOperationBuilder setSourceAccount(KeyPair account) {
    _mSourceAccount = account;
    return this;
  }

  ///Builds an operation
  CreateAccountOperation build() {
    CreateAccountOperation operation =
        CreateAccountOperation(_destination, _startingBalance);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#payment" target="_blank">Payment</a> operation.
class PaymentOperation extends Operation {
  KeyPair _destination;
  Asset _asset;
  String _amount;

  PaymentOperation(KeyPair destination, Asset asset, String amount) {
    this._destination = checkNotNull(destination, "destination cannot be null");
    this._asset = checkNotNull(asset, "asset cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
  }

  ///Account that receives the payment.
  KeyPair get destination => _destination;

  ///Asset to send to the destination account.
  Asset get asset => _asset;

  ///Amount of the asset to send.
  String get amount => _amount;

  @override
  XdrOperationBody toOperationBody() {
    XdrPaymentOp op = XdrPaymentOp();

    // destination
    XdrAccountID destination = XdrAccountID();
    destination.accountID = this._destination.xdrPublicKey;
    op.destination = destination;
    // asset
    op.asset = asset.toXdr();
    // amount
    XdrInt64 amount = XdrInt64();
    amount.int64 = Operation.toXdrAmount(this.amount);
    op.amount = amount;

    XdrOperationBody body = XdrOperationBody();
    body.discriminant = XdrOperationType.PAYMENT;
    body.paymentOp = op;
    return body;
  }

  ///Builds Payment operation.
  static PaymentOperationBuilder Builder(XdrPaymentOp op) {
    return PaymentOperationBuilder(
        KeyPair.fromXdrPublicKey(op.destination.accountID),
        Asset.fromXdr(op.asset),
        Operation.fromXdrAmount(op.amount.int64));
  }
}

class PaymentOperationBuilder {
  KeyPair _destination;
  Asset _asset;
  String _amount;

  KeyPair _mSourceAccount;

  ///Creates a PaymentOperation builder.
  PaymentOperationBuilder(KeyPair destination, Asset asset, String amount) {
    this._destination = destination;
    this._asset = asset;
    this._amount = amount;
  }

  ///Sets the source account for this operation.
  PaymentOperationBuilder setSourceAccount(KeyPair account) {
    _mSourceAccount = account;
    return this;
  }

  ///Builds an operation
  PaymentOperation build() {
    PaymentOperation operation =
        PaymentOperation(_destination, _asset, _amount);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#path-payment" target="_blank">PathPayment</a> operation.
class PathPaymentOperation extends Operation {
  Asset _sendAsset;
  String _sendMax;
  KeyPair _destination;
  Asset _destAsset;
  String _destAmount;
  List<Asset> _path;

  PathPaymentOperation(Asset sendAsset, String sendMax, KeyPair destination,
      Asset destAsset, String destAmount, List<Asset> path) {
    this._sendAsset = checkNotNull(sendAsset, "sendAsset cannot be null");
    this._sendMax = checkNotNull(sendMax, "sendMax cannot be null");
    this._destination = checkNotNull(destination, "destination cannot be null");
    this._destAsset = checkNotNull(destAsset, "destAsset cannot be null");
    this._destAmount = checkNotNull(destAmount, "destAmount cannot be null");
    if (path == null) {
      this._path = List<Asset>(0);
    } else {
      checkArgument(
          path.length <= 5, "The maximum number of assets in the path is 5");
      this._path = path;
    }
  }

  ///The asset deducted from the sender's account.
  Asset get sendAsset => _sendAsset;

  ///The maximum amount of send asset to deduct (excluding fees)
  String get sendMax => _sendMax;

  ///Account that receives the payment.
  KeyPair get destination => _destination;

  ///The asset the destination account receives.
  Asset get destAsset => _destAsset;

  ///The amount of destination asset the destination account receives.
  String get destAmount => _destAmount;

  ///The assets (other than send asset and destination asset) involved in the offers the path takes. For example, if you can only find a path from USD to EUR through XLM and BTC, the path would be USD -&raquo; XLM -&raquo; BTC -&raquo; EUR and the path would contain XLM and BTC.
  List<Asset> get path => _path;

  @override
  XdrOperationBody toOperationBody() {
    XdrPathPaymentOp op = XdrPathPaymentOp();

    // sendAsset
    op.sendAsset = sendAsset.toXdr();
    // sendMax
    XdrInt64 sendMax = XdrInt64();
    sendMax.int64 = Operation.toXdrAmount(this.sendMax);
    op.sendMax = sendMax;
    // destination
    XdrAccountID destination = XdrAccountID();
    destination.accountID = this.destination.xdrPublicKey;
    op.destination = destination;
    // destAsset
    op.destAsset = destAsset.toXdr();
    // destAmount
    XdrInt64 destAmount = XdrInt64();
    destAmount.int64 = Operation.toXdrAmount(this.destAmount);
    op.destAmount = destAmount;
    // path
    List<XdrAsset> path = List<XdrAsset>(this.path.length);
    for (int i = 0; i < this.path.length; i++) {
      path[i] = this.path[i].toXdr();
    }
    op.path = path;

    XdrOperationBody body = XdrOperationBody();
    body.discriminant = XdrOperationType.PATH_PAYMENT;
    body.pathPaymentOp = op;
    return body;
  }

  ///Builds PathPayment operation.
  static PathPaymentOperationBuilder Builder(XdrPathPaymentOp op) {
    List<Asset> path = List<Asset>(op.path.length);
    for (int i = 0; i < op.path.length; i++) {
      path[i] = Asset.fromXdr(op.path[i]);
    }
    return PathPaymentOperationBuilder(
            Asset.fromXdr(op.sendAsset),
            Operation.fromXdrAmount(op.sendMax.int64),
            KeyPair.fromXdrPublicKey(op.destination.accountID),
            Asset.fromXdr(op.destAsset),
            Operation.fromXdrAmount(op.destAmount.int64))
        .setPath(path);
  }
}

class PathPaymentOperationBuilder {
  Asset _sendAsset;
  String _sendMax;
  KeyPair _destination;
  Asset _destAsset;
  String _destAmount;
  List<Asset> _path;

  KeyPair _mSourceAccount;

  ///Creates a PathPaymentOperation builder.
  PathPaymentOperationBuilder(Asset sendAsset, String sendMax,
      KeyPair destination, Asset destAsset, String destAmount) {
    this._sendAsset = checkNotNull(sendAsset, "sendAsset cannot be null");
    this._sendMax = checkNotNull(sendMax, "sendMax cannot be null");
    this._destination = checkNotNull(destination, "destination cannot be null");
    this._destAsset = checkNotNull(destAsset, "destAsset cannot be null");
    this._destAmount = checkNotNull(destAmount, "destAmount cannot be null");
  }

  ///Sets path for this operation
  PathPaymentOperationBuilder setPath(List<Asset> path) {
    checkNotNull(path, "path cannot be null");
    checkArgument(
        path.length <= 5, "The maximum number of assets in the path is 5");
    this._path = path;
    return this;
  }

  ///Sets the source account for this operation.
  PathPaymentOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  ///Builds an operation
  PathPaymentOperation build() {
    PathPaymentOperation operation = PathPaymentOperation(
        _sendAsset, _sendMax, _destination, _destAsset, _destAmount, _path);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#manage-offer" target="_blank">ManageOffer</a> operation.
class ManageOfferOperation extends Operation {
  Asset _selling;
  Asset _buying;
  String _amount;
  String _price;
  int _offerId;

  ManageOfferOperation(
      Asset selling, Asset buying, String amount, String price, int offerId) {
    this._selling = checkNotNull(selling, "selling cannot be null");
    this._buying = checkNotNull(buying, "buying cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
    this._price = checkNotNull(price, "price cannot be null");
    // offerId can be null
    this._offerId = offerId;
  }

  ///The asset being sold in this operation
  Asset get selling => _selling;

  ///The asset being bought in this operation
  Asset get buying => _buying;

  ///Amount of selling being sold.
  String get amount => _amount;

  ///Price of 1 unit of selling in terms of buying.
  String get price => _price;

  ///The ID of the offer.
  int get offerId => _offerId;

  @override
  XdrOperationBody toOperationBody() {
    XdrManageOfferOp op = new XdrManageOfferOp();
    op.selling = selling.toXdr();
    op.buying = buying.toXdr();
    XdrInt64 amount = new XdrInt64();
    amount.int64 = Operation.toXdrAmount(this.amount);
    op.amount = amount;
    Price price = Price.fromString(this.price);
    op.price = price.toXdr();
    XdrUint64 offerId = new XdrUint64();
    offerId.uint64 = this.offerId;
    op.offerID = offerId;

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.MANAGE_OFFER;
    body.manageOfferOp = op;

    return body;
  }

  ///Construct a new CreateAccount builder from a CreateAccountOp XDR.
  static ManageOfferOperationBuilder Builder(XdrManageOfferOp op) {
    int n = op.price.n.int32.toInt();
    int d = op.price.d.int32.toInt();

    return ManageOfferOperationBuilder(
      Asset.fromXdr(op.selling),
      Asset.fromXdr(op.buying),
      Operation.fromXdrAmount(op.amount.int64.toInt()),
      removeTailZero((BigInt.from(n) / BigInt.from(d)).toString()),
    ).setOfferId(op.offerID.uint64.toInt());
  }
}

class ManageOfferOperationBuilder {
  Asset _selling;
  Asset _buying;
  String _amount;
  String _price;
  int _offerId = 0;

  KeyPair _mSourceAccount;

  ///Creates a new ManageOffer builder. If you want to update existing offer use
  ManageOfferOperationBuilder(
      Asset selling, Asset buying, String amount, String price) {
    this._selling = checkNotNull(selling, "selling cannot be null");
    this._buying = checkNotNull(buying, "buying cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
    this._price = checkNotNull(price, "price cannot be null");
  }

  ///Sets offer ID. <code>0</code> creates a new offer. Set to existing offer ID to change it.
  ManageOfferOperationBuilder setOfferId(int offerId) {
    this._offerId = offerId;
    return this;
  }

  ///Sets the source account for this operation.
  ManageOfferOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  ///Builds an operation
  ManageOfferOperation build() {
    ManageOfferOperation operation =
        new ManageOfferOperation(_selling, _buying, _amount, _price, _offerId);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#create-passive-offer" target="_blank">CreatePassiveOffer</a> operation.
class CreatePassiveOfferOperation extends Operation {
  Asset _selling;
  Asset _buying;
  String _amount;
  String _price;

  CreatePassiveOfferOperation(
      Asset selling, Asset buying, String amount, String price) {
    this._selling = checkNotNull(selling, "selling cannot be null");
    this._buying = checkNotNull(buying, "buying cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
    this._price = checkNotNull(price, "price cannot be null");
  }

  ///The asset being sold in this operation
  Asset get selling => _selling;

  ///The asset being bought in this operation
  Asset get buying => _buying;

  ///Amount of selling being sold.
  String get amount => _amount;

  ///Price of 1 unit of selling in terms of buying.
  String get price => _price;

  @override
  XdrOperationBody toOperationBody() {
    XdrCreatePassiveOfferOp op = new XdrCreatePassiveOfferOp();
    op.selling = selling.toXdr();
    op.buying = buying.toXdr();
    XdrInt64 amount = new XdrInt64();
    amount.int64 = Operation.toXdrAmount(this.amount);
    op.amount = amount;
    Price price = Price.fromString(this.price);
    op.price = price.toXdr();

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.CREATE_PASSIVE_OFFER;
    body.createPassiveOfferOp = op;

    return body;
  }

  ///Construct a new CreatePassiveOffer builder from a CreatePassiveOfferOp XDR.
  static CreatePassiveOfferOperationBuilder Builder(
      XdrCreatePassiveOfferOp op) {
    int n = op.price.n.int32;
    int d = op.price.d.int32;

    return CreatePassiveOfferOperationBuilder(
        Asset.fromXdr(op.selling),
        Asset.fromXdr(op.buying),
        Operation.fromXdrAmount(op.amount.int64),
        removeTailZero((BigInt.from(n) / BigInt.from(d)).toString()));
  }
}

class CreatePassiveOfferOperationBuilder {
  Asset _selling;
  Asset _buying;
  String _amount;
  String _price;

  KeyPair _mSourceAccount;

  ///Creates a new CreatePassiveOffer builder.
  CreatePassiveOfferOperationBuilder(
      Asset selling, Asset buying, String amount, String price) {
    this._selling = checkNotNull(selling, "selling cannot be null");
    this._buying = checkNotNull(buying, "buying cannot be null");
    this._amount = checkNotNull(amount, "amount cannot be null");
    this._price = checkNotNull(price, "price cannot be null");
  }

  ///Sets the source account for this operation.
  CreatePassiveOfferOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  ///Builds an operation
  CreatePassiveOfferOperation build() {
    CreatePassiveOfferOperation operation =
        new CreatePassiveOfferOperation(_selling, _buying, _amount, _price);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#set-options">SetOptions</a> operation.
class SetOptionsOperation extends Operation {
  KeyPair _inflationDestination;
  int _clearFlags;
  int _setFlags;
  int _masterKeyWeight;
  int _lowThreshold;
  int _mediumThreshold;
  int _highThreshold;
  String _homeDomain;
  XdrSignerKey _signer;
  int _signerWeight;

  SetOptionsOperation(
      KeyPair inflationDestination,
      int clearFlags,
      int setFlags,
      int masterKeyWeight,
      int lowThreshold,
      int mediumThreshold,
      int highThreshold,
      String homeDomain,
      XdrSignerKey signer,
      int signerWeight) {
    this._inflationDestination = inflationDestination;
    this._clearFlags = clearFlags;
    this._setFlags = setFlags;
    this._masterKeyWeight = masterKeyWeight;
    this._lowThreshold = lowThreshold;
    this._mediumThreshold = mediumThreshold;
    this._highThreshold = highThreshold;
    this._homeDomain = homeDomain;
    this._signer = signer;
    this._signerWeight = signerWeight;
  }

  ///Account of the inflation destination.
  KeyPair get inflationDestination => _inflationDestination;

  ///Indicates which flags to clear. For details about the flags, please refer to the <a href="https://www.stellar.org/developers/learn/concepts/accounts.html" target="_blank">accounts doc</a>.
  int get clearFlags => _clearFlags;

  ///Indicates which flags to set. For details about the flags, please refer to the <a href="https://www.stellar.org/developers/learn/concepts/accounts.html" target="_blank">accounts doc</a>.
  int get setFlags => _setFlags;

  ///Weight of the master key.
  int get masterKeyWeight => _masterKeyWeight;

  ///A number from 0-255 representing the threshold this account sets on all operations it performs that have <a href="https://www.stellar.org/developers/learn/concepts/multi-sig.html" target="_blank">a low threshold</a>.
  int get lowThreshold => _lowThreshold;

  ///A number from 0-255 representing the threshold this account sets on all operations it performs that have <a href="https://www.stellar.org/developers/learn/concepts/multi-sig.html" target="_blank">a medium threshold</a>.
  int get mediumThreshold => _mediumThreshold;

  ///A number from 0-255 representing the threshold this account sets on all operations it performs that have <a href="https://www.stellar.org/developers/learn/concepts/multi-sig.html" target="_blank">a high threshold</a>.
  int get highThreshold => _highThreshold;

  ///The home domain of an account.
  String get homeDomain => _homeDomain;

  ///Additional signer added/removed in this operation.
  XdrSignerKey get signer => _signer;

  ///Additional signer weight. The signer is deleted if the weight is 0.
  int get signerWeight => _signerWeight;

  @override
  XdrOperationBody toOperationBody() {
    XdrSetOptionsOp op = new XdrSetOptionsOp();
    if (inflationDestination != null) {
      XdrAccountID inflationDestination = new XdrAccountID();
      inflationDestination.accountID = this.inflationDestination.xdrPublicKey;
      op.inflationDest = inflationDestination;
    }
    if (clearFlags != null) {
      XdrUint32 clearFlags = new XdrUint32();
      clearFlags.uint32 = this.clearFlags;
      op.clearFlags = clearFlags;
    }
    if (setFlags != null) {
      XdrUint32 setFlags = new XdrUint32();
      setFlags.uint32 = this.setFlags;
      op.setFlags = setFlags;
    }
    if (masterKeyWeight != null) {
      XdrUint32 uint32 = new XdrUint32();
      uint32.uint32 = masterKeyWeight;
      op.masterWeight = uint32;
    }
    if (lowThreshold != null) {
      XdrUint32 uint32 = new XdrUint32();
      uint32.uint32 = lowThreshold;
      op.lowThreshold = uint32;
    }
    if (mediumThreshold != null) {
      XdrUint32 uint32 = new XdrUint32();
      uint32.uint32 = mediumThreshold;
      op.medThreshold = uint32;
    }
    if (highThreshold != null) {
      XdrUint32 uint32 = new XdrUint32();
      uint32.uint32 = highThreshold;
      op.highThreshold = uint32;
    }
    if (homeDomain != null) {
      XdrString32 homeDomain = new XdrString32();
      homeDomain.string32 = this.homeDomain;
      op.homeDomain = homeDomain;
    }
    if (signer != null) {
      XdrSigner signer = new XdrSigner();
      XdrUint32 weight = new XdrUint32();
      weight.uint32 = signerWeight & 0xFF;
      signer.key = this.signer;
      signer.weight = weight;
      op.signer = signer;
    }

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.SET_OPTIONS;
    body.setOptionsOp = op;
    return body;
  }

  ///Builds SetOptions operation.
  static SetOptionsOperationBuilder Builder(XdrSetOptionsOp op) {
    SetOptionsOperationBuilder builder = SetOptionsOperationBuilder();

    if (op.inflationDest != null) {
      builder = builder.setInflationDestination(
          KeyPair.fromXdrPublicKey(op.inflationDest.accountID));
    }
    if (op.clearFlags != null) {
      builder = builder.setClearFlags(op.clearFlags.uint32);
    }
    if (op.setFlags != null) {
      builder = builder.setSetFlags(op.setFlags.uint32);
    }
    if (op.masterWeight != null) {
      builder = builder.setMasterKeyWeight(op.masterWeight.uint32);
    }
    if (op.lowThreshold != null) {
      builder = builder.setLowThreshold(op.lowThreshold.uint32);
    }
    if (op.medThreshold != null) {
      builder = builder.setMediumThreshold(op.medThreshold.uint32);
    }
    if (op.highThreshold != null) {
      builder = builder.setHighThreshold(op.highThreshold.uint32);
    }
    if (op.homeDomain != null) {
      builder = builder.setHomeDomain(op.homeDomain.string32);
    }
    if (op.signer != null) {
      builder =
          builder.setSigner(op.signer.key, op.signer.weight.uint32 & 0xFF);
    }

    return builder;
  }
}

class SetOptionsOperationBuilder {
  KeyPair _inflationDestination;
  int _clearFlags;
  int _setFlags;
  int _masterKeyWeight;
  int _lowThreshold;
  int _mediumThreshold;
  int _highThreshold;
  String _homeDomain;
  XdrSignerKey _signer;
  int _signerWeight;
  KeyPair _sourceAccount;

  SetOptionsOperationBuilder();

  ///Sets the inflation destination for the account.
  SetOptionsOperationBuilder setInflationDestination(
      KeyPair inflationDestination) {
    this._inflationDestination = inflationDestination;
    return this;
  }

  ///Clears the given flags from the account.
  SetOptionsOperationBuilder setClearFlags(int clearFlags) {
    this._clearFlags = clearFlags;
    return this;
  }

  ///Sets the given flags on the account.
  SetOptionsOperationBuilder setSetFlags(int setFlags) {
    this._setFlags = setFlags;
    return this;
  }

  ///Weight of the master key.
  SetOptionsOperationBuilder setMasterKeyWeight(int masterKeyWeight) {
    this._masterKeyWeight = masterKeyWeight;
    return this;
  }

  ///A number from 0-255 representing the threshold this account sets on all operations it performs that have a low threshold.
  SetOptionsOperationBuilder setLowThreshold(int lowThreshold) {
    this._lowThreshold = lowThreshold;
    return this;
  }

  ///A number from 0-255 representing the threshold this account sets on all operations it performs that have a medium threshold.
  SetOptionsOperationBuilder setMediumThreshold(int mediumThreshold) {
    this._mediumThreshold = mediumThreshold;
    return this;
  }

  ///A number from 0-255 representing the threshold this account sets on all operations it performs that have a high threshold.
  SetOptionsOperationBuilder setHighThreshold(int highThreshold) {
    this._highThreshold = highThreshold;
    return this;
  }

  ///Sets the account's home domain address used in <a href="https://www.stellar.org/developers/learn/concepts/federation.html" target="_blank">Federation</a>.
  SetOptionsOperationBuilder setHomeDomain(String homeDomain) {
    if (homeDomain.length > 32) {
      throw new Exception("Home domain must be <= 32 characters");
    }
    this._homeDomain = homeDomain;
    return this;
  }

  ///Add, update, or remove a signer from the account. Signer is deleted if the weight = 0;
  SetOptionsOperationBuilder setSigner(XdrSignerKey signer, int weight) {
    checkNotNull(signer, "signer cannot be null");
    checkNotNull(weight, "weight cannot be null");
    this._signer = signer;
    _signerWeight = weight & 0xFF;
    return this;
  }

  ///Sets the source account for this operation.
  SetOptionsOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    this._sourceAccount = sourceAccount;
    return this;
  }

  ///Builds an operation
  SetOptionsOperation build() {
    SetOptionsOperation operation = new SetOptionsOperation(
        _inflationDestination,
        _clearFlags,
        _setFlags,
        _masterKeyWeight,
        _lowThreshold,
        _mediumThreshold,
        _highThreshold,
        _homeDomain,
        _signer,
        _signerWeight);
    if (_sourceAccount != null) {
      operation.sourceAccount = _sourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#change-trust" target="_blank">ChangeTrust</a> operation.
class ChangeTrustOperation extends Operation {
  Asset _asset;
  String _limit;

  ChangeTrustOperation(Asset asset, String limit) {
    this._asset = checkNotNull(asset, "asset cannot be null");
    this._limit = checkNotNull(limit, "limit cannot be null");
  }

  ///The asset of the trustline. For example, if a gateway extends a trustline of up to 200 USD to a user, the line is USD.
  Asset get asset => _asset;

  ///The limit of the trustline. For example, if a gateway extends a trustline of up to 200 USD to a user, the limit is 200.
  String get limit => _limit;

  @override
  XdrOperationBody toOperationBody() {
    XdrChangeTrustOp op = new XdrChangeTrustOp();
    op.line = asset.toXdr();
    XdrInt64 limit = new XdrInt64();
    limit.int64 = Operation.toXdrAmount(this.limit);
    op.limit = limit;

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.CHANGE_TRUST;
    body.changeTrustOp = op;
    return body;
  }

  ///Builds ChangeTrust operation.
  static ChangeTrustOperationBuilder Builder(XdrChangeTrustOp op) {
    return ChangeTrustOperationBuilder(
        Asset.fromXdr(op.line), Operation.fromXdrAmount(op.limit.int64));
  }
}

class ChangeTrustOperationBuilder {
  Asset _asset;
  String _limit;
  KeyPair _mSourceAccount;

  ///Creates a new ChangeTrust builder.
  ChangeTrustOperationBuilder(Asset asset, String limit) {
    this._asset = checkNotNull(asset, "asset cannot be null");
    this._limit = checkNotNull(limit, "limit cannot be null");
  }

  ///Set source account of this operation
  ChangeTrustOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  ///Builds an operation
  ChangeTrustOperation build() {
    ChangeTrustOperation operation = new ChangeTrustOperation(_asset, _limit);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#allow-trust" target="_blank">AllowTrust</a> operation.
class AllowTrustOperation extends Operation {
  KeyPair _trustor;
  String _assetCode;
  bool _authorize;

  AllowTrustOperation(KeyPair trustor, String assetCode, bool authorize) {
    this._trustor = checkNotNull(trustor, "trustor cannot be null");
    this._assetCode = checkNotNull(assetCode, "assetCode cannot be null");
    this._authorize = authorize;
  }

  ///The account of the recipient of the trustline.
  KeyPair get trustor => _trustor;

  ///The asset of the trustline the source account is authorizing. For example, if a gateway wants to allow another account to hold its USD credit, the type is USD.
  String get assetCode => _assetCode;

  ///Flag indicating whether the trustline is authorized.
  bool get authorize => _authorize;

  @override
  XdrOperationBody toOperationBody() {
    XdrAllowTrustOp op = new XdrAllowTrustOp();

    // trustor
    XdrAccountID trustor = new XdrAccountID();
    trustor.accountID = this._trustor.xdrPublicKey;
    op.trustor = trustor;
    // asset
    XdrAllowTrustOpAsset asset = new XdrAllowTrustOpAsset();
    if (_assetCode.length <= 4) {
      asset.discriminant = XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM4;
      asset.assetCode4 = Util.paddedByteArray(utf8.encode(_assetCode), 4);
    } else {
      asset.discriminant = XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM12;
      asset.assetCode12 = Util.paddedByteArray(utf8.encode(_assetCode), 12);
    }
    op.asset = asset;
    // authorize
    op.authorize = authorize;

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.ALLOW_TRUST;
    body.allowTrustOp = op;
    return body;
  }

  ///Builds AllowTrust operation.
  static AllowTrustOperationBuilder Builder(XdrAllowTrustOp op) {
    String assetCode;
    switch (op.asset.discriminant) {
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM4:
        assetCode = Util.paddedByteArrayToString(op.asset.assetCode4);
        break;
      case XdrAssetType.ASSET_TYPE_CREDIT_ALPHANUM12:
        assetCode = Util.paddedByteArrayToString(op.asset.assetCode12);
        break;
      default:
        throw new Exception("Unknown asset code");
    }

    return AllowTrustOperationBuilder(
        KeyPair.fromXdrPublicKey(op.trustor.accountID),
        assetCode,
        op.authorize);
  }
}

class AllowTrustOperationBuilder {
  KeyPair _trustor;
  String _assetCode;
  bool _authorize;

  KeyPair _mSourceAccount;

  ///Creates a new AllowTrust builder.
  AllowTrustOperationBuilder(
      KeyPair trustor, String assetCode, bool authorize) {
    this._trustor = trustor;
    this._assetCode = assetCode;
    this._authorize = authorize;
  }

  ///Set source account of this operation
  AllowTrustOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount = sourceAccount;
    return this;
  }

  ///Builds an operation
  AllowTrustOperation build() {
    AllowTrustOperation operation =
        new AllowTrustOperation(_trustor, _assetCode, _authorize);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#account-merge" target="_blank">AccountMerge</a> operation.
class AccountMergeOperation extends Operation {
  KeyPair _destination;

  AccountMergeOperation(KeyPair destination) {
    this._destination = checkNotNull(destination, "destination cannot be null");
  }

  ///The account that receives the remaining XLM balance of the source account.
  KeyPair get destination => _destination;

  @override
  XdrOperationBody toOperationBody() {
    XdrOperationBody body = new XdrOperationBody();
    XdrAccountID destination = new XdrAccountID();
    destination.accountID = this.destination.xdrPublicKey;
    body.destination = destination;
    body.discriminant = XdrOperationType.ACCOUNT_MERGE;
    return body;
  }

  ///Builds AccountMerge operation.
  static AccountMergeOperationBuilder Builder(XdrOperationBody op) {
    return AccountMergeOperationBuilder(
        KeyPair.fromXdrPublicKey(op.destination.accountID));
  }
}

class AccountMergeOperationBuilder {
  KeyPair _destination;
  KeyPair _mSourceAccount;

  ///Creates a new AccountMerge builder.
  AccountMergeOperationBuilder(KeyPair destination) {
    this._destination = destination;
  }

  ///Set source account of this operation
  AccountMergeOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount = sourceAccount;
    return this;
  }

  ///Builds an operation
  AccountMergeOperation build() {
    AccountMergeOperation operation = new AccountMergeOperation(_destination);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html#manage-data" target="_blank">ManageData</a> operation.
class ManageDataOperation extends Operation {
  String _name;
  Uint8List _value;

  ManageDataOperation(String name, Uint8List value) {
    this._name = checkNotNull(name, "name cannot be null");
    this._value = value;
  }

  ///The name of the data value
  String get name => _name;

  ///Data value
  Uint8List get value => _value;

  @override
  XdrOperationBody toOperationBody() {
    XdrManageDataOp op = new XdrManageDataOp();
    XdrString64 name = new XdrString64();
    name.string64 = this.name;
    op.dataName = name;

    if (value != null) {
      XdrDataValue dataValue = new XdrDataValue();
      dataValue.dataValue = this.value;
      op.dataValue = dataValue;
    }

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.MANAGE_DATA;
    body.manageDataOp = op;

    return body;
  }

  ///Construct a new ManageOffer builder from a ManageDataOp XDR.
  static ManageDataOperationBuilder Builder(XdrManageDataOp op) {
    Uint8List value = null;
    if (op.dataValue != null) {
      value = op.dataValue.dataValue;
    }

    return ManageDataOperationBuilder(op.dataName.string64, value);
  }
}

class ManageDataOperationBuilder {
  String _name;
  Uint8List _value;

  KeyPair _mSourceAccount;

  ///Creates a new ManageData builder. If you want to delete data entry pass null as a <code>value</code> param.
  ManageDataOperationBuilder(String name, Uint8List value) {
    this._name = checkNotNull(name, "name cannot be null");
    this._value = value;
  }

  ///Sets the source account for this operation.
  ManageDataOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  ///Builds an operation
  ManageDataOperation build() {
    ManageDataOperation operation = new ManageDataOperation(_name, _value);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents <a href="https://www.stellar.org/developers/guides/concepts/list-of-operations.html#bump-sequence" target="_blank">Bump Sequence</a> operation.
class BumpSequenceOperation extends Operation {
  int _bumpTo;

  BumpSequenceOperation(int bumpTo) {
    this._bumpTo = bumpTo;
  }

  int get bumpTo => _bumpTo;

  @override
  XdrOperationBody toOperationBody() {
    XdrBumpSequenceOp op = new XdrBumpSequenceOp();
    XdrInt64 bumpTo = new XdrInt64();
    bumpTo.int64 = this._bumpTo;
    XdrSequenceNumber sequenceNumber = new XdrSequenceNumber();
    sequenceNumber.sequenceNumber = bumpTo;
    op.bumpTo = sequenceNumber;

    XdrOperationBody body = new XdrOperationBody();
    body.discriminant = XdrOperationType.BUMP_SEQUENCE;
    body.bumpSequenceOp = op;

    return body;
  }

  ///Construct a new BumpSequence builder from a BumpSequence XDR.
  static BumpSequenceOperationBuilder Builder(XdrBumpSequenceOp op) {
    return BumpSequenceOperationBuilder(op.bumpTo.sequenceNumber.int64);
  }
}

class BumpSequenceOperationBuilder {
  int _bumpTo;

  KeyPair _mSourceAccount;

  ///Creates a new BumpSequence builder.
  BumpSequenceOperationBuilder(int bumpTo) {
    this._bumpTo = bumpTo;
  }

  ///Sets the source account for this operation.
  BumpSequenceOperationBuilder setSourceAccount(KeyPair sourceAccount) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    return this;
  }

  ///Builds an operation
  BumpSequenceOperation build() {
    BumpSequenceOperation operation = new BumpSequenceOperation(_bumpTo);
    if (_mSourceAccount != null) {
      operation.sourceAccount = _mSourceAccount;
    }
    return operation;
  }
}

///Represents Price. Price in Stellar is represented as a fraction.
class Price {
  int n;
  int d;

  ///Create a new price. Price in Stellar is represented as a fraction.
  Price(this.n, this.d);

  factory Price.fromJson(Map<String, dynamic> json) {
    return new Price(json['n'] as int, json['d'] as int);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'n': n, 'd': d};

  ///Returns numerator.
  int get numerator {
    return n;
  }

  ///Returns denominator
  int get denominator {
    return d;
  }

  ///Approximates <code>price</code> to a fraction.
  ///Please remember that this function can give unexpected results for values that cannot be represented as a
  ///fraction with 32-bit numerator and denominator. It's safer to create a Price object using the constructor.
  static Price fromString(String price) {
    checkNotNull(price, "price cannot be null");

    List<String> two = price.split(".");
    BigInt number = BigInt.parse(two[0]);
    double f = 0.0;
    if (two.length == 2) {
      f = double.parse("0.${two[1]}");
    }
    BigInt maxInt = BigInt.from(Int32.MAX_VALUE.toInt());
    BigInt a;
    List<List<BigInt>> fractions = List<List<BigInt>>();
    fractions.add([BigInt.zero, BigInt.one]);
    fractions.add([BigInt.one, BigInt.zero]);
    int i = 2;
    while (true) {
      if (number > maxInt) {
        break;
      }
      a = number;
      BigInt h = a * (fractions[i - 1][0]) + (fractions[i - 2][0]);
      BigInt k = a * (fractions[i - 1][1]) + (fractions[i - 2][1]);
      if (h > maxInt || k > maxInt) {
        break;
      }
      fractions.add([h, k]);
      if (f == 0.0) {
        break;
      }
      double point = 1 / f;
      number = BigInt.from(point);
      f = point - number.toDouble();
      i = i + 1;
    }
    BigInt n = fractions[fractions.length - 1][0];
    BigInt d = fractions[fractions.length - 1][1];
    return new Price(n.toInt(), d.toInt());
  }

  ///Generates Price XDR object.
  XdrPrice toXdr() {
    XdrPrice xdrPrice = new XdrPrice();
    XdrInt32 n = new XdrInt32();
    XdrInt32 d = new XdrInt32();
    n.int32 = this.n;
    d.int32 = this.d;
    xdrPrice.n = n;
    xdrPrice.d = d;
    return xdrPrice;
  }

  @override
  bool operator ==(Object object) {
    if (!(object is Price)) {
      return false;
    }
    Price price = object as Price;
    return this.numerator == price.numerator &&
        this.denominator == price.denominator;
  }
}

String removeTailZero(String src) {
  int pos = 0;
  for (int i = src.length - 1; i >= 0; i--) {
    if (src[i] == '0')
      pos++;
    else if (src[i] == '.') {
      pos++;
      break;
    } else
      break;
  }

  return src.substring(0, src.length - pos);
}
