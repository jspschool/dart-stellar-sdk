import 'xdr_type.dart';
import 'xdr_enum.dart';
import 'xdr_data.dart';
import 'xdr_other.dart';
import 'xdr_asset.dart';
import 'xdr_ledger.dart';
import 'xdr_scp.dart';
import 'xdr_transaction.dart';

class XdrAccountEntry {
  XdrAccountEntry() {}
  XdrAccountID _accountID;
  XdrAccountID get accountID => this._accountID;
  set accountID(XdrAccountID value) => this._accountID = value;

  XdrInt64 _balance;
  XdrInt64 get balance => this._balance;
  set balance(XdrInt64 value) => this._balance = value;

  XdrSequenceNumber _seqNum;
  XdrSequenceNumber get seqNum => this._seqNum;
  set seqNum(XdrSequenceNumber value) => this._seqNum = value;

  XdrUint32 _numSubEntries;
  XdrUint32 get numSubEntries => this._numSubEntries;
  set numSubEntries(XdrUint32 value) => this._numSubEntries = value;

  XdrAccountID _inflationDest;
  XdrAccountID get inflationDest => this._inflationDest;
  set inflationDest(XdrAccountID value) => this._inflationDest = value;

  XdrUint32 _flags;
  XdrUint32 get flags => this._flags;
  set flags(XdrUint32 value) => this._flags = value;

  XdrString32 _homeDomain;
  XdrString32 get homeDomain => this._homeDomain;
  set homeDomain(XdrString32 value) => this._homeDomain = value;

  XdrThresholds _thresholds;
  XdrThresholds get thresholds => this._thresholds;
  set thresholds(XdrThresholds value) => this._thresholds = value;

  List<XdrSigner> _signers;
  List<XdrSigner> get signers => this._signers;
  set signers(List<XdrSigner> value) => this._signers = value;

  XdrAccountEntryExt _ext;
  XdrAccountEntryExt get ext => this._ext;
  set ext(XdrAccountEntryExt value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrAccountEntry encodedAccountEntry) {
    XdrAccountID.encode(stream, encodedAccountEntry.accountID);
    XdrInt64.encode(stream, encodedAccountEntry.balance);
    XdrSequenceNumber.encode(stream, encodedAccountEntry.seqNum);
    XdrUint32.encode(stream, encodedAccountEntry.numSubEntries);
    if (encodedAccountEntry.inflationDest != null) {
      stream.writeInt(1);
      XdrAccountID.encode(stream, encodedAccountEntry.inflationDest);
    } else {
      stream.writeInt(0);
    }
    XdrUint32.encode(stream, encodedAccountEntry.flags);
    XdrString32.encode(stream, encodedAccountEntry.homeDomain);
    XdrThresholds.encode(stream, encodedAccountEntry.thresholds);
    int signerssize = encodedAccountEntry.signers.length;
    stream.writeInt(signerssize);
    for (int i = 0; i < signerssize; i++) {
      XdrSigner.encode(stream, encodedAccountEntry.signers[i]);
    }
    XdrAccountEntryExt.encode(stream, encodedAccountEntry.ext);
  }

  static XdrAccountEntry decode(XdrDataInputStream stream) {
    XdrAccountEntry decodedAccountEntry = XdrAccountEntry();
    decodedAccountEntry.accountID = XdrAccountID.decode(stream);
    decodedAccountEntry.balance = XdrInt64.decode(stream);
    decodedAccountEntry.seqNum = XdrSequenceNumber.decode(stream);
    decodedAccountEntry.numSubEntries = XdrUint32.decode(stream);
    int inflationDestPresent = stream.readInt();
    if (inflationDestPresent != 0) {
      decodedAccountEntry.inflationDest = XdrAccountID.decode(stream);
    }
    decodedAccountEntry.flags = XdrUint32.decode(stream);
    decodedAccountEntry.homeDomain = XdrString32.decode(stream);
    decodedAccountEntry.thresholds = XdrThresholds.decode(stream);
    int signerssize = stream.readInt();
    decodedAccountEntry.signers = List<XdrSigner>(signerssize);
    for (int i = 0; i < signerssize; i++) {
      decodedAccountEntry.signers[i] = XdrSigner.decode(stream);
    }
    decodedAccountEntry.ext = XdrAccountEntryExt.decode(stream);
    return decodedAccountEntry;
  }
}

class XdrAccountEntryExt {
  XdrAccountEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  XdrAccountEntryV1 _v1;
  XdrAccountEntryV1 get v1 => this._v1;
  set v1(XdrAccountEntryV1 value) => this._v1 = value;

  static void encode(
      XdrDataOutputStream stream, XdrAccountEntryExt encodedAccountEntryExt) {
    stream.writeInt(encodedAccountEntryExt.discriminant);
    switch (encodedAccountEntryExt.discriminant) {
      case 0:
        break;
      case 1:
        XdrAccountEntryV1.encode(stream, encodedAccountEntryExt.v1);
        break;
    }
  }

  static XdrAccountEntryExt decode(XdrDataInputStream stream) {
    XdrAccountEntryExt decodedAccountEntryExt = XdrAccountEntryExt();
    int discriminant = stream.readInt();
    decodedAccountEntryExt.discriminant = discriminant;
    switch (decodedAccountEntryExt.discriminant) {
      case 0:
        break;
      case 1:
        decodedAccountEntryExt.v1 = XdrAccountEntryV1.decode(stream);
        break;
    }
    return decodedAccountEntryExt;
  }
}

class XdrAccountEntryV1 {
  XdrAccountEntryV1() {}
  XdrLiabilities _liabilities;
  XdrLiabilities get liabilities => this._liabilities;
  set liabilities(XdrLiabilities value) => this._liabilities = value;

  XdrAccountEntryV1Ext _ext;
  XdrAccountEntryV1Ext get ext => this._ext;
  set ext(XdrAccountEntryV1Ext value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrAccountEntryV1 encodedAccountEntryV1) {
    XdrLiabilities.encode(stream, encodedAccountEntryV1.liabilities);
    XdrAccountEntryV1Ext.encode(stream, encodedAccountEntryV1.ext);
  }

  static XdrAccountEntryV1 decode(XdrDataInputStream stream) {
    XdrAccountEntryV1 decodedAccountEntryV1 = XdrAccountEntryV1();
    decodedAccountEntryV1.liabilities = XdrLiabilities.decode(stream);
    decodedAccountEntryV1.ext = XdrAccountEntryV1Ext.decode(stream);
    return decodedAccountEntryV1;
  }
}

class XdrAccountEntryV1Ext {
  XdrAccountEntryV1Ext() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream, XdrAccountEntryV1Ext encodedAccountEntryV1Ext) {
    stream.writeInt(encodedAccountEntryV1Ext.discriminant);
    switch (encodedAccountEntryV1Ext.discriminant) {
      case 0:
        break;
    }
  }

  static XdrAccountEntryV1Ext decode(XdrDataInputStream stream) {
    XdrAccountEntryV1Ext decodedAccountEntryV1Ext = XdrAccountEntryV1Ext();
    int discriminant = stream.readInt();
    decodedAccountEntryV1Ext.discriminant = discriminant;
    switch (decodedAccountEntryV1Ext.discriminant) {
      case 0:
        break;
    }
    return decodedAccountEntryV1Ext;
  }
}

class XdrBucketEntry {
  XdrBucketEntry() {}
  XdrBucketEntryType _type;
  XdrBucketEntryType get discriminant => this._type;
  set discriminant(XdrBucketEntryType value) => this._type = value;

  XdrLedgerEntry _liveEntry;
  XdrLedgerEntry get liveEntry => this._liveEntry;
  set liveEntry(XdrLedgerEntry value) => this._liveEntry = value;

  XdrLedgerKey _deadEntry;
  XdrLedgerKey get deadEntry => this._deadEntry;
  set deadEntry(XdrLedgerKey value) => this._deadEntry = value;

  static void encode(
      XdrDataOutputStream stream, XdrBucketEntry encodedBucketEntry) {
    stream.writeInt(encodedBucketEntry.discriminant.value);
    switch (encodedBucketEntry.discriminant) {
      case XdrBucketEntryType.LIVEENTRY:
        XdrLedgerEntry.encode(stream, encodedBucketEntry.liveEntry);
        break;
      case XdrBucketEntryType.DEADENTRY:
        XdrLedgerKey.encode(stream, encodedBucketEntry.deadEntry);
        break;
    }
  }

  static XdrBucketEntry decode(XdrDataInputStream stream) {
    XdrBucketEntry decodedBucketEntry = XdrBucketEntry();
    XdrBucketEntryType discriminant = XdrBucketEntryType.decode(stream);
    decodedBucketEntry.discriminant = discriminant;
    switch (decodedBucketEntry.discriminant) {
      case XdrBucketEntryType.LIVEENTRY:
        decodedBucketEntry.liveEntry = XdrLedgerEntry.decode(stream);
        break;
      case XdrBucketEntryType.DEADENTRY:
        decodedBucketEntry.deadEntry = XdrLedgerKey.decode(stream);
        break;
    }
    return decodedBucketEntry;
  }
}

class XdrDataEntry {
  XdrDataEntry() {}
  XdrAccountID _accountID;
  XdrAccountID get accountID => this._accountID;
  set accountID(XdrAccountID value) => this._accountID = value;

  XdrString64 _dataName;
  XdrString64 get dataName => this._dataName;
  set dataName(XdrString64 value) => this._dataName = value;

  XdrDataValue _dataValue;
  XdrDataValue get dataValue => this._dataValue;
  set dataValue(XdrDataValue value) => this._dataValue = value;

  XdrDataEntryExt _ext;
  XdrDataEntryExt get ext => this._ext;
  set ext(XdrDataEntryExt value) => this._ext = value;

  static void encode(XdrDataOutputStream stream, XdrDataEntry encodedDataEntry) {
    XdrAccountID.encode(stream, encodedDataEntry.accountID);
    XdrString64.encode(stream, encodedDataEntry.dataName);
    XdrDataValue.encode(stream, encodedDataEntry.dataValue);
    XdrDataEntryExt.encode(stream, encodedDataEntry.ext);
  }

  static XdrDataEntry decode(XdrDataInputStream stream) {
    XdrDataEntry decodedDataEntry = XdrDataEntry();
    decodedDataEntry.accountID = XdrAccountID.decode(stream);
    decodedDataEntry.dataName = XdrString64.decode(stream);
    decodedDataEntry.dataValue = XdrDataValue.decode(stream);
    decodedDataEntry.ext = XdrDataEntryExt.decode(stream);
    return decodedDataEntry;
  }
}

class XdrDataEntryExt {
  XdrDataEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream, XdrDataEntryExt encodedDataEntryExt) {
    stream.writeInt(encodedDataEntryExt.discriminant);
    switch (encodedDataEntryExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrDataEntryExt decode(XdrDataInputStream stream) {
    XdrDataEntryExt decodedDataEntryExt = XdrDataEntryExt();
    int discriminant = stream.readInt();
    decodedDataEntryExt.discriminant = discriminant;
    switch (decodedDataEntryExt.discriminant) {
      case 0:
        break;
    }
    return decodedDataEntryExt;
  }
}

class XdrLedgerEntry {
  XdrLedgerEntry() {}
  XdrUint32 _lastModifiedLedgerSeq;
  XdrUint32 get lastModifiedLedgerSeq => this._lastModifiedLedgerSeq;
  set lastModifiedLedgerSeq(XdrUint32 value) =>
      this._lastModifiedLedgerSeq = value;

  XdrLedgerEntryData _data;
  XdrLedgerEntryData get data => this._data;
  set data(XdrLedgerEntryData value) => this._data = value;

  XdrLedgerEntryExt _ext;
  XdrLedgerEntryExt get ext => this._ext;
  set ext(XdrLedgerEntryExt value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrLedgerEntry encodedLedgerEntry) {
    XdrUint32.encode(stream, encodedLedgerEntry.lastModifiedLedgerSeq);
    XdrLedgerEntryData.encode(stream, encodedLedgerEntry.data);
    XdrLedgerEntryExt.encode(stream, encodedLedgerEntry.ext);
  }

  static XdrLedgerEntry decode(XdrDataInputStream stream) {
    XdrLedgerEntry decodedLedgerEntry = XdrLedgerEntry();
    decodedLedgerEntry.lastModifiedLedgerSeq = XdrUint32.decode(stream);
    decodedLedgerEntry.data = XdrLedgerEntryData.decode(stream);
    decodedLedgerEntry.ext = XdrLedgerEntryExt.decode(stream);
    return decodedLedgerEntry;
  }
}

class XdrLedgerEntryData {
  XdrLedgerEntryData() {}
  XdrLedgerEntryType _type;
  XdrLedgerEntryType get discriminant => this._type;
  set discriminant(XdrLedgerEntryType value) => this._type = value;

  XdrAccountEntry _account;
  XdrAccountEntry get account => this._account;
  set account(XdrAccountEntry value) => this._account = value;

  XdrTrustLineEntry _trustLine;
  XdrTrustLineEntry get trustLine => this._trustLine;
  set trustLine(XdrTrustLineEntry value) => this._trustLine = value;

  XdrOfferEntry _offer;
  XdrOfferEntry get offer => this._offer;
  set offer(XdrOfferEntry value) => this._offer = value;

  XdrDataEntry _data;
  XdrDataEntry get data => this._data;
  set data(XdrDataEntry value) => this._data = value;

  static void encode(
      XdrDataOutputStream stream, XdrLedgerEntryData encodedLedgerEntryData) {
    stream.writeInt(encodedLedgerEntryData.discriminant.value);
    switch (encodedLedgerEntryData.discriminant) {
      case XdrLedgerEntryType.ACCOUNT:
        XdrAccountEntry.encode(stream, encodedLedgerEntryData.account);
        break;
      case XdrLedgerEntryType.TRUSTLINE:
        XdrTrustLineEntry.encode(stream, encodedLedgerEntryData.trustLine);
        break;
      case XdrLedgerEntryType.OFFER:
        XdrOfferEntry.encode(stream, encodedLedgerEntryData.offer);
        break;
      case XdrLedgerEntryType.DATA:
        XdrDataEntry.encode(stream, encodedLedgerEntryData.data);
        break;
    }
  }

  static XdrLedgerEntryData decode(XdrDataInputStream stream) {
    XdrLedgerEntryData decodedLedgerEntryData = XdrLedgerEntryData();
    XdrLedgerEntryType discriminant = XdrLedgerEntryType.decode(stream);
    decodedLedgerEntryData.discriminant = discriminant;
    switch (decodedLedgerEntryData.discriminant) {
      case XdrLedgerEntryType.ACCOUNT:
        decodedLedgerEntryData.account = XdrAccountEntry.decode(stream);
        break;
      case XdrLedgerEntryType.TRUSTLINE:
        decodedLedgerEntryData.trustLine = XdrTrustLineEntry.decode(stream);
        break;
      case XdrLedgerEntryType.OFFER:
        decodedLedgerEntryData.offer = XdrOfferEntry.decode(stream);
        break;
      case XdrLedgerEntryType.DATA:
        decodedLedgerEntryData.data = XdrDataEntry.decode(stream);
        break;
    }
    return decodedLedgerEntryData;
  }
}

class XdrLedgerEntryExt {
  XdrLedgerEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream, XdrLedgerEntryExt encodedLedgerEntryExt) {
    stream.writeInt(encodedLedgerEntryExt.discriminant);
    switch (encodedLedgerEntryExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrLedgerEntryExt decode(XdrDataInputStream stream) {
    XdrLedgerEntryExt decodedLedgerEntryExt = XdrLedgerEntryExt();
    int discriminant = stream.readInt();
    decodedLedgerEntryExt.discriminant = discriminant;
    switch (decodedLedgerEntryExt.discriminant) {
      case 0:
        break;
    }
    return decodedLedgerEntryExt;
  }
}

class XdrLedgerEntryChange {
  XdrLedgerEntryChange() {}
  XdrLedgerEntryChangeType _type;
  XdrLedgerEntryChangeType get discriminant => this._type;
  set discriminant(XdrLedgerEntryChangeType value) => this._type = value;

  XdrLedgerEntry _created;
  XdrLedgerEntry get created => this._created;
  set created(XdrLedgerEntry value) => this._created = value;

  XdrLedgerEntry _updated;
  XdrLedgerEntry get updated => this._updated;
  set updated(XdrLedgerEntry value) => this._updated = value;

  XdrLedgerKey _removed;
  XdrLedgerKey get removed => this._removed;
  set removed(XdrLedgerKey value) => this._removed = value;

  XdrLedgerEntry _state;
  XdrLedgerEntry get state => this._state;
  set state(XdrLedgerEntry value) => this._state = value;

  static void encode(
      XdrDataOutputStream stream, XdrLedgerEntryChange encodedLedgerEntryChange) {
    stream.writeInt(encodedLedgerEntryChange.discriminant.value);
    switch (encodedLedgerEntryChange.discriminant) {
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_CREATED:
        XdrLedgerEntry.encode(stream, encodedLedgerEntryChange.created);
        break;
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_UPDATED:
        XdrLedgerEntry.encode(stream, encodedLedgerEntryChange.updated);
        break;
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_REMOVED:
        XdrLedgerKey.encode(stream, encodedLedgerEntryChange.removed);
        break;
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_STATE:
        XdrLedgerEntry.encode(stream, encodedLedgerEntryChange.state);
        break;
    }
  }

  static XdrLedgerEntryChange decode(XdrDataInputStream stream) {
    XdrLedgerEntryChange decodedLedgerEntryChange = XdrLedgerEntryChange();
    XdrLedgerEntryChangeType discriminant = XdrLedgerEntryChangeType.decode(stream);
    decodedLedgerEntryChange.discriminant = discriminant;
    switch (decodedLedgerEntryChange.discriminant) {
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_CREATED:
        decodedLedgerEntryChange.created = XdrLedgerEntry.decode(stream);
        break;
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_UPDATED:
        decodedLedgerEntryChange.updated = XdrLedgerEntry.decode(stream);
        break;
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_REMOVED:
        decodedLedgerEntryChange.removed = XdrLedgerKey.decode(stream);
        break;
      case XdrLedgerEntryChangeType.LEDGER_ENTRY_STATE:
        decodedLedgerEntryChange.state = XdrLedgerEntry.decode(stream);
        break;
    }
    return decodedLedgerEntryChange;
  }
}

class XdrLedgerEntryChanges {
  List<XdrLedgerEntryChange> _ledgerEntryChanges;
  List<XdrLedgerEntryChange> get ledgerEntryChanges => this._ledgerEntryChanges;
  set ledgerEntryChanges(List<XdrLedgerEntryChange> value) =>
      this._ledgerEntryChanges = value;

  static void encode(XdrDataOutputStream stream,
      XdrLedgerEntryChanges encodedLedgerEntryChanges) {
    int LedgerEntryChangessize =
        encodedLedgerEntryChanges.ledgerEntryChanges.length;
    stream.writeInt(LedgerEntryChangessize);
    for (int i = 0; i < LedgerEntryChangessize; i++) {
      XdrLedgerEntryChange.encode(
          stream, encodedLedgerEntryChanges.ledgerEntryChanges[i]);
    }
  }

  static XdrLedgerEntryChanges decode(XdrDataInputStream stream) {
    XdrLedgerEntryChanges decodedLedgerEntryChanges = XdrLedgerEntryChanges();
    int LedgerEntryChangessize = stream.readInt();
    decodedLedgerEntryChanges.ledgerEntryChanges =
        List<XdrLedgerEntryChange>(LedgerEntryChangessize);
    for (int i = 0; i < LedgerEntryChangessize; i++) {
      decodedLedgerEntryChanges.ledgerEntryChanges[i] =
          XdrLedgerEntryChange.decode(stream);
    }
    return decodedLedgerEntryChanges;
  }
}

class XdrLedgerHeaderHistoryEntry {
  XdrLedgerHeaderHistoryEntry() {}
  XdrHash _hash;
  XdrHash get hash => this._hash;
  set hash(XdrHash value) => this._hash = value;

  XdrLedgerHeader _header;
  XdrLedgerHeader get header => this._header;
  set header(XdrLedgerHeader value) => this._header = value;

  XdrLedgerHeaderHistoryEntryExt _ext;
  XdrLedgerHeaderHistoryEntryExt get ext => this._ext;
  set ext(XdrLedgerHeaderHistoryEntryExt value) => this._ext = value;

  static void encode(XdrDataOutputStream stream,
      XdrLedgerHeaderHistoryEntry encodedLedgerHeaderHistoryEntry) {
    XdrHash.encode(stream, encodedLedgerHeaderHistoryEntry.hash);
    XdrLedgerHeader.encode(stream, encodedLedgerHeaderHistoryEntry.header);
    XdrLedgerHeaderHistoryEntryExt.encode(
        stream, encodedLedgerHeaderHistoryEntry.ext);
  }

  static XdrLedgerHeaderHistoryEntry decode(XdrDataInputStream stream) {
    XdrLedgerHeaderHistoryEntry decodedLedgerHeaderHistoryEntry =
        XdrLedgerHeaderHistoryEntry();
    decodedLedgerHeaderHistoryEntry.hash = XdrHash.decode(stream);
    decodedLedgerHeaderHistoryEntry.header = XdrLedgerHeader.decode(stream);
    decodedLedgerHeaderHistoryEntry.ext =
        XdrLedgerHeaderHistoryEntryExt.decode(stream);
    return decodedLedgerHeaderHistoryEntry;
  }
}

class XdrLedgerHeaderHistoryEntryExt {
  XdrLedgerHeaderHistoryEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(XdrDataOutputStream stream,
      XdrLedgerHeaderHistoryEntryExt encodedLedgerHeaderHistoryEntryExt) {
    stream.writeInt(encodedLedgerHeaderHistoryEntryExt.discriminant);
    switch (encodedLedgerHeaderHistoryEntryExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrLedgerHeaderHistoryEntryExt decode(XdrDataInputStream stream) {
    XdrLedgerHeaderHistoryEntryExt decodedLedgerHeaderHistoryEntryExt =
        XdrLedgerHeaderHistoryEntryExt();
    int discriminant = stream.readInt();
    decodedLedgerHeaderHistoryEntryExt.discriminant = discriminant;
    switch (decodedLedgerHeaderHistoryEntryExt.discriminant) {
      case 0:
        break;
    }
    return decodedLedgerHeaderHistoryEntryExt;
  }
}

class XdrOfferEntry {
  XdrOfferEntry() {}
  XdrAccountID _sellerID;
  XdrAccountID get sellerID => this._sellerID;
  set sellerID(XdrAccountID value) => this._sellerID = value;

  XdrUint64 _offerID;
  XdrUint64 get offerID => this._offerID;
  set offerID(XdrUint64 value) => this._offerID = value;

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

  XdrUint32 _flags;
  XdrUint32 get flags => this._flags;
  set flags(XdrUint32 value) => this._flags = value;

  XdrOfferEntryExt _ext;
  XdrOfferEntryExt get ext => this._ext;
  set ext(XdrOfferEntryExt value) => this._ext = value;

  static void encode(XdrDataOutputStream stream, XdrOfferEntry encodedOfferEntry) {
    XdrAccountID.encode(stream, encodedOfferEntry.sellerID);
    XdrUint64.encode(stream, encodedOfferEntry.offerID);
    XdrAsset.encode(stream, encodedOfferEntry.selling);
    XdrAsset.encode(stream, encodedOfferEntry.buying);
    XdrInt64.encode(stream, encodedOfferEntry.amount);
    XdrPrice.encode(stream, encodedOfferEntry.price);
    XdrUint32.encode(stream, encodedOfferEntry.flags);
    XdrOfferEntryExt.encode(stream, encodedOfferEntry.ext);
  }

  static XdrOfferEntry decode(XdrDataInputStream stream) {
    XdrOfferEntry decodedOfferEntry = XdrOfferEntry();
    decodedOfferEntry.sellerID = XdrAccountID.decode(stream);
    decodedOfferEntry.offerID = XdrUint64.decode(stream);
    decodedOfferEntry.selling = XdrAsset.decode(stream);
    decodedOfferEntry.buying = XdrAsset.decode(stream);
    decodedOfferEntry.amount = XdrInt64.decode(stream);
    decodedOfferEntry.price = XdrPrice.decode(stream);
    decodedOfferEntry.flags = XdrUint32.decode(stream);
    decodedOfferEntry.ext = XdrOfferEntryExt.decode(stream);
    return decodedOfferEntry;
  }
}

class XdrOfferEntryExt {
  XdrOfferEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream, XdrOfferEntryExt encodedOfferEntryExt) {
    stream.writeInt(encodedOfferEntryExt.discriminant);
    switch (encodedOfferEntryExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrOfferEntryExt decode(XdrDataInputStream stream) {
    XdrOfferEntryExt decodedOfferEntryExt = XdrOfferEntryExt();
    int discriminant = stream.readInt();
    decodedOfferEntryExt.discriminant = discriminant;
    switch (decodedOfferEntryExt.discriminant) {
      case 0:
        break;
    }
    return decodedOfferEntryExt;
  }
}

class XdrSCPHistoryEntry {
  XdrSCPHistoryEntry() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  XdrSCPHistoryEntryV0 _v0;
  XdrSCPHistoryEntryV0 get v0 => this._v0;
  set v0(XdrSCPHistoryEntryV0 value) => this._v0 = value;

  static void encode(
      XdrDataOutputStream stream, XdrSCPHistoryEntry encodedSCPHistoryEntry) {
    stream.writeInt(encodedSCPHistoryEntry.discriminant);
    switch (encodedSCPHistoryEntry.discriminant) {
      case 0:
        XdrSCPHistoryEntryV0.encode(stream, encodedSCPHistoryEntry.v0);
        break;
    }
  }

  static XdrSCPHistoryEntry decode(XdrDataInputStream stream) {
    XdrSCPHistoryEntry decodedSCPHistoryEntry = XdrSCPHistoryEntry();
    int discriminant = stream.readInt();
    decodedSCPHistoryEntry.discriminant = discriminant;
    switch (decodedSCPHistoryEntry.discriminant) {
      case 0:
        decodedSCPHistoryEntry.v0 = XdrSCPHistoryEntryV0.decode(stream);
        break;
    }
    return decodedSCPHistoryEntry;
  }
}

class XdrSCPHistoryEntryV0 {
  XdrSCPHistoryEntryV0() {}
  List<XdrSCPQuorumSet> _quorumSets;
  List<XdrSCPQuorumSet> get quorumSets => this._quorumSets;
  set quorumSets(List<XdrSCPQuorumSet> value) => this._quorumSets = value;

  XdrLedgerSCPMessages _ledgerMessages;
  XdrLedgerSCPMessages get ledgerMessages => this._ledgerMessages;
  set ledgerMessages(XdrLedgerSCPMessages value) => this._ledgerMessages = value;

  static void encode(
      XdrDataOutputStream stream, XdrSCPHistoryEntryV0 encodedSCPHistoryEntryV0) {
    int quorumSetssize = encodedSCPHistoryEntryV0.quorumSets.length;
    stream.writeInt(quorumSetssize);
    for (int i = 0; i < quorumSetssize; i++) {
      XdrSCPQuorumSet.encode(stream, encodedSCPHistoryEntryV0.quorumSets[i]);
    }
    XdrLedgerSCPMessages.encode(stream, encodedSCPHistoryEntryV0.ledgerMessages);
  }

  static XdrSCPHistoryEntryV0 decode(XdrDataInputStream stream) {
    XdrSCPHistoryEntryV0 decodedSCPHistoryEntryV0 = XdrSCPHistoryEntryV0();
    int quorumSetssize = stream.readInt();
    decodedSCPHistoryEntryV0.quorumSets = List<XdrSCPQuorumSet>(quorumSetssize);
    for (int i = 0; i < quorumSetssize; i++) {
      decodedSCPHistoryEntryV0.quorumSets[i] = XdrSCPQuorumSet.decode(stream);
    }
    decodedSCPHistoryEntryV0.ledgerMessages = XdrLedgerSCPMessages.decode(stream);
    return decodedSCPHistoryEntryV0;
  }
}

class XdrTransactionHistoryEntry {
  XdrTransactionHistoryEntry() {}
  XdrUint32 _ledgerSeq;
  XdrUint32 get ledgerSeq => this._ledgerSeq;
  set ledgerSeq(XdrUint32 value) => this._ledgerSeq = value;

  XdrTransactionSet _txSet;
  XdrTransactionSet get txSet => this._txSet;
  set txSet(XdrTransactionSet value) => this._txSet = value;

  XdrTransactionHistoryEntryExt _ext;
  XdrTransactionHistoryEntryExt get ext => this._ext;
  set ext(XdrTransactionHistoryEntryExt value) => this._ext = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionHistoryEntry encodedTransactionHistoryEntry) {
    XdrUint32.encode(stream, encodedTransactionHistoryEntry.ledgerSeq);
    XdrTransactionSet.encode(stream, encodedTransactionHistoryEntry.txSet);
    XdrTransactionHistoryEntryExt.encode(
        stream, encodedTransactionHistoryEntry.ext);
  }

  static XdrTransactionHistoryEntry decode(XdrDataInputStream stream) {
    XdrTransactionHistoryEntry decodedTransactionHistoryEntry =
        XdrTransactionHistoryEntry();
    decodedTransactionHistoryEntry.ledgerSeq = XdrUint32.decode(stream);
    decodedTransactionHistoryEntry.txSet = XdrTransactionSet.decode(stream);
    decodedTransactionHistoryEntry.ext =
        XdrTransactionHistoryEntryExt.decode(stream);
    return decodedTransactionHistoryEntry;
  }
}

class XdrTransactionHistoryEntryExt {
  XdrTransactionHistoryEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionHistoryEntryExt encodedTransactionHistoryEntryExt) {
    stream.writeInt(encodedTransactionHistoryEntryExt.discriminant);
    switch (encodedTransactionHistoryEntryExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrTransactionHistoryEntryExt decode(XdrDataInputStream stream) {
    XdrTransactionHistoryEntryExt decodedTransactionHistoryEntryExt =
        XdrTransactionHistoryEntryExt();
    int discriminant = stream.readInt();
    decodedTransactionHistoryEntryExt.discriminant = discriminant;
    switch (decodedTransactionHistoryEntryExt.discriminant) {
      case 0:
        break;
    }
    return decodedTransactionHistoryEntryExt;
  }
}

class XdrTransactionHistoryResultEntry {
  XdrTransactionHistoryResultEntry() {}
  XdrUint32 _ledgerSeq;
  XdrUint32 get ledgerSeq => this._ledgerSeq;
  set ledgerSeq(XdrUint32 value) => this.ledgerSeq = value;

  XdrTransactionResultSet _txResultSet;
  XdrTransactionResultSet get txResultSet => this._txResultSet;
  set txResultSet(XdrTransactionResultSet value) => this.txResultSet = value;

  XdrTransactionHistoryResultEntryExt _ext;
  XdrTransactionHistoryResultEntryExt get ext => this.ext;
  set ext(XdrTransactionHistoryResultEntryExt value) => this.ext = value;

  static void encode(XdrDataOutputStream stream,
      XdrTransactionHistoryResultEntry encodedTransactionHistoryResultEntry) {
    XdrUint32.encode(stream, encodedTransactionHistoryResultEntry.ledgerSeq);
    XdrTransactionResultSet.encode(
        stream, encodedTransactionHistoryResultEntry.txResultSet);
    XdrTransactionHistoryResultEntryExt.encode(
        stream, encodedTransactionHistoryResultEntry.ext);
  }

  static XdrTransactionHistoryResultEntry decode(XdrDataInputStream stream) {
    XdrTransactionHistoryResultEntry decodedTransactionHistoryResultEntry =
        XdrTransactionHistoryResultEntry();
    decodedTransactionHistoryResultEntry.ledgerSeq = XdrUint32.decode(stream);
    decodedTransactionHistoryResultEntry.txResultSet =
        XdrTransactionResultSet.decode(stream);
    decodedTransactionHistoryResultEntry.ext =
        XdrTransactionHistoryResultEntryExt.decode(stream);
    return decodedTransactionHistoryResultEntry;
  }
}

class XdrTransactionHistoryResultEntryExt {
  XdrTransactionHistoryResultEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(
      XdrDataOutputStream stream,
      XdrTransactionHistoryResultEntryExt
          encodedTransactionHistoryResultEntryExt) {
    stream.writeInt(encodedTransactionHistoryResultEntryExt.discriminant);
    switch (encodedTransactionHistoryResultEntryExt.discriminant) {
      case 0:
        break;
    }
  }

  static XdrTransactionHistoryResultEntryExt decode(XdrDataInputStream stream) {
    XdrTransactionHistoryResultEntryExt decodedTransactionHistoryResultEntryExt =
        XdrTransactionHistoryResultEntryExt();
    int discriminant = stream.readInt();
    decodedTransactionHistoryResultEntryExt.discriminant = discriminant;
    switch (decodedTransactionHistoryResultEntryExt.discriminant) {
      case 0:
        break;
    }
    return decodedTransactionHistoryResultEntryExt;
  }
}

class XdrTrustLineEntry {
  XdrTrustLineEntry() {}
  XdrAccountID _accountID;
  XdrAccountID get accountID => this._accountID;
  set accountID(XdrAccountID value) => this._accountID = value;

  XdrAsset _asset;
  XdrAsset get asset => this._asset;
  set asset(XdrAsset value) => this._asset = value;

  XdrInt64 _balance;
  XdrInt64 get balance => this._balance;
  set balance(XdrInt64 value) => this._balance = value;

  XdrInt64 _limit;
  XdrInt64 get limit => this._limit;
  set limit(XdrInt64 value) => this._limit = value;

  XdrUint32 _flags;
  XdrUint32 get flags => this._flags;
  set flags(XdrUint32 value) => this._flags = value;

  XdrTrustLineEntryExt _ext;
  XdrTrustLineEntryExt get ext => this._ext;
  set ext(XdrTrustLineEntryExt value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrTrustLineEntry encodedTrustLineEntry) {
    XdrAccountID.encode(stream, encodedTrustLineEntry.accountID);
    XdrAsset.encode(stream, encodedTrustLineEntry.asset);
    XdrInt64.encode(stream, encodedTrustLineEntry.balance);
    XdrInt64.encode(stream, encodedTrustLineEntry.limit);
    XdrUint32.encode(stream, encodedTrustLineEntry.flags);
    XdrTrustLineEntryExt.encode(stream, encodedTrustLineEntry.ext);
  }

  static XdrTrustLineEntry decode(XdrDataInputStream stream) {
    XdrTrustLineEntry decodedTrustLineEntry = XdrTrustLineEntry();
    decodedTrustLineEntry.accountID = XdrAccountID.decode(stream);
    decodedTrustLineEntry.asset = XdrAsset.decode(stream);
    decodedTrustLineEntry.balance = XdrInt64.decode(stream);
    decodedTrustLineEntry.limit = XdrInt64.decode(stream);
    decodedTrustLineEntry.flags = XdrUint32.decode(stream);
    decodedTrustLineEntry.ext = XdrTrustLineEntryExt.decode(stream);
    return decodedTrustLineEntry;
  }
}

class XdrTrustLineEntryExt {
  XdrTrustLineEntryExt() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  XdrTrustLineEntryV1 _v1;
  XdrTrustLineEntryV1 get v1 => this._v1;
  set v1(XdrTrustLineEntryV1 value) => this._v1 = value;

  static void encode(
      XdrDataOutputStream stream, XdrTrustLineEntryExt encodedTrustLineEntryExt) {
    stream.writeInt(encodedTrustLineEntryExt.discriminant);
    switch (encodedTrustLineEntryExt.discriminant) {
      case 0:
        break;
      case 1:
        XdrTrustLineEntryV1.encode(stream, encodedTrustLineEntryExt.v1);
        break;
    }
  }

  static XdrTrustLineEntryExt decode(XdrDataInputStream stream) {
    XdrTrustLineEntryExt decodedTrustLineEntryExt = XdrTrustLineEntryExt();
    int discriminant = stream.readInt();
    decodedTrustLineEntryExt.discriminant = discriminant;
    switch (decodedTrustLineEntryExt.discriminant) {
      case 0:
        break;
      case 1:
        decodedTrustLineEntryExt.v1 = XdrTrustLineEntryV1.decode(stream);
        break;
    }
    return decodedTrustLineEntryExt;
  }
}

class XdrTrustLineEntryV1 {
  XdrTrustLineEntryV1() {}
  XdrLiabilities _liabilities;
  XdrLiabilities get liabilities => this._liabilities;
  set liabilities(XdrLiabilities value) => this._liabilities = value;

  XdrTrustLineEntryV1Ext _ext;
  XdrTrustLineEntryV1Ext get ext => this._ext;
  set ext(XdrTrustLineEntryV1Ext value) => this._ext = value;

  static void encode(
      XdrDataOutputStream stream, XdrTrustLineEntryV1 encodedTrustLineEntryV1) {
    XdrLiabilities.encode(stream, encodedTrustLineEntryV1.liabilities);
    XdrTrustLineEntryV1Ext.encode(stream, encodedTrustLineEntryV1.ext);
  }

  static XdrTrustLineEntryV1 decode(XdrDataInputStream stream) {
    XdrTrustLineEntryV1 decodedTrustLineEntryV1 = XdrTrustLineEntryV1();
    decodedTrustLineEntryV1.liabilities = XdrLiabilities.decode(stream);
    decodedTrustLineEntryV1.ext = XdrTrustLineEntryV1Ext.decode(stream);
    return decodedTrustLineEntryV1;
  }
}

class XdrTrustLineEntryV1Ext {
  XdrTrustLineEntryV1Ext() {}
  int _v;
  int get discriminant => this._v;
  set discriminant(int value) => this._v = value;

  static void encode(XdrDataOutputStream stream,
      XdrTrustLineEntryV1Ext encodedTrustLineEntryV1Ext) {
    stream.writeInt(encodedTrustLineEntryV1Ext.discriminant);
    switch (encodedTrustLineEntryV1Ext.discriminant) {
      case 0:
        break;
    }
  }

  static XdrTrustLineEntryV1Ext decode(XdrDataInputStream stream) {
    XdrTrustLineEntryV1Ext decodedTrustLineEntryV1Ext = XdrTrustLineEntryV1Ext();
    int discriminant = stream.readInt();
    decodedTrustLineEntryV1Ext.discriminant = discriminant;
    switch (decodedTrustLineEntryV1Ext.discriminant) {
      case 0:
        break;
    }
    return decodedTrustLineEntryV1Ext;
  }
}
