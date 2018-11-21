import 'xdr_type.dart';
import 'xdr_enum.dart';
import 'xdr_data.dart';
import 'xdr_other.dart';
import 'xdr_operation.dart';
import 'xdr_entry.dart';

class XdrTransaction {
  XdrTransaction() {}
  XdrAccountID _sourceAccount;
  XdrAccountID get sourceAccount => this._sourceAccount;
  set sourceAccount(XdrAccountID value) => this._sourceAccount = value;

  XdrUint32 _fee;
  XdrUint32 get fee => this._fee;
  set fee(XdrUint32 value) => this._fee = value;

  XdrSequenceNumber _seqNum;
  XdrSequenceNumber get seqNum => this._seqNum;
  set seqNum(XdrSequenceNumber value) => this._seqNum = value;

  XdrTimeBounds _timeBounds;
  XdrTimeBounds get timeBounds => this._timeBounds;
  set timeBounds(XdrTimeBounds value) => this._timeBounds = value;

  XdrMemo _memo;
  XdrMemo get memo => this._memo;
  set memo(XdrMemo value) => this._memo = value;

  List<XdrOperation> _operations;
  List<XdrOperation> get operations => this._operations;
  set operations(List<XdrOperation> value) => this._operations = value;

  XdrTransactionExt _ext;
  XdrTransactionExt get ext => this._ext;
  set ext(XdrTransactionExt value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrTransaction encodedTransaction) {
    XdrAccountID.encode(stream, encodedTransaction._sourceAccount);
    XdrUint32.encode(stream, encodedTransaction._fee);
    XdrSequenceNumber.encode(stream, encodedTransaction._seqNum);
    if (encodedTransaction._timeBounds != null) {
      stream.writeInt(1);
      XdrTimeBounds.encode(stream, encodedTransaction._timeBounds);
    } else {
      stream.writeInt(0);
    }
    XdrMemo.encode(stream, encodedTransaction._memo);
    int operationssize = encodedTransaction.operations.length;
    stream.writeInt(operationssize);
    for (int i = 0; i < operationssize; i++) {
      XdrOperation.encode(stream, encodedTransaction._operations[i]);
    }
    XdrTransactionExt.encode(stream, encodedTransaction._ext);
  }

  static XdrTransaction decode(XdrDataInputStream stream) {
    XdrTransaction decodedTransaction = XdrTransaction();
    decodedTransaction._sourceAccount = XdrAccountID.decode(stream);
    decodedTransaction._fee = XdrUint32.decode(stream);
    decodedTransaction._seqNum = XdrSequenceNumber.decode(stream);
    int timeBoundsPresent = stream.readInt();
    if (timeBoundsPresent != 0) {
      decodedTransaction._timeBounds = XdrTimeBounds.decode(stream);
    }
    decodedTransaction._memo = XdrMemo.decode(stream);
    int operationssize = stream.readInt();
    decodedTransaction._operations = List<XdrOperation>(operationssize);
    for (int i = 0; i < operationssize; i++) {
      decodedTransaction._operations[i] = XdrOperation.decode(stream);
    }
    decodedTransaction._ext = XdrTransactionExt.decode(stream);
    return decodedTransaction;
  }
}

class XdrTransactionExt {
  XdrTransactionExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream, XdrTransactionExt encodedTransactionExt) {
    stream.writeInt(encodedTransactionExt.discriminant);
    switch (encodedTransactionExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrTransactionExt decode(XdrDataInputStream stream) {
    XdrTransactionExt decodedTransactionExt = XdrTransactionExt();
    int discriminant = stream.readInt();
    decodedTransactionExt.discriminant = discriminant;
    switch (decodedTransactionExt.discriminant) {
      case 0:
        break;
    }
    return decodedTransactionExt;
  }
}

class XdrTransactionEnvelope {
  XdrTransactionEnvelope() {}
  XdrTransaction _tx;
  XdrTransaction get tx => this._tx;
  set tx(XdrTransaction value) => this._tx = value;

  List<XdrDecoratedSignature> _signatures;
  List<XdrDecoratedSignature> get signatures => this._signatures;
  set signatures(List<XdrDecoratedSignature> value) =>
      this._signatures = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionEnvelope encodedTransactionEnvelope) {
    XdrTransaction.encode(stream, encodedTransactionEnvelope._tx);
    int signaturessize = encodedTransactionEnvelope.signatures.length;
    stream.writeInt(signaturessize);
    for (int i = 0; i < signaturessize; i++) {
      XdrDecoratedSignature.encode(
          stream, encodedTransactionEnvelope._signatures[i]);
    }
  }

  static XdrTransactionEnvelope decode(XdrDataInputStream stream) {
    XdrTransactionEnvelope decodedTransactionEnvelope = XdrTransactionEnvelope();
    decodedTransactionEnvelope._tx = XdrTransaction.decode(stream);
    int signaturessize = stream.readInt();
    decodedTransactionEnvelope._signatures =
        List<XdrDecoratedSignature>(signaturessize);
    for (int i = 0; i < signaturessize; i++) {
      decodedTransactionEnvelope._signatures[i] =
          XdrDecoratedSignature.decode(stream);
    }
    return decodedTransactionEnvelope;
  }
}

class XdrTransactionMeta {
  XdrTransactionMeta() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  List<XdrOperationMeta> _operations;
  List<XdrOperationMeta> get operations => this._operations;
  set operations(List<XdrOperationMeta> value) => this._operations = value;

  XdrTransactionMetaV1 _v1;
  XdrTransactionMetaV1 get v1 => this._v1;
  set v1(XdrTransactionMetaV1 value) => this._v1 = value;

  static void encode(
      XdrDataOutputStream stream, XdrTransactionMeta encodedTransactionMeta) {
    stream.writeInt(encodedTransactionMeta.discriminant);
    switch (encodedTransactionMeta.discriminant) {
      case 0:
        int operationssize = encodedTransactionMeta.operations.length;
        stream.writeInt(operationssize);
        for (int i = 0; i < operationssize; i++) {
          XdrOperationMeta.encode(stream, encodedTransactionMeta._operations[i]);
        }
        break;
      case 1:
        XdrTransactionMetaV1.encode(stream, encodedTransactionMeta._v1);
        break;
    }
  }

  static XdrTransactionMeta decode(XdrDataInputStream stream) {
    XdrTransactionMeta decodedTransactionMeta = XdrTransactionMeta();
    int discriminant = stream.readInt();
    decodedTransactionMeta.discriminant = discriminant;
    switch (decodedTransactionMeta.discriminant) {
      case 0:
        int operationssize = stream.readInt();
        decodedTransactionMeta._operations = List<XdrOperationMeta>(operationssize);
        for (int i = 0; i < operationssize; i++) {
          decodedTransactionMeta._operations[i] = XdrOperationMeta.decode(stream);
        }
        break;
      case 1:
        decodedTransactionMeta._v1 = XdrTransactionMetaV1.decode(stream);
        break;
    }
    return decodedTransactionMeta;
  }
}

class XdrTransactionMetaV1 {
  XdrTransactionMetaV1() {}
  XdrLedgerEntryChanges _txChanges;
  XdrLedgerEntryChanges get txChanges => this._txChanges;
  set txChanges(XdrLedgerEntryChanges value) => this._txChanges = value;

  List<XdrOperationMeta> _operations;
  List<XdrOperationMeta> get operations => this._operations;
  set operations(List<XdrOperationMeta> value) => this._operations = value;

  static void encode(
      XdrDataOutputStream stream, XdrTransactionMetaV1 encodedTransactionMetaV1) {
    XdrLedgerEntryChanges.encode(stream, encodedTransactionMetaV1._txChanges);
    int operationssize = encodedTransactionMetaV1.operations.length;
    stream.writeInt(operationssize);
    for (int i = 0; i < operationssize; i++) {
      XdrOperationMeta.encode(stream, encodedTransactionMetaV1._operations[i]);
    }
  }

  static XdrTransactionMetaV1 decode(XdrDataInputStream stream) {
    XdrTransactionMetaV1 decodedTransactionMetaV1 = XdrTransactionMetaV1();
    decodedTransactionMetaV1._txChanges = XdrLedgerEntryChanges.decode(stream);
    int operationssize = stream.readInt();
    decodedTransactionMetaV1._operations = List<XdrOperationMeta>(operationssize);
    for (int i = 0; i < operationssize; i++) {
      decodedTransactionMetaV1._operations[i] = XdrOperationMeta.decode(stream);
    }
    return decodedTransactionMetaV1;
  }
}

class XdrTransactionResult {
  XdrTransactionResult() {}
  XdrInt64 _feeCharged;
  XdrInt64 get feeCharged => this._feeCharged;
  set feeCharged(XdrInt64 value) => this._feeCharged = value;

  XdrTransactionResultResult _result;
  XdrTransactionResultResult get result => this._result;
  set result(XdrTransactionResultResult value) => this._result = value;

  XdrTransactionResultExt _ext;
  XdrTransactionResultExt get ext => this._ext;
  set ext(XdrTransactionResultExt value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrTransactionResult encodedTransactionResult) {
    XdrInt64.encode(stream, encodedTransactionResult._feeCharged);
    XdrTransactionResultResult.encode(stream, encodedTransactionResult._result);
    XdrTransactionResultExt.encode(stream, encodedTransactionResult._ext);
  }

  static XdrTransactionResult decode(XdrDataInputStream stream) {
    XdrTransactionResult decodedTransactionResult = XdrTransactionResult();
    decodedTransactionResult._feeCharged = XdrInt64.decode(stream);
    decodedTransactionResult._result = XdrTransactionResultResult.decode(stream);
    decodedTransactionResult._ext = XdrTransactionResultExt.decode(stream);
    return decodedTransactionResult;
  }
}

class XdrTransactionResultResult {
  XdrTransactionResultResult() {}
  XdrTransactionResultCode _code;
  XdrTransactionResultCode get discriminant => this._code;
  set discriminant(XdrTransactionResultCode value) => this._code = value;

  List<XdrOperationResult> _results;
  get results => this._results;
  set results(value) => this._results = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionResultResult encodedTransactionResultResult) {
    stream
        .writeInt(encodedTransactionResultResult.discriminant.value);
    switch (encodedTransactionResultResult.discriminant) {
      case XdrTransactionResultCode.txSUCCESS:
      case XdrTransactionResultCode.txFAILED:
        int resultssize = encodedTransactionResultResult.results.length;
        stream.writeInt(resultssize);
        for (int i = 0; i < resultssize; i++) {
          XdrOperationResult.encode(
              stream, encodedTransactionResultResult._results[i]);
        }
        break;
      default:
        break;
    }
  }

  static XdrTransactionResultResult decode(XdrDataInputStream stream) {
    XdrTransactionResultResult decodedTransactionResultResult =
        XdrTransactionResultResult();
    XdrTransactionResultCode discriminant = XdrTransactionResultCode.decode(stream);
    decodedTransactionResultResult.discriminant = discriminant;
    switch (decodedTransactionResultResult.discriminant) {
      case XdrTransactionResultCode.txSUCCESS:
      case XdrTransactionResultCode.txFAILED:
        int resultssize = stream.readInt();
        decodedTransactionResultResult._results =
            List<XdrOperationResult>(resultssize);
        for (int i = 0; i < resultssize; i++) {
          decodedTransactionResultResult._results[i] =
              XdrOperationResult.decode(stream);
        }
        break;
      default:
        break;
    }
    return decodedTransactionResultResult;
  }
}

class XdrTransactionResultExt {
  XdrTransactionResultExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionResultExt encodedTransactionResultExt) {
    stream.writeInt(encodedTransactionResultExt.discriminant);
    switch (encodedTransactionResultExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrTransactionResultExt decode(XdrDataInputStream stream) {
    XdrTransactionResultExt decodedTransactionResultExt =
        XdrTransactionResultExt();
    int discriminant = stream.readInt();
    decodedTransactionResultExt.discriminant = discriminant;
    switch (decodedTransactionResultExt.discriminant) {
      case 0:
        break;
    }
    return decodedTransactionResultExt;
  }
}

class XdrTransactionResultPair {
  XdrTransactionResultPair() {}
  XdrHash _transactionHash;
  XdrHash get transactionHash => this._transactionHash;
  set transactionHash(XdrHash value) => this._transactionHash = value;

  XdrTransactionResult _result;
  XdrTransactionResult get result => this._result;
  set result(XdrTransactionResult value) => this._result = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionResultPair encodedTransactionResultPair) {
    XdrHash.encode(stream, encodedTransactionResultPair._transactionHash);
    XdrTransactionResult.encode(stream, encodedTransactionResultPair._result);
  }

  static XdrTransactionResultPair decode(XdrDataInputStream stream) {
    XdrTransactionResultPair decodedTransactionResultPair =
        XdrTransactionResultPair();
    decodedTransactionResultPair._transactionHash = XdrHash.decode(stream);
    decodedTransactionResultPair._result = XdrTransactionResult.decode(stream);
    return decodedTransactionResultPair;
  }
}

class XdrTransactionResultSet {
  XdrTransactionResultSet() {}
  List<XdrTransactionResultPair> _results;
  List<XdrTransactionResultPair> get results => this._results;
  set results(List<XdrTransactionResultPair> value) => this._results = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionResultSet encodedTransactionResultSet) {
    int resultssize = encodedTransactionResultSet.results.length;
    stream.writeInt(resultssize);
    for (int i = 0; i < resultssize; i++) {
      XdrTransactionResultPair.encode(
          stream, encodedTransactionResultSet._results[i]);
    }
  }

  static XdrTransactionResultSet decode(XdrDataInputStream stream) {
    XdrTransactionResultSet decodedTransactionResultSet =
        XdrTransactionResultSet();
    int resultssize = stream.readInt();
    decodedTransactionResultSet._results =
        List<XdrTransactionResultPair>(resultssize);
    for (int i = 0; i < resultssize; i++) {
      decodedTransactionResultSet._results[i] =
          XdrTransactionResultPair.decode(stream);
    }
    return decodedTransactionResultSet;
  }
}

class XdrTransactionSet {
  XdrTransactionSet() {}
  XdrHash _previousLedgerHash;
  XdrHash get previousLedgerHash => this._previousLedgerHash;
  set previousLedgerHash(XdrHash value) => this._previousLedgerHash = value;

  List<XdrTransactionEnvelope> _txs;
  List<XdrTransactionEnvelope> get txs => this._txs;
  set txs(List<XdrTransactionEnvelope> value) => this._txs = value;

  static void encode(
      XdrDataOutputStream stream, XdrTransactionSet encodedTransactionSet) {
    XdrHash.encode(stream, encodedTransactionSet._previousLedgerHash);
    int txssize = encodedTransactionSet.txs.length;
    stream.writeInt(txssize);
    for (int i = 0; i < txssize; i++) {
      XdrTransactionEnvelope.encode(stream, encodedTransactionSet._txs[i]);
    }
  }

  static XdrTransactionSet decode(XdrDataInputStream stream) {
    XdrTransactionSet decodedTransactionSet = XdrTransactionSet();
    decodedTransactionSet._previousLedgerHash = XdrHash.decode(stream);
    int txssize = stream.readInt();
    decodedTransactionSet._txs = List<XdrTransactionEnvelope>(txssize);
    for (int i = 0; i < txssize; i++) {
      decodedTransactionSet._txs[i] = XdrTransactionEnvelope.decode(stream);
    }
    return decodedTransactionSet;
  }
}

class XdrTransactionSignaturePayload {
  XdrTransactionSignaturePayload() {}
  XdrHash _networkId;
  XdrHash get networkId => this._networkId;
  set networkId(XdrHash value) => this._networkId = value;

  XdrTransactionSignaturePayloadTaggedTransaction _taggedTransaction;
  XdrTransactionSignaturePayloadTaggedTransaction get taggedTransaction =>
      this._taggedTransaction;
  set taggedTransaction(
          XdrTransactionSignaturePayloadTaggedTransaction value) =>
      this._taggedTransaction = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionSignaturePayload encodedTransactionSignaturePayload) {
    XdrHash.encode(stream, encodedTransactionSignaturePayload._networkId);
    XdrTransactionSignaturePayloadTaggedTransaction.encode(
        stream, encodedTransactionSignaturePayload._taggedTransaction);
  }

  static XdrTransactionSignaturePayload decode(XdrDataInputStream stream) {
    XdrTransactionSignaturePayload decodedTransactionSignaturePayload =
        XdrTransactionSignaturePayload();
    decodedTransactionSignaturePayload._networkId = XdrHash.decode(stream);
    decodedTransactionSignaturePayload._taggedTransaction =
        XdrTransactionSignaturePayloadTaggedTransaction.decode(stream);
    return decodedTransactionSignaturePayload;
  }
}

class XdrTransactionSignaturePayloadTaggedTransaction {
  XdrTransactionSignaturePayloadTaggedTransaction() {}
  XdrEnvelopeType _type;
  XdrEnvelopeType get discriminant => this._type;
  set discriminant(XdrEnvelopeType value) => this._type = value;

  XdrTransaction _tx;
  XdrTransaction get tx => this._tx;
  set tx(XdrTransaction value) => this._tx = value;

  static void encode(
      XdrDataOutputStream stream,
      XdrTransactionSignaturePayloadTaggedTransaction
          encodedTransactionSignaturePayloadTaggedTransaction) {
    stream.writeInt(encodedTransactionSignaturePayloadTaggedTransaction
        .discriminant
        .value);
    switch (
        encodedTransactionSignaturePayloadTaggedTransaction.discriminant) {
      case XdrEnvelopeType.ENVELOPE_TYPE_TX:
        XdrTransaction.encode(
            stream, encodedTransactionSignaturePayloadTaggedTransaction._tx);
        break;
    }
  }

  static XdrTransactionSignaturePayloadTaggedTransaction decode(
      XdrDataInputStream stream) {
    XdrTransactionSignaturePayloadTaggedTransaction
        decodedTransactionSignaturePayloadTaggedTransaction =
        XdrTransactionSignaturePayloadTaggedTransaction();
    XdrEnvelopeType discriminant = XdrEnvelopeType.decode(stream);
    decodedTransactionSignaturePayloadTaggedTransaction
        .discriminant = discriminant;
    switch (
        decodedTransactionSignaturePayloadTaggedTransaction.discriminant) {
      case XdrEnvelopeType.ENVELOPE_TYPE_TX:
        decodedTransactionSignaturePayloadTaggedTransaction._tx =
            XdrTransaction.decode(stream);
        break;
    }
    return decodedTransactionSignaturePayloadTaggedTransaction;
  }
}
