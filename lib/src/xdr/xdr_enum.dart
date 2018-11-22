import 'xdr_data.dart';

class XdrAccountFlags {
  final _value;
  const XdrAccountFlags._internal(this._value);
  toString() => 'AccountFlags.$_value';
  XdrAccountFlags(this._value);
  get value => this._value;

  static const AUTH_REQUIRED_FLAG = const XdrAccountFlags._internal(1);
  static const AUTH_REVOCABLE_FLAG = const XdrAccountFlags._internal(2);
  static const AUTH_IMMUTABLE_FLAG = const XdrAccountFlags._internal(4);

  static XdrAccountFlags decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 1:
        return AUTH_REQUIRED_FLAG;
      case 2:
        return AUTH_REVOCABLE_FLAG;
      case 4:
        return AUTH_IMMUTABLE_FLAG;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrAccountFlags value) {
    stream.writeInt(value.value);
  }
}

class XdrAccountMergeResultCode {
  final _value;
  const XdrAccountMergeResultCode._internal(this._value);
  toString() => 'AccountMergeResultCode.$_value';
  XdrAccountMergeResultCode(this._value);
  get value => this._value;

  static const ACCOUNT_MERGE_SUCCESS =
      const XdrAccountMergeResultCode._internal(0);
  static const ACCOUNT_MERGE_MALFORMED =
      const XdrAccountMergeResultCode._internal(-1);
  static const ACCOUNT_MERGE_NO_ACCOUNT =
      const XdrAccountMergeResultCode._internal(-2);
  static const ACCOUNT_MERGE_IMMUTABLE_SET =
      const XdrAccountMergeResultCode._internal(-3);
  static const ACCOUNT_MERGE_HAS_SUB_ENTRIES =
      const XdrAccountMergeResultCode._internal(-4);
  static const ACCOUNT_MERGE_SEQNUM_TOO_FAR =
      const XdrAccountMergeResultCode._internal(-5);
  static const ACCOUNT_MERGE_DEST_FULL =
      const XdrAccountMergeResultCode._internal(-6);

  static XdrAccountMergeResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return ACCOUNT_MERGE_SUCCESS;
      case -1:
        return ACCOUNT_MERGE_MALFORMED;
      case -2:
        return ACCOUNT_MERGE_NO_ACCOUNT;
      case -3:
        return ACCOUNT_MERGE_IMMUTABLE_SET;
      case -4:
        return ACCOUNT_MERGE_HAS_SUB_ENTRIES;
      case -5:
        return ACCOUNT_MERGE_SEQNUM_TOO_FAR;
      case -6:
        return ACCOUNT_MERGE_DEST_FULL;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrAccountMergeResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrAllowTrustResultCode {
  final _value;
  const XdrAllowTrustResultCode._internal(this._value);
  toString() => 'AllowTrustResultCode.$_value';
  XdrAllowTrustResultCode(this._value);
  get value => this._value;

  static const ALLOW_TRUST_SUCCESS = const XdrAllowTrustResultCode._internal(0);
  static const ALLOW_TRUST_MALFORMED =
      const XdrAllowTrustResultCode._internal(-1);
  static const ALLOW_TRUST_NO_TRUST_LINE =
      const XdrAllowTrustResultCode._internal(-2);
  static const ALLOW_TRUST_TRUST_NOT_REQUIRED =
      const XdrAllowTrustResultCode._internal(-3);
  static const ALLOW_TRUST_CANT_REVOKE =
      const XdrAllowTrustResultCode._internal(-4);
  static const ALLOW_TRUST_SELF_NOT_ALLOWED =
      const XdrAllowTrustResultCode._internal(-5);

  static XdrAllowTrustResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return ALLOW_TRUST_SUCCESS;
      case -1:
        return ALLOW_TRUST_MALFORMED;
      case -2:
        return ALLOW_TRUST_NO_TRUST_LINE;
      case -3:
        return ALLOW_TRUST_TRUST_NOT_REQUIRED;
      case -4:
        return ALLOW_TRUST_CANT_REVOKE;
      case -5:
        return ALLOW_TRUST_SELF_NOT_ALLOWED;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrAccountMergeResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrAssetType {
  final _value;
  const XdrAssetType._internal(this._value);
  toString() => 'AssetType.$_value';
  XdrAssetType(this._value);
  get value => this._value;

  static const ASSET_TYPE_NATIVE = const XdrAssetType._internal(0);
  static const ASSET_TYPE_CREDIT_ALPHANUM4 = const XdrAssetType._internal(1);
  static const ASSET_TYPE_CREDIT_ALPHANUM12 = const XdrAssetType._internal(2);

  static XdrAssetType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return ASSET_TYPE_NATIVE;
      case 1:
        return ASSET_TYPE_CREDIT_ALPHANUM4;
      case 2:
        return ASSET_TYPE_CREDIT_ALPHANUM12;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrAssetType value) {
    stream.writeInt(value.value);
  }
}

class XdrBucketEntryType {
  final _value;
  const XdrBucketEntryType._internal(this._value);
  toString() => 'BucketEntryType.$_value';
  XdrBucketEntryType(this._value);
  get value => this._value;

  static const LIVEENTRY = const XdrBucketEntryType._internal(0);
  static const DEADENTRY = const XdrBucketEntryType._internal(1);

  static XdrBucketEntryType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return LIVEENTRY;
      case 1:
        return DEADENTRY;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrBucketEntryType value) {
    stream.writeInt(value.value);
  }
}

class XdrBumpSequenceResultCode {
  final _value;
  const XdrBumpSequenceResultCode._internal(this._value);
  toString() => 'BumpSequenceResultCode.$_value';
  XdrBumpSequenceResultCode(this._value);
  get value => this._value;

  static const BUMP_SEQUENCE_SUCCESS =
      const XdrBumpSequenceResultCode._internal(0);
  static const BUMP_SEQUENCE_BAD_SEQ =
      const XdrBumpSequenceResultCode._internal(-1);

  static XdrBumpSequenceResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return BUMP_SEQUENCE_SUCCESS;
      case -1:
        return BUMP_SEQUENCE_BAD_SEQ;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrBumpSequenceResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrChangeTrustResultCode {
  final _value;
  const XdrChangeTrustResultCode._internal(this._value);
  toString() => 'ChangeTrustResultCode.$_value';
  XdrChangeTrustResultCode(this._value);
  get value => this._value;

  static const CHANGE_TRUST_SUCCESS =
      const XdrChangeTrustResultCode._internal(0);
  static const CHANGE_TRUST_MALFORMED =
      const XdrChangeTrustResultCode._internal(-1);
  static const CHANGE_TRUST_NO_ISSUER =
      const XdrChangeTrustResultCode._internal(-2);
  static const CHANGE_TRUST_INVALID_LIMIT =
      const XdrChangeTrustResultCode._internal(-3);
  static const CHANGE_TRUST_LOW_RESERVE =
      const XdrChangeTrustResultCode._internal(-4);
  static const CHANGE_TRUST_SELF_NOT_ALLOWED =
      const XdrChangeTrustResultCode._internal(-5);

  static XdrChangeTrustResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return CHANGE_TRUST_SUCCESS;
      case -1:
        return CHANGE_TRUST_MALFORMED;
      case -2:
        return CHANGE_TRUST_NO_ISSUER;
      case -3:
        return CHANGE_TRUST_INVALID_LIMIT;
      case -4:
        return CHANGE_TRUST_LOW_RESERVE;
      case -5:
        return CHANGE_TRUST_SELF_NOT_ALLOWED;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrChangeTrustResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrCreateAccountResultCode {
  final _value;
  const XdrCreateAccountResultCode._internal(this._value);
  toString() => 'CreateAccountResultCode.$_value';
  XdrCreateAccountResultCode(this._value);
  get value => this._value;

  static const CREATE_ACCOUNT_SUCCESS =
      const XdrCreateAccountResultCode._internal(0);
  static const CREATE_ACCOUNT_MALFORMED =
      const XdrCreateAccountResultCode._internal(-1);
  static const CREATE_ACCOUNT_UNDERFUNDED =
      const XdrCreateAccountResultCode._internal(-2);
  static const CREATE_ACCOUNT_LOW_RESERVE =
      const XdrCreateAccountResultCode._internal(-3);
  static const CREATE_ACCOUNT_ALREADY_EXIST =
      const XdrCreateAccountResultCode._internal(-4);

  static XdrCreateAccountResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return CREATE_ACCOUNT_SUCCESS;
      case -1:
        return CREATE_ACCOUNT_MALFORMED;
      case -2:
        return CREATE_ACCOUNT_UNDERFUNDED;
      case -3:
        return CREATE_ACCOUNT_LOW_RESERVE;
      case -4:
        return CREATE_ACCOUNT_ALREADY_EXIST;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrCreateAccountResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrCryptoKeyType {
  final _value;
  const XdrCryptoKeyType._internal(this._value);
  toString() => 'CryptoKeyType.$_value';
  XdrCryptoKeyType(this._value);
  get value => this._value;

  static const KEY_TYPE_ED25519 = const XdrCryptoKeyType._internal(0);
  static const KEY_TYPE_PRE_AUTH_TX = const XdrCryptoKeyType._internal(1);
  static const KEY_TYPE_HASH_X = const XdrCryptoKeyType._internal(2);

  static XdrCryptoKeyType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return KEY_TYPE_ED25519;
      case 1:
        return KEY_TYPE_PRE_AUTH_TX;
      case 2:
        return KEY_TYPE_HASH_X;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrCryptoKeyType value) {
    stream.writeInt(value.value);
  }
}

class XdrEnvelopeType {
  final _value;
  const XdrEnvelopeType._internal(this._value);
  toString() => 'EnvelopeType.$_value';
  XdrEnvelopeType(this._value);
  get value => this._value;

  static const ENVELOPE_TYPE_SCP = const XdrEnvelopeType._internal(1);
  static const ENVELOPE_TYPE_TX = const XdrEnvelopeType._internal(2);
  static const ENVELOPE_TYPE_AUTH = const XdrEnvelopeType._internal(3);

  static XdrEnvelopeType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 1:
        return ENVELOPE_TYPE_SCP;
      case 2:
        return ENVELOPE_TYPE_TX;
      case 3:
        return ENVELOPE_TYPE_AUTH;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrEnvelopeType value) {
    stream.writeInt(value.value);
  }
}

class XdrErrorCode {
  final _value;
  const XdrErrorCode._internal(this._value);
  toString() => 'ErrorCode.$_value';
  XdrErrorCode(this._value);
  get value => this._value;

  static const ERR_MISC = const XdrErrorCode._internal(0);
  static const ERR_DATA = const XdrErrorCode._internal(1);
  static const ERR_CONF = const XdrErrorCode._internal(2);
  static const ERR_AUTH = const XdrErrorCode._internal(3);
  static const ERR_LOAD = const XdrErrorCode._internal(4);

  static XdrErrorCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return ERR_MISC;
      case 1:
        return ERR_DATA;
      case 2:
        return ERR_CONF;
      case 3:
        return ERR_AUTH;
      case 4:
        return ERR_LOAD;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrErrorCode value) {
    stream.writeInt(value.value);
  }
}

class XdrInflationResultCode {
  final _value;
  const XdrInflationResultCode._internal(this._value);
  toString() => 'InflationResultCode.$_value';
  XdrInflationResultCode(this._value);
  get value => this._value;

  static const INFLATION_SUCCESS = const XdrInflationResultCode._internal(0);
  static const INFLATION_NOT_TIME = const XdrInflationResultCode._internal(-1);

  static XdrInflationResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return INFLATION_SUCCESS;
      case -1:
        return INFLATION_NOT_TIME;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrInflationResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrIPAddrType {
  final _value;
  const XdrIPAddrType._internal(this._value);
  toString() => 'IPAddrType.$_value';
  XdrIPAddrType(this._value);
  get value => this._value;

  static const IPv4 = const XdrIPAddrType._internal(0);
  static const IPv6 = const XdrIPAddrType._internal(1);

  static XdrIPAddrType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return IPv4;
      case 1:
        return IPv6;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrIPAddrType value) {
    stream.writeInt(value.value);
  }
}

class XdrLedgerEntryChangeType {
  final _value;
  const XdrLedgerEntryChangeType._internal(this._value);
  toString() => 'LedgerEntryChangeType.$_value';
  XdrLedgerEntryChangeType(this._value);
  get value => this._value;

  static const LEDGER_ENTRY_CREATED =
      const XdrLedgerEntryChangeType._internal(0);
  static const LEDGER_ENTRY_UPDATED =
      const XdrLedgerEntryChangeType._internal(1);
  static const LEDGER_ENTRY_REMOVED =
      const XdrLedgerEntryChangeType._internal(2);
  static const LEDGER_ENTRY_STATE = const XdrLedgerEntryChangeType._internal(3);

  static XdrLedgerEntryChangeType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return LEDGER_ENTRY_CREATED;
      case 1:
        return LEDGER_ENTRY_UPDATED;
      case 2:
        return LEDGER_ENTRY_REMOVED;
      case 3:
        return LEDGER_ENTRY_STATE;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrLedgerEntryChangeType value) {
    stream.writeInt(value.value);
  }
}

class XdrLedgerEntryType {
  final _value;
  const XdrLedgerEntryType._internal(this._value);
  toString() => 'LedgerEntryType.$_value';
  XdrLedgerEntryType(this._value);
  get value => this._value;

  static const ACCOUNT = const XdrLedgerEntryType._internal(0);
  static const TRUSTLINE = const XdrLedgerEntryType._internal(1);
  static const OFFER = const XdrLedgerEntryType._internal(2);
  static const DATA = const XdrLedgerEntryType._internal(3);

  static XdrLedgerEntryType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return ACCOUNT;
      case 1:
        return TRUSTLINE;
      case 2:
        return OFFER;
      case 3:
        return DATA;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrLedgerEntryType value) {
    stream.writeInt(value.value);
  }
}

class XdrLedgerUpgradeType {
  final _value;
  const XdrLedgerUpgradeType._internal(this._value);
  toString() => 'LedgerUpgradeType.$_value';
  XdrLedgerUpgradeType(this._value);
  get value => this._value;

  static const LEDGER_UPGRADE_VERSION = const XdrLedgerUpgradeType._internal(1);
  static const LEDGER_UPGRADE_BASE_FEE =
      const XdrLedgerUpgradeType._internal(2);
  static const LEDGER_UPGRADE_MAX_TX_SET_SIZE =
      const XdrLedgerUpgradeType._internal(3);
  static const LEDGER_UPGRADE_BASE_RESERVE =
      const XdrLedgerUpgradeType._internal(4);

  static XdrLedgerUpgradeType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 1:
        return LEDGER_UPGRADE_VERSION;
      case 2:
        return LEDGER_UPGRADE_BASE_FEE;
      case 3:
        return LEDGER_UPGRADE_MAX_TX_SET_SIZE;
      case 4:
        return LEDGER_UPGRADE_BASE_RESERVE;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrLedgerUpgradeType value) {
    stream.writeInt(value.value);
  }
}

class XdrManageDataResultCode {
  final _value;
  const XdrManageDataResultCode._internal(this._value);
  toString() => 'ManageDataResultCode.$_value';
  XdrManageDataResultCode(this._value);
  get value => this._value;

  static const MANAGE_DATA_SUCCESS = const XdrManageDataResultCode._internal(0);
  static const MANAGE_DATA_NOT_SUPPORTED_YET =
      const XdrManageDataResultCode._internal(-1);
  static const MANAGE_DATA_NAME_NOT_FOUND =
      const XdrManageDataResultCode._internal(-2);
  static const MANAGE_DATA_LOW_RESERVE =
      const XdrManageDataResultCode._internal(-3);
  static const MANAGE_DATA_INVALID_NAME =
      const XdrManageDataResultCode._internal(-4);

  static XdrManageDataResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return MANAGE_DATA_SUCCESS;
      case -1:
        return MANAGE_DATA_NOT_SUPPORTED_YET;
      case -2:
        return MANAGE_DATA_NAME_NOT_FOUND;
      case -3:
        return MANAGE_DATA_LOW_RESERVE;
      case -4:
        return MANAGE_DATA_INVALID_NAME;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrManageDataResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrManageOfferEffect {
  final _value;
  const XdrManageOfferEffect._internal(this._value);
  toString() => 'ManageOfferEffect.$_value';
  XdrManageOfferEffect(this._value);
  get value => this._value;

  static const MANAGE_OFFER_CREATED = const XdrManageOfferEffect._internal(0);
  static const MANAGE_OFFER_UPDATED = const XdrManageOfferEffect._internal(1);
  static const MANAGE_OFFER_DELETED = const XdrManageOfferEffect._internal(2);

  static XdrManageOfferEffect decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return MANAGE_OFFER_CREATED;
      case 1:
        return MANAGE_OFFER_UPDATED;
      case 2:
        return MANAGE_OFFER_DELETED;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrManageOfferEffect value) {
    stream.writeInt(value.value);
  }
}

class XdrManageOfferResultCode {
  final _value;
  const XdrManageOfferResultCode._internal(this._value);
  toString() => 'ManageOfferResultCode.$_value';
  XdrManageOfferResultCode(this._value);
  get value => this._value;

  static const MANAGE_OFFER_SUCCESS =
      const XdrManageOfferResultCode._internal(0);
  static const MANAGE_OFFER_MALFORMED =
      const XdrManageOfferResultCode._internal(-1);
  static const MANAGE_OFFER_SELL_NO_TRUST =
      const XdrManageOfferResultCode._internal(-2);
  static const MANAGE_OFFER_BUY_NO_TRUST =
      const XdrManageOfferResultCode._internal(-3);
  static const MANAGE_OFFER_SELL_NOT_AUTHORIZED =
      const XdrManageOfferResultCode._internal(-4);
  static const MANAGE_OFFER_BUY_NOT_AUTHORIZED =
      const XdrManageOfferResultCode._internal(-5);
  static const MANAGE_OFFER_LINE_FULL =
      const XdrManageOfferResultCode._internal(-6);
  static const MANAGE_OFFER_UNDERFUNDED =
      const XdrManageOfferResultCode._internal(-7);
  static const MANAGE_OFFER_CROSS_SELF =
      const XdrManageOfferResultCode._internal(-8);
  static const MANAGE_OFFER_SELL_NO_ISSUER =
      const XdrManageOfferResultCode._internal(-9);
  static const MANAGE_OFFER_BUY_NO_ISSUER =
      const XdrManageOfferResultCode._internal(-10);
  static const MANAGE_OFFER_NOT_FOUND =
      const XdrManageOfferResultCode._internal(-11);
  static const MANAGE_OFFER_LOW_RESERVE =
      const XdrManageOfferResultCode._internal(-12);

  static XdrManageOfferResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return MANAGE_OFFER_SUCCESS;
      case -1:
        return MANAGE_OFFER_MALFORMED;
      case -2:
        return MANAGE_OFFER_SELL_NO_TRUST;
      case -3:
        return MANAGE_OFFER_BUY_NO_TRUST;
      case -4:
        return MANAGE_OFFER_SELL_NOT_AUTHORIZED;
      case -5:
        return MANAGE_OFFER_BUY_NOT_AUTHORIZED;
      case -6:
        return MANAGE_OFFER_LINE_FULL;
      case -7:
        return MANAGE_OFFER_UNDERFUNDED;
      case -8:
        return MANAGE_OFFER_CROSS_SELF;
      case -9:
        return MANAGE_OFFER_SELL_NO_ISSUER;
      case -10:
        return MANAGE_OFFER_BUY_NO_ISSUER;
      case -11:
        return MANAGE_OFFER_NOT_FOUND;
      case -12:
        return MANAGE_OFFER_LOW_RESERVE;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrManageOfferResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrMemoType {
  final _value;
  const XdrMemoType._internal(this._value);
  toString() => 'MemoType.$_value';
  XdrMemoType(this._value);
  get value => this._value;

  static const MEMO_NONE = const XdrMemoType._internal(0);
  static const MEMO_TEXT = const XdrMemoType._internal(1);
  static const MEMO_ID = const XdrMemoType._internal(2);
  static const MEMO_HASH = const XdrMemoType._internal(3);
  static const MEMO_RETURN = const XdrMemoType._internal(4);

  static XdrMemoType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return MEMO_NONE;
      case 1:
        return MEMO_TEXT;
      case 2:
        return MEMO_ID;
      case 3:
        return MEMO_HASH;
      case 4:
        return MEMO_RETURN;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrMemoType value) {
    stream.writeInt(value.value);
  }
}

class XdrMessageType {
  final _value;
  const XdrMessageType._internal(this._value);
  toString() => 'MessageType.$_value';
  XdrMessageType(this._value);
  get value => this._value;

  static const ERROR_MSG = const XdrMessageType._internal(0);
  static const AUTH = const XdrMessageType._internal(2);
  static const DONT_HAVE = const XdrMessageType._internal(3);
  static const GET_PEERS = const XdrMessageType._internal(4);
  static const PEERS = const XdrMessageType._internal(5);
  static const GET_TX_SET = const XdrMessageType._internal(6);
  static const TX_SET = const XdrMessageType._internal(7);
  static const TRANSACTION = const XdrMessageType._internal(8);
  static const GET_SCP_QUORUMSET = const XdrMessageType._internal(9);
  static const SCP_QUORUMSET = const XdrMessageType._internal(10);
  static const SCP_MESSAGE = const XdrMessageType._internal(11);
  static const GET_SCP_STATE = const XdrMessageType._internal(12);
  static const HELLO = const XdrMessageType._internal(13);

  static XdrMessageType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return ERROR_MSG;
      case 2:
        return AUTH;
      case 3:
        return DONT_HAVE;
      case 4:
        return GET_PEERS;
      case 5:
        return PEERS;
      case 6:
        return GET_TX_SET;
      case 7:
        return TX_SET;
      case 8:
        return TRANSACTION;
      case 9:
        return GET_SCP_QUORUMSET;
      case 10:
        return SCP_QUORUMSET;
      case 11:
        return SCP_MESSAGE;
      case 12:
        return GET_SCP_STATE;
      case 13:
        return HELLO;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrMessageType value) {
    stream.writeInt(value.value);
  }
}

class XdrOfferEntryFlags {
  final _value;
  const XdrOfferEntryFlags._internal(this._value);
  toString() => 'OfferEntryFlags.$_value';
  XdrOfferEntryFlags(this._value);
  get value => this._value;

  static const PASSIVE_FLAG = const XdrOfferEntryFlags._internal(1);

  static XdrOfferEntryFlags decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 1:
        return PASSIVE_FLAG;

      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrOfferEntryFlags value) {
    stream.writeInt(value.value);
  }
}

class XdrOperationResultCode {
  final _value;
  const XdrOperationResultCode._internal(this._value);
  toString() => 'OperationResultCode.$_value';
  XdrOperationResultCode(this._value);
  get value => this._value;

  static const opINNER = const XdrOperationResultCode._internal(0);
  static const opBAD_AUTH = const XdrOperationResultCode._internal(-1);
  static const opNO_ACCOUNT = const XdrOperationResultCode._internal(-2);
  static const opNOT_SUPPORTED = const XdrOperationResultCode._internal(-3);

  static XdrOperationResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return opINNER;
      case -1:
        return opBAD_AUTH;
      case -2:
        return opNO_ACCOUNT;
      case -3:
        return opNOT_SUPPORTED;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrOperationResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrOperationType {
  final _value;
  const XdrOperationType._internal(this._value);
  toString() => 'OperationType.$_value';
  XdrOperationType(this._value);
  get value => this._value;

  static const CREATE_ACCOUNT = const XdrOperationType._internal(0);
  static const PAYMENT = const XdrOperationType._internal(1);
  static const PATH_PAYMENT = const XdrOperationType._internal(2);
  static const MANAGE_OFFER = const XdrOperationType._internal(3);
  static const CREATE_PASSIVE_OFFER = const XdrOperationType._internal(4);
  static const SET_OPTIONS = const XdrOperationType._internal(5);
  static const CHANGE_TRUST = const XdrOperationType._internal(6);
  static const ALLOW_TRUST = const XdrOperationType._internal(7);
  static const ACCOUNT_MERGE = const XdrOperationType._internal(8);
  static const INFLATION = const XdrOperationType._internal(9);
  static const MANAGE_DATA = const XdrOperationType._internal(10);
  static const BUMP_SEQUENCE = const XdrOperationType._internal(11);

  static XdrOperationType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return CREATE_ACCOUNT;
      case 1:
        return PAYMENT;
      case 2:
        return PATH_PAYMENT;
      case 3:
        return MANAGE_OFFER;
      case 4:
        return CREATE_PASSIVE_OFFER;
      case 5:
        return SET_OPTIONS;
      case 6:
        return CHANGE_TRUST;
      case 7:
        return ALLOW_TRUST;
      case 8:
        return ACCOUNT_MERGE;
      case 9:
        return INFLATION;
      case 10:
        return MANAGE_DATA;
      case 11:
        return BUMP_SEQUENCE;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrOperationType value) {
    stream.writeInt(value.value);
  }
}

class XdrPathPaymentResultCode {
  final _value;
  const XdrPathPaymentResultCode._internal(this._value);
  toString() => 'PathPaymentResultCode.$_value';
  XdrPathPaymentResultCode(this._value);
  get value => this._value;

  static const PATH_PAYMENT_SUCCESS =
      const XdrPathPaymentResultCode._internal(0);
  static const PATH_PAYMENT_MALFORMED =
      const XdrPathPaymentResultCode._internal(-1);
  static const PATH_PAYMENT_UNDERFUNDED =
      const XdrPathPaymentResultCode._internal(-2);
  static const PATH_PAYMENT_SRC_NO_TRUST =
      const XdrPathPaymentResultCode._internal(-3);
  static const PATH_PAYMENT_SRC_NOT_AUTHORIZED =
      const XdrPathPaymentResultCode._internal(-4);
  static const PATH_PAYMENT_NO_DESTINATION =
      const XdrPathPaymentResultCode._internal(-5);
  static const PATH_PAYMENT_NO_TRUST =
      const XdrPathPaymentResultCode._internal(-6);
  static const PATH_PAYMENT_NOT_AUTHORIZED =
      const XdrPathPaymentResultCode._internal(-7);
  static const PATH_PAYMENT_LINE_FULL =
      const XdrPathPaymentResultCode._internal(-8);
  static const PATH_PAYMENT_NO_ISSUER =
      const XdrPathPaymentResultCode._internal(-9);
  static const PATH_PAYMENT_TOO_FEW_OFFERS =
      const XdrPathPaymentResultCode._internal(-10);
  static const PATH_PAYMENT_OFFER_CROSS_SELF =
      const XdrPathPaymentResultCode._internal(-11);
  static const PATH_PAYMENT_OVER_SENDMAX =
      const XdrPathPaymentResultCode._internal(-12);

  static XdrPathPaymentResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return PATH_PAYMENT_SUCCESS;
      case -1:
        return PATH_PAYMENT_MALFORMED;
      case -2:
        return PATH_PAYMENT_UNDERFUNDED;
      case -3:
        return PATH_PAYMENT_SRC_NO_TRUST;
      case -4:
        return PATH_PAYMENT_SRC_NOT_AUTHORIZED;
      case -5:
        return PATH_PAYMENT_NO_DESTINATION;
      case -6:
        return PATH_PAYMENT_NO_TRUST;
      case -7:
        return PATH_PAYMENT_NOT_AUTHORIZED;
      case -8:
        return PATH_PAYMENT_LINE_FULL;
      case -9:
        return PATH_PAYMENT_NO_ISSUER;
      case -10:
        return PATH_PAYMENT_TOO_FEW_OFFERS;
      case -11:
        return PATH_PAYMENT_OFFER_CROSS_SELF;
      case -12:
        return PATH_PAYMENT_OVER_SENDMAX;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrPathPaymentResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrPaymentResultCode {
  final _value;
  const XdrPaymentResultCode._internal(this._value);
  toString() => 'PaymentResultCode.$_value';
  XdrPaymentResultCode(this._value);
  get value => this._value;

  static const PAYMENT_SUCCESS = const XdrPaymentResultCode._internal(0);
  static const PAYMENT_MALFORMED = const XdrPaymentResultCode._internal(-1);
  static const PAYMENT_UNDERFUNDED = const XdrPaymentResultCode._internal(-2);
  static const PAYMENT_SRC_NO_TRUST = const XdrPaymentResultCode._internal(-3);
  static const PAYMENT_SRC_NOT_AUTHORIZED =
      const XdrPaymentResultCode._internal(-4);
  static const PAYMENT_NO_DESTINATION =
      const XdrPaymentResultCode._internal(-5);
  static const PAYMENT_NO_TRUST = const XdrPaymentResultCode._internal(-6);
  static const PAYMENT_NOT_AUTHORIZED =
      const XdrPaymentResultCode._internal(-7);
  static const PAYMENT_LINE_FULL = const XdrPaymentResultCode._internal(-8);
  static const PAYMENT_NO_ISSUER = const XdrPaymentResultCode._internal(-9);

  static XdrPaymentResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return PAYMENT_SUCCESS;
      case -1:
        return PAYMENT_MALFORMED;
      case -2:
        return PAYMENT_UNDERFUNDED;
      case -3:
        return PAYMENT_SRC_NO_TRUST;
      case -4:
        return PAYMENT_SRC_NOT_AUTHORIZED;
      case -5:
        return PAYMENT_NO_DESTINATION;
      case -6:
        return PAYMENT_NO_TRUST;
      case -7:
        return PAYMENT_NOT_AUTHORIZED;
      case -8:
        return PAYMENT_LINE_FULL;
      case -9:
        return PAYMENT_NO_ISSUER;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrPaymentResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrPublicKeyType {
  final _value;
  const XdrPublicKeyType._internal(this._value);
  toString() => 'PublicKeyType.$_value';
  XdrPublicKeyType(this._value);
  get value => this._value;

  static const PUBLIC_KEY_TYPE_ED25519 = const XdrPublicKeyType._internal(0);

  static XdrPublicKeyType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return PUBLIC_KEY_TYPE_ED25519;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrPublicKeyType value) {
    stream.writeInt(value.value);
  }
}

class XdrSCPStatementType {
  final _value;
  const XdrSCPStatementType._internal(this._value);
  toString() => 'SCPStatementType.$_value';
  XdrSCPStatementType(this._value);
  get value => this._value;

  static const SCP_ST_PREPARE = const XdrSCPStatementType._internal(0);
  static const SCP_ST_CONFIRM = const XdrSCPStatementType._internal(1);
  static const SCP_ST_EXTERNALIZE = const XdrSCPStatementType._internal(2);
  static const SCP_ST_NOMINATE = const XdrSCPStatementType._internal(3);

  static XdrSCPStatementType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return SCP_ST_PREPARE;
      case 1:
        return SCP_ST_CONFIRM;
      case 2:
        return SCP_ST_EXTERNALIZE;
      case 3:
        return SCP_ST_NOMINATE;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrSCPStatementType value) {
    stream.writeInt(value.value);
  }
}

class XdrSetOptionsResultCode {
  final _value;
  const XdrSetOptionsResultCode._internal(this._value);
  toString() => 'SetOptionsResultCode.$_value';
  XdrSetOptionsResultCode(this._value);
  get value => this._value;

  static const SET_OPTIONS_SUCCESS = const XdrSetOptionsResultCode._internal(0);
  static const SET_OPTIONS_LOW_RESERVE =
      const XdrSetOptionsResultCode._internal(-1);
  static const SET_OPTIONS_TOO_MANY_SIGNERS =
      const XdrSetOptionsResultCode._internal(-2);
  static const SET_OPTIONS_BAD_FLAGS =
      const XdrSetOptionsResultCode._internal(-3);
  static const SET_OPTIONS_INVALID_INFLATION =
      const XdrSetOptionsResultCode._internal(-4);
  static const SET_OPTIONS_CANT_CHANGE =
      const XdrSetOptionsResultCode._internal(-5);
  static const SET_OPTIONS_UNKNOWN_FLAG =
      const XdrSetOptionsResultCode._internal(-6);
  static const SET_OPTIONS_THRESHOLD_OUT_OF_RANGE =
      const XdrSetOptionsResultCode._internal(-7);
  static const SET_OPTIONS_BAD_SIGNER =
      const XdrSetOptionsResultCode._internal(-8);
  static const SET_OPTIONS_INVALID_HOME_DOMAIN =
      const XdrSetOptionsResultCode._internal(-9);

  static XdrSetOptionsResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return SET_OPTIONS_SUCCESS;
      case -1:
        return SET_OPTIONS_LOW_RESERVE;
      case -2:
        return SET_OPTIONS_TOO_MANY_SIGNERS;
      case -3:
        return SET_OPTIONS_BAD_FLAGS;
      case -4:
        return SET_OPTIONS_INVALID_INFLATION;
      case -5:
        return SET_OPTIONS_CANT_CHANGE;
      case -6:
        return SET_OPTIONS_UNKNOWN_FLAG;
      case -7:
        return SET_OPTIONS_THRESHOLD_OUT_OF_RANGE;
      case -8:
        return SET_OPTIONS_BAD_SIGNER;
      case -9:
        return SET_OPTIONS_INVALID_HOME_DOMAIN;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrSetOptionsResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrSignerKeyType {
  final _value;
  const XdrSignerKeyType._internal(this._value);
  toString() => 'SignerKeyType.$_value';
  XdrSignerKeyType(this._value);
  get value => this._value;

  static const SIGNER_KEY_TYPE_ED25519 = const XdrSignerKeyType._internal(0);
  static const SIGNER_KEY_TYPE_PRE_AUTH_TX =
      const XdrSignerKeyType._internal(1);
  static const SIGNER_KEY_TYPE_HASH_X = const XdrSignerKeyType._internal(2);

  static XdrSignerKeyType decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return SIGNER_KEY_TYPE_ED25519;
      case 1:
        return SIGNER_KEY_TYPE_PRE_AUTH_TX;
      case 2:
        return SIGNER_KEY_TYPE_HASH_X;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrSignerKeyType value) {
    stream.writeInt(value.value);
  }
}

class XdrThresholdIndexes {
  final _value;
  const XdrThresholdIndexes._internal(this._value);
  toString() => 'ThresholdIndexes.$_value';
  XdrThresholdIndexes(this._value);
  get value => this._value;

  static const THRESHOLD_MASTER_WEIGHT = const XdrThresholdIndexes._internal(0);
  static const THRESHOLD_LOW = const XdrThresholdIndexes._internal(1);
  static const THRESHOLD_MED = const XdrThresholdIndexes._internal(2);
  static const THRESHOLD_HIGH = const XdrThresholdIndexes._internal(3);

  static XdrThresholdIndexes decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return THRESHOLD_MASTER_WEIGHT;
      case 1:
        return THRESHOLD_LOW;
      case 2:
        return THRESHOLD_MED;
      case 3:
        return THRESHOLD_HIGH;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrThresholdIndexes value) {
    stream.writeInt(value.value);
  }
}

class XdrThresholdIndices {
  final _value;
  const XdrThresholdIndices._internal(this._value);
  toString() => 'ThresholdIndices.$_value';
  XdrThresholdIndices(this._value);
  get value => this._value;

  static const THRESHOLD_MASTER_WEIGHT = const XdrThresholdIndices._internal(0);
  static const THRESHOLD_LOW = const XdrThresholdIndices._internal(1);
  static const THRESHOLD_MED = const XdrThresholdIndices._internal(2);
  static const THRESHOLD_HIGH = const XdrThresholdIndices._internal(3);

  static XdrThresholdIndices decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return THRESHOLD_MASTER_WEIGHT;
      case 1:
        return THRESHOLD_LOW;
      case 2:
        return THRESHOLD_MED;
      case 3:
        return THRESHOLD_HIGH;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrThresholdIndices value) {
    stream.writeInt(value.value);
  }
}

class XdrTransactionResultCode {
  final _value;
  const XdrTransactionResultCode._internal(this._value);
  toString() => 'TransactionResultCode.$_value';
  XdrTransactionResultCode(this._value);
  get value => this._value;

  static const txSUCCESS = const XdrTransactionResultCode._internal(0);
  static const txFAILED = const XdrTransactionResultCode._internal(-1);
  static const txTOO_EARLY = const XdrTransactionResultCode._internal(-2);
  static const txTOO_LATE = const XdrTransactionResultCode._internal(-3);
  static const txMISSING_OPERATION =
      const XdrTransactionResultCode._internal(-4);
  static const txBAD_SEQ = const XdrTransactionResultCode._internal(-5);
  static const txBAD_AUTH = const XdrTransactionResultCode._internal(-6);
  static const txINSUFFICIENT_BALANCE =
      const XdrTransactionResultCode._internal(-7);
  static const txNO_ACCOUNT = const XdrTransactionResultCode._internal(-8);
  static const txINSUFFICIENT_FEE =
      const XdrTransactionResultCode._internal(-9);
  static const txBAD_AUTH_EXTRA = const XdrTransactionResultCode._internal(-10);
  static const txINTERNAL_ERROR = const XdrTransactionResultCode._internal(-11);

  static XdrTransactionResultCode decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return txSUCCESS;
      case -1:
        return txFAILED;
      case -2:
        return txTOO_EARLY;
      case -3:
        return txTOO_LATE;
      case -4:
        return txMISSING_OPERATION;
      case -5:
        return txBAD_SEQ;
      case -6:
        return txBAD_AUTH;
      case -7:
        return txINSUFFICIENT_BALANCE;
      case -8:
        return txNO_ACCOUNT;
      case -9:
        return txINSUFFICIENT_FEE;
      case -10:
        return txBAD_AUTH_EXTRA;
      case -11:
        return txINTERNAL_ERROR;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(
      XdrDataOutputStream stream, XdrTransactionResultCode value) {
    stream.writeInt(value.value);
  }
}

class XdrTrustLineFlags {
  final _value;
  const XdrTrustLineFlags._internal(this._value);
  toString() => 'TrustLineFlags.$_value';
  XdrTrustLineFlags(this._value);
  get value => this._value;

  static const AUTHORIZED_FLAG = const XdrTrustLineFlags._internal(1);

  static XdrTrustLineFlags decode(XdrDataInputStream stream) {
    int value = stream.readInt();
    switch (value) {
      case 0:
        return AUTHORIZED_FLAG;
      default:
        throw Exception("Unknown enum value: $value");
    }
  }

  static void encode(XdrDataOutputStream stream, XdrTrustLineFlags value) {
    stream.writeInt(value.value);
  }
}
