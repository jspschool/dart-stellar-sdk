import 'xdr/xdr_enum.dart';
import 'key_pair.dart';
import 'transaction.dart';
import 'util.dart';

///Account Flags is the <code>enum</code> that can be used in SetOptionsOperation.
class AccountFlag {
  final _value;
  const AccountFlag._internal(this._value);
  toString() => 'AccountFlag.$_value';
  AccountFlag(this._value);
  get value => this._value;

  ///Authorization required (0x1): Requires the issuing account to give other accounts permission before they can hold the issuing account’s credit.
  static final AUTH_REQUIRED_FLAG = AccountFlag._internal(XdrAccountFlags.AUTH_REQUIRED_FLAG.value);
  ///Authorization revocable (0x2): Allows the issuing account to revoke its credit held by other accounts.
  static final AUTH_REVOCABLE_FLAG = AccountFlag._internal(XdrAccountFlags.AUTH_REVOCABLE_FLAG.value);
  ///Authorization immutable (0x4): If this is set then none of the authorization flags can be set and the account can never be deleted.
  static final AUTH_IMMUTABLE_FLAG = AccountFlag._internal(XdrAccountFlags.AUTH_IMMUTABLE_FLAG.value);

}

///Represents an account in Stellar network with it's sequence number.
class Account implements TransactionBuilderAccount {
  KeyPair _mKeyPair;
  int _mSequenceNumber;

  Account(KeyPair keypair, int sequenceNumber) {
    _mKeyPair = checkNotNull(keypair, "keypair cannot be null");
    _mSequenceNumber = checkNotNull(sequenceNumber, "sequenceNumber cannot be null");
  }

  @override
  KeyPair get keypair => _mKeyPair;


  @override
  int get sequenceNumber => _mSequenceNumber;

  @override
  int get incrementedSequenceNumber => _mSequenceNumber + 1;

  ///Increments sequence number in this object by one.
  void incrementSequenceNumber() {
    _mSequenceNumber++;
  }
}