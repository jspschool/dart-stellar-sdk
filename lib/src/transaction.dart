import "dart:convert";
import 'dart:typed_data';
import 'key_pair.dart';
import 'memo.dart';
import 'network.dart';
import 'operation.dart';
import 'util.dart';
import 'xdr/xdr_data.dart';
import 'xdr/xdr_enum.dart';
import 'xdr/xdr_operation.dart';
import 'xdr/xdr_other.dart';
import 'xdr/xdr_transaction.dart';
import 'xdr/xdr_type.dart';

///Specifies interface for Account object used in TransactionBuilder
abstract class TransactionBuilderAccount {
  ///Returns keypair associated with this Account
  KeyPair get keypair;

  ///Returns current sequence number ot this Account.
  int get sequenceNumber;

  ///Returns sequence number incremented by one, but does not increment internal counter.
  int get incrementedSequenceNumber;

  ///Increments sequence number in this object by one.
  void incrementSequenceNumber();
}

///TimeBounds represents the time interval that a transaction is valid.
class TimeBounds {
  int _mMinTime;
  int _mMaxTime;

  TimeBounds(int minTime, int maxTime) {
    if (maxTime > 0 && minTime >= maxTime) {
      throw Exception("minTime must be >= maxTime");
    }

    _mMinTime = minTime;
    _mMaxTime = maxTime;
  }

  int get minTime => _mMinTime;

  int get maxTime => _mMaxTime;

  static TimeBounds fromXdr(XdrTimeBounds timeBounds) {
    if (timeBounds == null) {
      return null;
    }

    return TimeBounds(timeBounds.minTime.uint64, timeBounds.maxTime.uint64);
  }

  XdrTimeBounds toXdr() {
    XdrTimeBounds timeBounds = XdrTimeBounds();
    XdrUint64 minTime = XdrUint64();
    XdrUint64 maxTime = XdrUint64();
    minTime.uint64 = _mMinTime;
    maxTime.uint64 = _mMaxTime;
    timeBounds.minTime = minTime;
    timeBounds.maxTime = maxTime;
    return timeBounds;
  }

  @override
  bool operator ==(Object o) {
    if (o == null || !(o is TimeBounds)) {
      return false;
    }

    TimeBounds that = o as TimeBounds;

    if (_mMinTime != that.minTime) return false;
    return _mMaxTime == that.maxTime;
  }
}

///Represents <a href="https://www.stellar.org/developers/learn/concepts/transactions.html" target="_blank">Transaction</a> in Stellar network.
class Transaction {
  static final int BASE_FEE = 100;

  int _mFee;
  KeyPair _mSourceAccount;
  int _mSequenceNumber;
  List<Operation> _mOperations;
  Memo _mMemo;
  TimeBounds _mTimeBounds;
  List<XdrDecoratedSignature> _mSignatures;

  Transaction(KeyPair sourceAccount, int fee, int sequenceNumber,
      List<Operation> operations, Memo memo, TimeBounds timeBounds) {
    _mSourceAccount =
        checkNotNull(sourceAccount, "sourceAccount cannot be null");
    _mSequenceNumber =
        checkNotNull(sequenceNumber, "sequenceNumber cannot be null");
    _mOperations = checkNotNull(operations, "operations cannot be null");
    checkArgument(operations.length > 0, "At least one operation required");

    _mFee = fee;
    _mSignatures = List<XdrDecoratedSignature>();
    _mMemo = memo != null ? memo : Memo.none();
    _mTimeBounds = timeBounds;
  }

  ///Adds a signature ed25519PublicKey to this transaction.
  void sign(KeyPair signer) {
    checkNotNull(signer, "signer cannot be null");
    Uint8List txHash = this.hash();
    _mSignatures.add(signer.signDecorated(txHash));
  }

  ///Adds a sha256Hash signature to this transaction by revealing preimage.
  void signHash(Uint8List preimage) {
    checkNotNull(preimage, "preimage cannot be null");
    XdrSignature signature = XdrSignature();
    signature.signature = preimage;

    Uint8List hash = Util.hash(preimage);
    Uint8List signatureHintBytes = Uint8List.fromList(
        hash.getRange(hash.length - 4, hash.length).toList());
    XdrSignatureHint signatureHint = XdrSignatureHint();
    signatureHint.signatureHint = signatureHintBytes;

    XdrDecoratedSignature decoratedSignature = XdrDecoratedSignature();
    decoratedSignature.hint = signatureHint;
    decoratedSignature.signature = signature;

    _mSignatures.add(decoratedSignature);
  }

  ///Returns transaction hash.
  Uint8List hash() {
    return Util.hash(this.signatureBase());
  }

  ///Returns signature base.
  Uint8List signatureBase() {
    if (Network.current() == null) {
      throw NoNetworkSelectedException();
    }

    try {
      XdrDataOutputStream xdrOutputStream = XdrDataOutputStream();
      // Hashed NetworkID
      xdrOutputStream.write(Network.current().networkId);
      // Envelope Type - 4 bytes
      List<int> type_tx = List<int>.filled(4, 0);
      type_tx[3] = XdrEnvelopeType.ENVELOPE_TYPE_TX.value;
      xdrOutputStream.write(type_tx);
      // Transaction XDR bytes
      XdrTransaction.encode(xdrOutputStream, this.toXdr());

      return Uint8List.fromList(xdrOutputStream.bytes);
    } catch (exception) {
      return null;
    }
  }

  KeyPair get sourceAccount => _mSourceAccount;

  int get sequenceNumber => _mSequenceNumber;

  List<XdrDecoratedSignature> get signatures => _mSignatures;

  Memo get memo => _mMemo;

  ///Return TimeBounds, or null (representing no time restrictions)
  TimeBounds get timeBounds => _mTimeBounds;

  ///Returns fee paid for transaction in stroops (1 stroop = 0.0000001 XLM).
  int get fee => _mFee;

  ///Returns operations in this transaction.
  List<Operation> get operations => _mOperations;

  ///Generates Transaction XDR object.
  XdrTransaction toXdr() {
    // fee
    XdrUint32 fee = XdrUint32();
    fee.uint32 = _mFee;
    // sequenceNumber
    XdrInt64 sequenceNumberUint = XdrInt64();
    sequenceNumberUint.int64 = _mSequenceNumber;
    XdrSequenceNumber sequenceNumber = XdrSequenceNumber();
    sequenceNumber.sequenceNumber = sequenceNumberUint;
    // sourceAccount
    XdrAccountID sourceAccount = XdrAccountID();
    sourceAccount.accountID = _mSourceAccount.xdrPublicKey;
    // operations
    List<XdrOperation> operations = List<XdrOperation>(_mOperations.length);
    for (int i = 0; i < _mOperations.length; i++) {
      operations[i] = _mOperations[i].toXdr();
    }
    // ext
    XdrTransactionExt ext = XdrTransactionExt();
    ext.discriminant = 0;

    XdrTransaction transaction = XdrTransaction();
    transaction.fee = fee;
    transaction.seqNum = sequenceNumber;
    transaction.sourceAccount = sourceAccount;
    transaction.operations = operations;
    transaction.memo = _mMemo.toXdr();
    transaction.timeBounds =
        (_mTimeBounds == null ? null : _mTimeBounds.toXdr());
    transaction.ext = ext;
    return transaction;
  }

  ///Creates a <code>Transaction</code> instance from previously build <code>TransactionEnvelope</code>
  static Transaction fromEnvelopeXdrString(String envelope) {
    Uint8List bytes = base64Decode(envelope);

    XdrTransactionEnvelope transactionEnvelope =
        XdrTransactionEnvelope.decode(XdrDataInputStream(bytes));
    return fromEnvelopeXdr(transactionEnvelope);
  }

  ///Creates a <code>Transaction</code> instance from previously build <code>TransactionEnvelope</code>
  static Transaction fromEnvelopeXdr(XdrTransactionEnvelope envelope) {
    XdrTransaction tx = envelope.tx;
    int mFee = tx.fee.uint32;
    KeyPair mSourceAccount =
        KeyPair.fromXdrPublicKey(tx.sourceAccount.accountID);
    int mSequenceNumber = tx.seqNum.sequenceNumber.int64;
    Memo mMemo = Memo.fromXdr(tx.memo);
    TimeBounds mTimeBounds = TimeBounds.fromXdr(tx.timeBounds);

    List<Operation> mOperations = List<Operation>(tx.operations.length);
    for (int i = 0; i < tx.operations.length; i++) {
      mOperations[i] = Operation.fromXdr(tx.operations[i]);
    }

    Transaction transaction = Transaction(
        mSourceAccount, mFee, mSequenceNumber, mOperations, mMemo, mTimeBounds);

    for (XdrDecoratedSignature signature in envelope.signatures) {
      transaction._mSignatures.add(signature);
    }

    return transaction;
  }

  ///Generates TransactionEnvelope XDR object. Transaction need to have at least one signature.
  XdrTransactionEnvelope toEnvelopeXdr({bool allowZeroSigners = false}) {
    if (_mSignatures.length == 0 && !allowZeroSigners) {
      throw Exception(
          "Transaction must be signed by at least one signer. Use transaction.sign().");
    }

    XdrTransactionEnvelope xdrTe = XdrTransactionEnvelope();
    XdrTransaction transaction = this.toXdr();
    xdrTe.tx = transaction;

    List<XdrDecoratedSignature> signatures = List<XdrDecoratedSignature>();
    signatures.addAll(_mSignatures);
    xdrTe.signatures = signatures;
    return xdrTe;
  }

  ///Returns base64-encoded TransactionEnvelope XDR object. Transaction need to have at least one signature.
  String toEnvelopeXdrBase64({bool allowZeroSigners = false}) {
    XdrTransactionEnvelope envelope = this.toEnvelopeXdr(allowZeroSigners: allowZeroSigners);
    XdrDataOutputStream xdrOutputStream = XdrDataOutputStream();
    XdrTransactionEnvelope.encode(xdrOutputStream, envelope);
    return base64Encode(xdrOutputStream.bytes);
  }

  ///Builds a new Transaction object.
  static TransactionBuilder Builder(TransactionBuilderAccount sourceAccount) {
    return TransactionBuilder(sourceAccount);
  }
}

///Builds a Transaction object.
class TransactionBuilder {
  TransactionBuilderAccount _mSourceAccount;
  Memo _mMemo;
  TimeBounds _mTimeBounds;
  List<Operation> _mOperations;

  int get operationsCount => _mOperations.length;

  ///Construct a transaction builder.
  TransactionBuilder(TransactionBuilderAccount sourceAccount) {
    checkNotNull(sourceAccount, "sourceAccount cannot be null");
    _mSourceAccount = sourceAccount;
    _mOperations = List<Operation>();
  }

  ///Adds a <a href="https://www.stellar.org/developers/learn/concepts/list-of-operations.html" target="_blank">operation</a> to this transaction.
  TransactionBuilder addOperation(Operation operation) {
    checkNotNull(operation, "operation cannot be null");
    _mOperations.add(operation);
    return this;
  }

  ///Adds a <a href="https://www.stellar.org/developers/learn/concepts/transactions.html" target="_blank">memo</a> to this transaction.
  TransactionBuilder addMemo(Memo memo) {
    if (_mMemo != null) {
      throw Exception("Memo has been already added.");
    }
    checkNotNull(memo, "memo cannot be null");
    _mMemo = memo;
    return this;
  }

  ///Adds a <a href="https://www.stellar.org/developers/learn/concepts/transactions.html" target="_blank">time-bounds</a> to this transaction.
  TransactionBuilder addTimeBounds(TimeBounds timeBounds) {
    if (_mTimeBounds != null) {
      throw Exception("TimeBounds has been already added.");
    }
    checkNotNull(timeBounds, "timeBounds cannot be null");
    _mTimeBounds = timeBounds;
    return this;
  }

  ///Builds a transaction. It will increment sequence number of the source account.
  Transaction build() {
    List<Operation> operations = List<Operation>();
    operations.addAll(_mOperations);
    Transaction transaction = Transaction(
        _mSourceAccount.keypair,
        operations.length * Transaction.BASE_FEE,
        _mSourceAccount.incrementedSequenceNumber,
        operations,
        _mMemo,
        _mTimeBounds);
    // Increment sequence number when there were no exceptions when creating a transaction
    _mSourceAccount.incrementSequenceNumber();
    return transaction;
  }
}
