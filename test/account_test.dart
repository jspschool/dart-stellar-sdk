import 'package:stellar/stellar.dart';

void testValues() {
  assert(1 == AccountFlag.AUTH_REQUIRED_FLAG.value);
  assert(2 == AccountFlag.AUTH_REVOCABLE_FLAG.value);
  assert(4 == AccountFlag.AUTH_IMMUTABLE_FLAG.value);
}

void testNullArguments() {
  try {
    new Account(null, 10);
    throw Exception("fail");
  } catch (e) {}

  try {
    new Account(KeyPair.random(), null);
    throw Exception("fail");
  } catch (e) {}
}

void testGetIncrementedSequenceNumber() {
  Account account = new Account(KeyPair.random(), 100);
  int incremented;
  incremented = account.incrementedSequenceNumber;
  assert(100 == account.sequenceNumber);
  assert(101 == incremented);
  incremented = account.incrementedSequenceNumber;
  assert(100 == account.sequenceNumber);
  assert(101 == incremented);
}

void testIncrementSequenceNumber() {
  Account account = new Account(KeyPair.random(), 100);
  account.incrementSequenceNumber();
  assert(account.sequenceNumber == 101);
}

void testGetters() {
  KeyPair keypair = KeyPair.random();
  Account account = new Account(keypair, 100);
  assert(account.keypair.accountId == keypair.accountId);
  assert(account.sequenceNumber == 100);
}

void main() {
  testValues();
  testNullArguments();
  testGetIncrementedSequenceNumber();
  testIncrementSequenceNumber();
  testGetters();
}
