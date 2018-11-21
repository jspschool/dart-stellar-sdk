import 'xdr_type.dart';
import 'xdr_enum.dart';
import 'xdr_data.dart';
import 'xdr_auth.dart';
import 'xdr_network.dart';
import 'xdr_asset.dart';
import 'xdr_transaction.dart';
import 'xdr_scp.dart';

class XdrAccountID {
  XdrPublicKey _accountID;
  XdrPublicKey get accountID => this._accountID;
  set accountID(XdrPublicKey value) => this._accountID = value;

  static void encode(XdrDataOutputStream stream, XdrAccountID encodedAccountID) {
    XdrPublicKey.encode(stream, encodedAccountID.accountID);
  }

  static XdrAccountID decode(XdrDataInputStream stream) {
    XdrAccountID decodedAccountID = XdrAccountID();
    decodedAccountID.accountID = XdrPublicKey.decode(stream);
    return decodedAccountID;
  }
}

class XdrAccountMergeResult {
  XdrAccountMergeResult() {}
  XdrAccountMergeResultCode _code;
  XdrAccountMergeResultCode get discriminant => this._code;
  set discriminant(XdrAccountMergeResultCode value) => this._code = value;

  XdrInt64 _sourceAccountBalance;
  XdrInt64 get sourceAccountBalance => this._sourceAccountBalance;
  set sourceAccountBalance(XdrInt64 value) => this._sourceAccountBalance = value;

  static void encode(XdrDataOutputStream stream,
      XdrAccountMergeResult encodedAccountMergeResult) {
    stream.writeInt(encodedAccountMergeResult.discriminant.value);
    switch (encodedAccountMergeResult.discriminant) {
      case XdrAccountMergeResultCode.ACCOUNT_MERGE_SUCCESS:
        XdrInt64.encode(stream, encodedAccountMergeResult._sourceAccountBalance);
        break;
      default:
        break;
    }
  }

  static XdrAccountMergeResult decode(XdrDataInputStream stream) {
    XdrAccountMergeResult decodedAccountMergeResult = XdrAccountMergeResult();
    XdrAccountMergeResultCode discriminant = XdrAccountMergeResultCode.decode(stream);
    decodedAccountMergeResult.discriminant = discriminant;
    switch (decodedAccountMergeResult.discriminant) {
      case XdrAccountMergeResultCode.ACCOUNT_MERGE_SUCCESS:
        decodedAccountMergeResult._sourceAccountBalance = XdrInt64.decode(stream);
        break;
      default:
        break;
    }
    return decodedAccountMergeResult;
  }
}

class XdrClaimOfferAtom {
  XdrClaimOfferAtom() {}
  XdrAccountID _sellerID;
  XdrAccountID get sellerID => this._sellerID;
  set sellerID(XdrAccountID value) => this._sellerID = value;

  XdrUint64 _offerID;
  XdrUint64 get offerID => this._offerID;
  set offerID(XdrUint64 value) => this._offerID = value;

  XdrAsset _assetSold;
  XdrAsset get assetSold => this._assetSold;
  set assetSold(XdrAsset value) => this._assetSold = value;

  XdrInt64 _amountSold;
  XdrInt64 get amountSold => this._amountSold;
  set amountSold(XdrInt64 value) => this._amountSold = value;

  XdrAsset _assetBought;
  XdrAsset get assetBought => this._assetBought;
  set assetBought(XdrAsset value) => this._assetBought = value;

  XdrInt64 _amountBought;
  XdrInt64 get amountBought => this._amountBought;
  set amountBought(XdrInt64 value) => this._amountBought = value;

  static void encode(
      XdrDataOutputStream stream, XdrClaimOfferAtom encodedClaimOfferAtom) {
    XdrAccountID.encode(stream, encodedClaimOfferAtom.sellerID);
    XdrUint64.encode(stream, encodedClaimOfferAtom.offerID);
    XdrAsset.encode(stream, encodedClaimOfferAtom.assetSold);
    XdrInt64.encode(stream, encodedClaimOfferAtom.amountSold);
    XdrAsset.encode(stream, encodedClaimOfferAtom.assetBought);
    XdrInt64.encode(stream, encodedClaimOfferAtom.amountBought);
  }

  static XdrClaimOfferAtom decode(XdrDataInputStream stream) {
    XdrClaimOfferAtom decodedClaimOfferAtom = XdrClaimOfferAtom();
    decodedClaimOfferAtom.sellerID = XdrAccountID.decode(stream);
    decodedClaimOfferAtom.offerID = XdrUint64.decode(stream);
    decodedClaimOfferAtom.assetSold = XdrAsset.decode(stream);
    decodedClaimOfferAtom.amountSold = XdrInt64.decode(stream);
    decodedClaimOfferAtom.assetBought = XdrAsset.decode(stream);
    decodedClaimOfferAtom.amountBought = XdrInt64.decode(stream);
    return decodedClaimOfferAtom;
  }
}

class XdrDecoratedSignature {
  XdrDecoratedSignature() {}
  XdrSignatureHint _hint;
  XdrSignatureHint get hint => this._hint;
  set hint(XdrSignatureHint value) => this._hint = value;

  XdrSignature _signature;
  XdrSignature get signature => this._signature;
  set signature(XdrSignature value) => this._signature = value;

  static void encode(XdrDataOutputStream stream,
      XdrDecoratedSignature encodedDecoratedSignature) {
    XdrSignatureHint.encode(stream, encodedDecoratedSignature.hint);
    XdrSignature.encode(stream, encodedDecoratedSignature.signature);
  }

  static XdrDecoratedSignature decode(XdrDataInputStream stream) {
    XdrDecoratedSignature decodedDecoratedSignature = XdrDecoratedSignature();
    decodedDecoratedSignature.hint = XdrSignatureHint.decode(stream);
    decodedDecoratedSignature.signature = XdrSignature.decode(stream);
    return decodedDecoratedSignature;
  }
}

class XdrDontHave {
  XdrDontHave() {}
  XdrMessageType _type;
  XdrMessageType get type => this._type;
  set type(XdrMessageType value) => this._type = value;

  XdrUint256 _reqHash;
  XdrUint256 get reqHash => this._reqHash;
  set reqHash(XdrUint256 value) => this._reqHash = value;

  static void encode(XdrDataOutputStream stream, XdrDontHave encodedDontHave) {
    XdrMessageType.encode(stream, encodedDontHave.type);
    XdrUint256.encode(stream, encodedDontHave.reqHash);
  }

  static XdrDontHave decode(XdrDataInputStream stream) {
    XdrDontHave decodedDontHave = XdrDontHave();
    decodedDontHave.type = XdrMessageType.decode(stream);
    decodedDontHave.reqHash = XdrUint256.decode(stream);
    return decodedDontHave;
  }
}

class XdrError {
  XdrError() {}
  XdrErrorCode _code;
  XdrErrorCode get code => this._code;
  set code(XdrErrorCode value) => this._code = value;

  String _msg;
  String get msg => this._msg;
  set msg(String value) => this._msg = value;

  static void encode(XdrDataOutputStream stream, XdrError encodedError) {
    XdrErrorCode.encode(stream, encodedError.code);
    stream.writeString(encodedError.msg);
  }

  static XdrError decode(XdrDataInputStream stream) {
    XdrError decodedError = XdrError();
    decodedError.code = XdrErrorCode.decode(stream);
    decodedError.msg = stream.readString();
    return decodedError;
  }
}

class XdrHello {
  XdrHello() {}
  XdrUint32 _ledgerVersion;
  XdrUint32 get ledgerVersion => this._ledgerVersion;
  set ledgerVersion(XdrUint32 value) => this._ledgerVersion = value;

  XdrUint32 _overlayVersion;
  XdrUint32 get overlayVersion => this._overlayVersion;
  set overlayVersion(XdrUint32 value) => this._overlayVersion = value;

  XdrUint32 _overlayMinVersion;
  XdrUint32 get overlayMinVersion => this._overlayMinVersion;
  set overlayMinVersion(XdrUint32 value) => this._overlayMinVersion = value;

  XdrHash _networkID;
  XdrHash get networkID => this._networkID;
  set networkID(XdrHash value) => this._networkID = value;

  String _versionStr;
  String get versionStr => this._versionStr;
  set versionStr(String value) => this._versionStr = value;

  int _listeningPort;
  int get listeningPort => this._listeningPort;
  set listeningPort(int value) => this._listeningPort = value;

  XdrNodeID _peerID;
  XdrNodeID get peerID => this._peerID;
  set peerID(XdrNodeID value) => this._peerID = value;

  XdrAuthCert _cert;
  XdrAuthCert get cert => this._cert;
  set cert(XdrAuthCert value) => this._cert = value;

  XdrUint256 _nonce;
  XdrUint256 get nonce => this._nonce;
  set nonce(XdrUint256 value) => this._nonce = value;

  static void encode(XdrDataOutputStream stream, XdrHello encodedHello) {
    XdrUint32.encode(stream, encodedHello.ledgerVersion);
    XdrUint32.encode(stream, encodedHello.overlayVersion);
    XdrUint32.encode(stream, encodedHello.overlayMinVersion);
    XdrHash.encode(stream, encodedHello.networkID);
    stream.writeString(encodedHello.versionStr);
    stream.writeInt(encodedHello.listeningPort);
    XdrNodeID.encode(stream, encodedHello.peerID);
    XdrAuthCert.encode(stream, encodedHello.cert);
    XdrUint256.encode(stream, encodedHello.nonce);
  }

  static XdrHello decode(XdrDataInputStream stream) {
    XdrHello decodedHello = XdrHello();
    decodedHello.ledgerVersion = XdrUint32.decode(stream);
    decodedHello.overlayVersion = XdrUint32.decode(stream);
    decodedHello.overlayMinVersion = XdrUint32.decode(stream);
    decodedHello.networkID = XdrHash.decode(stream);
    decodedHello.versionStr = stream.readString();
    decodedHello.listeningPort = stream.readInt();
    decodedHello.peerID = XdrNodeID.decode(stream);
    decodedHello.cert = XdrAuthCert.decode(stream);
    decodedHello.nonce = XdrUint256.decode(stream);
    return decodedHello;
  }
}

class XdrLiabilities {
  XdrLiabilities() {}
  XdrInt64 _buying;
  XdrInt64 get buying => this._buying;
  set buying(XdrInt64 value) => this._buying = value;

  XdrInt64 _selling;
  XdrInt64 get selling => this._selling;
  set selling(XdrInt64 value) => this._selling = value;

  static void encode(
      XdrDataOutputStream stream, XdrLiabilities encodedLiabilities) {
    XdrInt64.encode(stream, encodedLiabilities.buying);
    XdrInt64.encode(stream, encodedLiabilities.selling);
  }

  static XdrLiabilities decode(XdrDataInputStream stream) {
    XdrLiabilities decodedLiabilities = XdrLiabilities();
    decodedLiabilities.buying = XdrInt64.decode(stream);
    decodedLiabilities.selling = XdrInt64.decode(stream);
    return decodedLiabilities;
  }
}

class XdrMemo {
  XdrMemo() {}
  XdrMemoType _type;
  XdrMemoType get discriminant => this._type;
  set discriminant(XdrMemoType value) => this._type = value;

  String _text;
  String get text => this._text;
  set text(String value) => this._text = value;

  XdrUint64 _id;
  XdrUint64 get id => this._id;
  set id(XdrUint64 value) => this._id = value;

  XdrHash _hash;
  XdrHash get hash => this._hash;
  set hash(XdrHash value) => this._hash = value;

  XdrHash _retHash;
  XdrHash get retHash => this._retHash;
  set retHash(XdrHash value) => this._retHash = value;

  static void encode(XdrDataOutputStream stream, XdrMemo encodedMemo) {
    stream.writeInt(encodedMemo.discriminant.value);
    switch (encodedMemo.discriminant) {
      case XdrMemoType.MEMO_NONE:
        break;
      case XdrMemoType.MEMO_TEXT:
        stream.writeString(encodedMemo.text);
        break;
      case XdrMemoType.MEMO_ID:
        XdrUint64.encode(stream, encodedMemo.id);
        break;
      case XdrMemoType.MEMO_HASH:
        XdrHash.encode(stream, encodedMemo.hash);
        break;
      case XdrMemoType.MEMO_RETURN:
        XdrHash.encode(stream, encodedMemo.retHash);
        break;
    }
  }

  static XdrMemo decode(XdrDataInputStream stream) {
    XdrMemo decodedMemo = XdrMemo();
    XdrMemoType discriminant = XdrMemoType.decode(stream);
    decodedMemo.discriminant = discriminant;
    switch (decodedMemo.discriminant) {
      case XdrMemoType.MEMO_NONE:
        break;
      case XdrMemoType.MEMO_TEXT:
        decodedMemo.text = stream.readString();
        break;
      case XdrMemoType.MEMO_ID:
        decodedMemo.id = XdrUint64.decode(stream);
        break;
      case XdrMemoType.MEMO_HASH:
        decodedMemo.hash = XdrHash.decode(stream);
        break;
      case XdrMemoType.MEMO_RETURN:
        decodedMemo.retHash = XdrHash.decode(stream);
        break;
    }
    return decodedMemo;
  }
}

class XdrPrice {
  XdrPrice() {}
  XdrInt32 _n;
  XdrInt32 get n => this._n;
  set n(XdrInt32 value) => this._n = value;

  XdrInt32 _d;
  XdrInt32 get d => this._d;
  set d(XdrInt32 value) => this._d = value;

  static void encode(XdrDataOutputStream stream, XdrPrice encodedPrice) {
    XdrInt32.encode(stream, encodedPrice.n);
    XdrInt32.encode(stream, encodedPrice.d);
  }

  static XdrPrice decode(XdrDataInputStream stream) {
    XdrPrice decodedPrice = XdrPrice();
    decodedPrice.n = XdrInt32.decode(stream);
    decodedPrice.d = XdrInt32.decode(stream);
    return decodedPrice;
  }
}


class XdrStellarMessage {
  XdrStellarMessage() {}
  XdrMessageType _type;
  XdrMessageType get discriminant => this._type;
  set discriminant(XdrMessageType value) => this._type = value;

  XdrError _error;
  XdrError get error => this._error;
  set error(XdrError value) => this._error = value;

  XdrHello _hello;
  XdrHello get hello => this._hello;
  set hello(XdrHello value) => this._hello = value;

  XdrAuth _auth;
  XdrAuth get auth => this._auth;
  set auth(XdrAuth value) => this._auth = value;

  XdrDontHave _dontHave;
  XdrDontHave get dontHave => this._dontHave;
  set dontHave(XdrDontHave value) => this._dontHave = value;

  List<XdrPeerAddress> _peers;
  List<XdrPeerAddress> get peers => this._peers;
  set peers(List<XdrPeerAddress> value) => this._peers = value;

  XdrUint256 _txSetHash;
  XdrUint256 get txSetHash => this._txSetHash;
  set txSetHash(XdrUint256 value) => this._txSetHash = value;

  XdrTransactionSet _txSet;
  XdrTransactionSet get txSet => this._txSet;
  set txSet(XdrTransactionSet value) => this._txSet = value;

  XdrTransactionEnvelope _transaction;
  XdrTransactionEnvelope get transaction => this._transaction;
  set transaction(XdrTransactionEnvelope value) => this._transaction = value;

  XdrUint256 _qSetHash;
  XdrUint256 get qSetHash => this._qSetHash;
  set qSetHash(XdrUint256 value) => this._qSetHash = value;

  XdrSCPQuorumSet _qSet;
  XdrSCPQuorumSet get qSet => this._qSet;
  set qSet(XdrSCPQuorumSet value) => this._qSet = value;

  XdrSCPEnvelope _envelope;
  XdrSCPEnvelope get envelope => this._envelope;
  set envelope(XdrSCPEnvelope value) => this._envelope = value;

  XdrUint32 _getSCPLedgerSeq;
  XdrUint32 get getSCPLedgerSeq => this._getSCPLedgerSeq;
  set getSCPLedgerSeq(XdrUint32 value) => this._getSCPLedgerSeq = value;

  static void encode(
      XdrDataOutputStream stream, XdrStellarMessage encodedStellarMessage) {
    stream.writeInt(encodedStellarMessage.discriminant.value);
    switch (encodedStellarMessage.discriminant) {
      case XdrMessageType.ERROR_MSG:
        XdrError.encode(stream, encodedStellarMessage.error);
        break;
      case XdrMessageType.HELLO:
        XdrHello.encode(stream, encodedStellarMessage.hello);
        break;
      case XdrMessageType.AUTH:
        XdrAuth.encode(stream, encodedStellarMessage.auth);
        break;
      case XdrMessageType.DONT_HAVE:
        XdrDontHave.encode(stream, encodedStellarMessage.dontHave);
        break;
      case XdrMessageType.GET_PEERS:
        break;
      case XdrMessageType.PEERS:
        int peerssize = encodedStellarMessage.peers.length;
        stream.writeInt(peerssize);
        for (int i = 0; i < peerssize; i++) {
          XdrPeerAddress.encode(stream, encodedStellarMessage.peers[i]);
        }
        break;
      case XdrMessageType.GET_TX_SET:
        XdrUint256.encode(stream, encodedStellarMessage.txSetHash);
        break;
      case XdrMessageType.TX_SET:
        XdrTransactionSet.encode(stream, encodedStellarMessage.txSet);
        break;
      case XdrMessageType.TRANSACTION:
        XdrTransactionEnvelope.encode(stream, encodedStellarMessage.transaction);
        break;
      case XdrMessageType.GET_SCP_QUORUMSET:
        XdrUint256.encode(stream, encodedStellarMessage.qSetHash);
        break;
      case XdrMessageType.SCP_QUORUMSET:
        XdrSCPQuorumSet.encode(stream, encodedStellarMessage.qSet);
        break;
      case XdrMessageType.SCP_MESSAGE:
        XdrSCPEnvelope.encode(stream, encodedStellarMessage.envelope);
        break;
      case XdrMessageType.GET_SCP_STATE:
        XdrUint32.encode(stream, encodedStellarMessage.getSCPLedgerSeq);
        break;
    }
  }

  static XdrStellarMessage decode(XdrDataInputStream stream) {
    XdrStellarMessage decodedStellarMessage = XdrStellarMessage();
    XdrMessageType discriminant = XdrMessageType.decode(stream);
    decodedStellarMessage.discriminant = discriminant;
    switch (decodedStellarMessage.discriminant) {
      case XdrMessageType.ERROR_MSG:
        decodedStellarMessage.error = XdrError.decode(stream);
        break;
      case XdrMessageType.HELLO:
        decodedStellarMessage.hello = XdrHello.decode(stream);
        break;
      case XdrMessageType.AUTH:
        decodedStellarMessage.auth = XdrAuth.decode(stream);
        break;
      case XdrMessageType.DONT_HAVE:
        decodedStellarMessage.dontHave = XdrDontHave.decode(stream);
        break;
      case XdrMessageType.GET_PEERS:
        break;
      case XdrMessageType.PEERS:
        int peerssize = stream.readInt();
        decodedStellarMessage.peers = List<XdrPeerAddress>(peerssize);
        for (int i = 0; i < peerssize; i++) {
          decodedStellarMessage.peers[i] = XdrPeerAddress.decode(stream);
        }
        break;
      case XdrMessageType.GET_TX_SET:
        decodedStellarMessage.txSetHash = XdrUint256.decode(stream);
        break;
      case XdrMessageType.TX_SET:
        decodedStellarMessage.txSet = XdrTransactionSet.decode(stream);
        break;
      case XdrMessageType.TRANSACTION:
        decodedStellarMessage.transaction = XdrTransactionEnvelope.decode(stream);
        break;
      case XdrMessageType.GET_SCP_QUORUMSET:
        decodedStellarMessage.qSetHash = XdrUint256.decode(stream);
        break;
      case XdrMessageType.SCP_QUORUMSET:
        decodedStellarMessage.qSet = XdrSCPQuorumSet.decode(stream);
        break;
      case XdrMessageType.SCP_MESSAGE:
        decodedStellarMessage.envelope = XdrSCPEnvelope.decode(stream);
        break;
      case XdrMessageType.GET_SCP_STATE:
        decodedStellarMessage.getSCPLedgerSeq = XdrUint32.decode(stream);
        break;
    }
    return decodedStellarMessage;
  }
}

class XdrStellarValue {
  XdrStellarValue() {}
  XdrHash _txSetHash;
  XdrHash get txSetHash => this._txSetHash;
  set txSetHash(XdrHash value) => this._txSetHash = value;

  XdrUint64 _closeTime;
  XdrUint64 get closeTime => this._closeTime;
  set closeTime(XdrUint64 value) => this._closeTime = value;

  List<XdrUpgradeType> _upgrades;
  List<XdrUpgradeType> get upgrades => this._upgrades;
  set upgrades(List<XdrUpgradeType> value) => this._upgrades = value;

  XdrStellarValueExt _ext;
  XdrStellarValueExt get ext => this._ext;
  set ext(XdrStellarValueExt value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrStellarValue encodedStellarValue) {
    XdrHash.encode(stream, encodedStellarValue.txSetHash);
    XdrUint64.encode(stream, encodedStellarValue.closeTime);
    int upgradessize = encodedStellarValue.upgrades.length;
    stream.writeInt(upgradessize);
    for (int i = 0; i < upgradessize; i++) {
      XdrUpgradeType.encode(stream, encodedStellarValue.upgrades[i]);
    }
    XdrStellarValueExt.encode(stream, encodedStellarValue.ext);
  }

  static XdrStellarValue decode(XdrDataInputStream stream) {
    XdrStellarValue decodedStellarValue = XdrStellarValue();
    decodedStellarValue.txSetHash = XdrHash.decode(stream);
    decodedStellarValue.closeTime = XdrUint64.decode(stream);
    int upgradessize = stream.readInt();
    decodedStellarValue.upgrades = List<XdrUpgradeType>(upgradessize);
    for (int i = 0; i < upgradessize; i++) {
      decodedStellarValue.upgrades[i] = XdrUpgradeType.decode(stream);
    }
    decodedStellarValue.ext = XdrStellarValueExt.decode(stream);
    return decodedStellarValue;
  }
}

class XdrStellarValueExt {
  XdrStellarValueExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream, XdrStellarValueExt encodedStellarValueExt) {
    stream.writeInt(encodedStellarValueExt.discriminant);
    switch (encodedStellarValueExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrStellarValueExt decode(XdrDataInputStream stream) {
    XdrStellarValueExt decodedStellarValueExt = XdrStellarValueExt();
    int discriminant = stream.readInt();
    decodedStellarValueExt.discriminant = discriminant;
    switch (decodedStellarValueExt.discriminant) {
      case 0:
        break;
    }
    return decodedStellarValueExt;
  }
}

class XdrTimeBounds {
  XdrTimeBounds() {}
  XdrUint64 _minTime;
  XdrUint64 get minTime => this._minTime;
  set minTime(XdrUint64 value) => this._minTime = value;

  XdrUint64 _maxTime;
  XdrUint64 get maxTime => this._maxTime;
  set maxTime(XdrUint64 value) => this._maxTime = value;

  static void encode(XdrDataOutputStream stream, XdrTimeBounds encodedTimeBounds) {
    XdrUint64.encode(stream, encodedTimeBounds.minTime);
    XdrUint64.encode(stream, encodedTimeBounds.maxTime);
  }

  static XdrTimeBounds decode(XdrDataInputStream stream) {
    XdrTimeBounds decodedTimeBounds = XdrTimeBounds();
    decodedTimeBounds.minTime = XdrUint64.decode(stream);
    decodedTimeBounds.maxTime = XdrUint64.decode(stream);
    return decodedTimeBounds;
  }
}
