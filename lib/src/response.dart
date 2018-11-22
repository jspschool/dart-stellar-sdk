import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'assets.dart';
import 'key_pair.dart';
import 'memo.dart';
import 'operation.dart';
import 'request.dart';
import 'response_effects.dart';
import 'response_operations.dart';
import 'transaction.dart';
import 'util.dart';
import 'xdr/xdr_enum.dart';
import 'xdr/xdr_data.dart';
import 'xdr/xdr_operation.dart';
import 'xdr/xdr_transaction.dart';

String serializeNull(dynamic src) {
  return null;
}

int convertInt(var src) {
  if (src == null) return null;
  if (src is int) return src;
  if (src is String) return int.parse(src);
  throw Exception("Not integer");
}

///Represents links in responses.
class Link {
  String href;
  bool templated;

  Link(this.href, this.templated);

  factory Link.fromJson(Map<String, dynamic> json) {
    return new Link(json['href'] as String, json['templated'] as bool);
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'href': href, 'templated': templated};
}

abstract class Response {
  int rateLimitLimit;
  int rateLimitRemaining;
  int rateLimitReset;

  void setHeaders(Map<String, String> headers) {
    if (headers["X-Ratelimit-Limit"] != null) {
      this.rateLimitLimit = int.parse(headers["X-Ratelimit-Limit"]);
    }
    if (headers["X-Ratelimit-Remaining"] != null) {
      this.rateLimitRemaining = int.parse(headers["X-Ratelimit-Remaining"]);
    }
    if (headers["X-Ratelimit-Reset"] != null) {
      this.rateLimitReset = int.parse(headers["X-Ratelimit-Reset"]);
    }
  }
}

///Links connected to transaction.
class ResponseLinks {
  Link account;
  Link effects;
  Link ledger;
  Link operations;
  Link precedes;
  Link self;
  Link succeeds;

  ResponseLinks(this.account, this.effects, this.ledger, this.operations,
      this.precedes, this.self, this.succeeds);

  factory ResponseLinks.fromJson(Map<String, dynamic> json) {
    return new ResponseLinks(
        json['account'] == null
            ? null
            : new Link.fromJson(json['account'] as Map<String, dynamic>),
        json['effects'] == null
            ? null
            : new Link.fromJson(json['effects'] as Map<String, dynamic>),
        json['ledger'] == null
            ? null
            : new Link.fromJson(json['ledger'] as Map<String, dynamic>),
        json['operations'] == null
            ? null
            : new Link.fromJson(json['operations'] as Map<String, dynamic>),
        json['precedes'] == null
            ? null
            : new Link.fromJson(json['precedes'] as Map<String, dynamic>),
        json['self'] == null
            ? null
            : new Link.fromJson(json['self'] as Map<String, dynamic>),
        json['succeeds'] == null
            ? null
            : new Link.fromJson(json['succeeds'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'account': account,
        'effects': effects,
        'ledger': ledger,
        'operations': operations,
        'precedes': precedes,
        'self': self,
        'succeeds': succeeds
      };
}

///Represents transaction response.
class TransactionResponse extends Response {
  String hash;
  int ledger;
  String createdAt;
  KeyPair sourceAccount;
  String pagingToken;
  int sourceAccountSequence;
  int feePaid;
  int operationCount;
  String envelopeXdr;
  String resultXdr;
  String resultMetaXdr;
  Memo _memo;
  ResponseLinks links;

  TransactionResponse(
      this.hash,
      this.ledger,
      this.createdAt,
      this.sourceAccount,
      this.pagingToken,
      this.sourceAccountSequence,
      this.feePaid,
      this.operationCount,
      this.envelopeXdr,
      this.resultXdr,
      this.resultMetaXdr,
      this._memo,
      this.links);

  Memo get memo => _memo;
  set memo(Memo memo) {
    memo = checkNotNull(memo, "memo cannot be null");
    if (this._memo != null) {
      throw new Exception("Memo has been already set.");
    }
    this._memo = memo;
  }

  factory TransactionResponse.fromJson(Map<String, dynamic> json) {
    return new TransactionResponse(
        json['hash'] as String,
        convertInt(json['ledger']),
        json['created_at'] as String,
        json['source_account'] == null
            ? null
            : KeyPair.fromAccountId(json['source_account'] as String),
        json['paging_token'] as String,
        convertInt(json['source_account_sequence']),
        convertInt(json['fee_paid']),
        convertInt(json['operation_count']),
        json['envelope_xdr'] as String,
        json['result_xdr'] as String,
        json['result_meta_xdr'] as String,
        Memo.fromJson(json),
        json['_links'] == null
            ? null
            : new ResponseLinks.fromJson(
                json['_links'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'source_account': null,
        'memo': null,
        '_links': links,
        'hash': hash,
        'ledger': ledger,
        'create_at': createdAt,
        'paging_token': pagingToken,
        'source_account_sequence': sourceAccountSequence,
        'fee_paid': feePaid,
        'operation_count': operationCount,
        'envelope_xdr': envelopeXdr,
        'result_xdr': resultXdr,
        'result_meta_xdr': resultMetaXdr
      };
}

///Represents account thresholds.
class Thresholds {
  int lowThreshold;
  int medThreshold;
  int highThreshold;

  Thresholds(this.lowThreshold, this.medThreshold, this.highThreshold);

  factory Thresholds.fromJson(Map<String, dynamic> json) {
    return new Thresholds(convertInt(json['low_threshold']),
        convertInt(json['med_threshold']), convertInt(json['high_threshold']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'low_threshold': lowThreshold,
        'med_threshold': medThreshold,
        'high_threshold': highThreshold
      };
}

///Represents account flags.
class Flags {
  bool authRequired;
  bool authRevocable;
  bool authImmutable;

  Flags(this.authRequired, this.authRevocable, this.authImmutable);

  factory Flags.fromJson(Map<String, dynamic> json) {
    return new Flags(json['auth_required'] as bool,
        json['auth_revocable'] as bool, json['auth_immutable'] as bool);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'auth_required': authRequired,
        'auth_revocable': authRevocable,
        'auth_immutable': authImmutable
      };
}

///Represents account balance.
class Balance {
  String assetType;
  String assetCode;
  String _assetIssuer;
  String limit;
  String balance;
  String buyingLiabilities;
  String sellingLiabilities;

  Balance(this.assetType, this.assetCode, this._assetIssuer, this.balance,
      this.limit, this.buyingLiabilities, this.sellingLiabilities);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      return Asset.createNonNativeAsset(assetCode, assetIssuer);
    }
  }

  KeyPair get assetIssuer => KeyPair.fromAccountId(_assetIssuer);

  factory Balance.fromJson(Map<String, dynamic> json) {
    return new Balance(
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String,
        json['balance'] as String,
        json['limit'] as String,
        json['buying_liabilities'] as String,
        json['selling_liabilities'] as String);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'asset_type': assetType,
        'asset_code': assetCode,
        'asset_issuer': assetIssuer,
        'limit': limit,
        'balance': balance,
        'buying_liabilities': buyingLiabilities,
        'selling_liabilities': sellingLiabilities
      };
}

///Represents account signers.
class Signer {
  String key;
  String type;
  int weight;

  Signer(this.key, this.type, this.weight);

  String get accountId => key;

  factory Signer.fromJson(Map<String, dynamic> json) {
    return new Signer(json['key'] as String, json['type'] as String,
        convertInt(json['weight']));
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'key': key, 'weight': weight, 'type': type};
}

///Data connected to account.
class AccountResponseData {
  Map<String, dynamic> _map = {};

  AccountResponseData(this._map);

  int get length => _map.length;

  Iterable<String> get keys => _map.keys;

  ///Gets base64-encoded value for a given key.
  String operator [](Object key) => _map[key] as String;

  ///Gets raw value for a given key.
  Uint8List getDecoded(String key) {
    return base64Decode(this[key]);
  }
}

///Links connected to account.
class AccountResponseLinks {
  Link effects;
  Link offers;
  Link operations;
  Link self;
  Link transactions;

  AccountResponseLinks(
      this.effects, this.offers, this.operations, this.self, this.transactions);

  factory AccountResponseLinks.fromJson(Map<String, dynamic> json) {
    return new AccountResponseLinks(
        json['effects'] == null
            ? null
            : new Link.fromJson(json['effects'] as Map<String, dynamic>),
        json['offers'] == null
            ? null
            : new Link.fromJson(json['offers'] as Map<String, dynamic>),
        json['operations'] == null
            ? null
            : new Link.fromJson(json['operations'] as Map<String, dynamic>),
        json['self'] == null
            ? null
            : new Link.fromJson(json['self'] as Map<String, dynamic>),
        json['transactions'] == null
            ? null
            : new Link.fromJson(json['transactions'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'effects': effects,
        'offers': offers,
        'operations': operations,
        'self': self,
        'transactions': transactions
      };
}

///Represents account response.
class AccountResponse extends Response implements TransactionBuilderAccount {
  KeyPair _keypair;
  int _sequenceNumber;
  String pagingToken;
  int subentryCount;
  String inflationDestination;
  String homeDomain;
  Thresholds thresholds;
  Flags flags;
  List<Balance> balances;
  List<Signer> signers;
  AccountResponseData data;
  AccountResponseLinks links;

  AccountResponse(
      this._keypair,
      this._sequenceNumber,
      this.pagingToken,
      this.subentryCount,
      this.inflationDestination,
      this.homeDomain,
      this.thresholds,
      this.flags,
      this.balances,
      this.signers,
      this.data,
      this.links);

  @override
  KeyPair get keypair => _keypair;
  @override
  int get sequenceNumber => _sequenceNumber;
  @override
  int get incrementedSequenceNumber => _sequenceNumber + 1;
  @override
  void incrementSequenceNumber() => _sequenceNumber++;

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return new AccountResponse(
        json['account_id'] == null
            ? null
            : KeyPair.fromAccountId(json['account_id'] as String),
        convertInt(json['sequence']),
        json['paging_token'] as String,
        convertInt(json['subentry_count']),
        json['inflation_destination'] as String,
        json['home_domain'] as String,
        json['thresholds'] == null
            ? null
            : new Thresholds.fromJson(
                json['thresholds'] as Map<String, dynamic>),
        json['flags'] == null
            ? null
            : new Flags.fromJson(json['flags'] as Map<String, dynamic>),
        (json['balances'] as List)
            ?.map((e) => e == null
                ? null
                : new Balance.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        (json['signers'] as List)
            ?.map((e) => e == null
                ? null
                : new Signer.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        json['data'] == null
            ? null
            : new AccountResponseData(json['data'] as Map<String, dynamic>),
        json['_links'] == null
            ? null
            : new AccountResponseLinks.fromJson(
                json['_links'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'account_id': null,
        'sequence': _sequenceNumber,
        'paging_token': pagingToken,
        'subentry_count': subentryCount,
        'inflation_destination': inflationDestination,
        'home_domain': homeDomain,
        'thresholds': thresholds,
        'flags': flags,
        'balances': balances,
        'signers': signers,
        'data': data,
        '_links': links
      };
}

///Links connected to asset.
class AssetResponseLinks {
  Link toml;

  AssetResponseLinks(this.toml);

  factory AssetResponseLinks.fromJson(Map<String, dynamic> json) {
    return new AssetResponseLinks(json['toml'] == null
        ? null
        : new Link.fromJson(json['toml'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'toml': toml};
}

///Represents asset response.
class AssetResponse extends Response {
  String assetType;
  String assetCode;
  String assetIssuer;
  String pagingToken;
  String amount;
  int numAccounts;
  Flags flags;
  AssetResponseLinks links;

  AssetResponse(this.assetType, this.assetCode, this.assetIssuer,
      this.pagingToken, this.amount, this.numAccounts, this.flags, this.links);

  Asset get asset {
    return Asset.create(this.assetType, this.assetCode, this.assetIssuer);
  }

  factory AssetResponse.fromJson(Map<String, dynamic> json) {
    return new AssetResponse(
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String,
        json['paging_token'] as String,
        json['amount'] as String,
        convertInt(json['num_accounts']),
        json['flags'] == null
            ? null
            : new Flags.fromJson(json['flags'] as Map<String, dynamic>),
        json['_links'] == null
            ? null
            : new AssetResponseLinks.fromJson(
                json['_links'] as Map<String, dynamic>))
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'asset_type': assetType,
        'asset_code': assetCode,
        'asset_issuer': assetIssuer,
        'paging_token': pagingToken,
        'amount': amount,
        'num_accounts': numAccounts,
        'flags': flags,
        '_links': links
      };
}

///Links connected to ledger.
class LedgerResponseLinks {
  Link effects;
  Link operations;
  Link self;
  Link transactions;

  LedgerResponseLinks(
      this.effects, this.operations, this.self, this.transactions);

  factory LedgerResponseLinks.fromJson(Map<String, dynamic> json) {
    return new LedgerResponseLinks(
        json['effects'] == null
            ? null
            : new Link.fromJson(json['effects'] as Map<String, dynamic>),
        json['operations'] == null
            ? null
            : new Link.fromJson(json['operations'] as Map<String, dynamic>),
        json['self'] == null
            ? null
            : new Link.fromJson(json['self'] as Map<String, dynamic>),
        json['transactions'] == null
            ? null
            : new Link.fromJson(json['transactions'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'effects': effects,
        'operations': operations,
        'self': self,
        'transactions': transactions
      };
}

///Represents ledger response.
class LedgerResponse extends Response {
  int sequence;
  String hash;
  String pagingToken;
  String prevHash;
  int transactionCount;
  int operationCount;
  String closedAt;
  String totalCoins;
  String feePool;
  int baseFee;
  String baseReserve;
  String baseFeeInStroops;
  String baseReserveInStroops;
  int maxTxSetSize;
  int protocolVersion;
  String headerXdr;
  LedgerResponseLinks links;

  LedgerResponse(
      this.sequence,
      this.hash,
      this.pagingToken,
      this.prevHash,
      this.transactionCount,
      this.operationCount,
      this.closedAt,
      this.totalCoins,
      this.feePool,
      this.baseFee,
      this.baseFeeInStroops,
      this.baseReserve,
      this.baseReserveInStroops,
      this.maxTxSetSize,
      this.protocolVersion,
      this.headerXdr,
      this.links);

  factory LedgerResponse.fromJson(Map<String, dynamic> json) {
    return new LedgerResponse(
        convertInt(json['sequence']),
        json['hash'] as String,
        json['paging_token'] as String,
        json['prev_hash'] as String,
        convertInt(json['transaction_count']),
        convertInt(json['operation_count']),
        json['closed_at'] as String,
        json['total_coins'] as String,
        json['fee_pool'] as String,
        convertInt(json['base_fee']),
        json['base_fee_in_stroops'] as String,
        json['base_reserve'] as String,
        json['base_reserve_in_stroops'] as String,
        convertInt(json['max_tx_set_size']),
        convertInt(json['protocol_version']),
        json['header_xdr'] as String,
        json['_links'] == null
            ? null
            : new LedgerResponseLinks.fromJson(
                json['_links'] as Map<String, dynamic>))
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'sequence': sequence,
        'hash': hash,
        'paging_token': pagingToken,
        'prev_hash': prevHash,
        'transaction_count': transactionCount,
        'operation_count': operationCount,
        'closed_at': closedAt,
        'total_coins': totalCoins,
        'fee_pool': feePool,
        'base_fee': baseFee,
        'base_reserve': baseReserve,
        'base_fee_in_stroops': baseFeeInStroops,
        'base_reserve_in_stroops': baseReserveInStroops,
        'max_tx_set_size': maxTxSetSize,
        'protocol_version': protocolVersion,
        'header_xdr': headerXdr,
        '_links': links
      };
}

///Links connected to ledger.
class OfferResponseLinks {
  Link self;
  Link offerMaker;

  OfferResponseLinks(this.self, this.offerMaker);

  factory OfferResponseLinks.fromJson(Map<String, dynamic> json) {
    return new OfferResponseLinks(
        json['self'] == null
            ? null
            : new Link.fromJson(json['self'] as Map<String, dynamic>),
        json['offer_maker'] == null
            ? null
            : new Link.fromJson(json['offer_maker'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'self': self, 'offer_maker': offerMaker};
}

///Represents offer response.
class OfferResponse extends Response {
  int id;
  String pagingToken;
  KeyPair seller;
  Asset selling;
  Asset buying;
  String amount;
  String price;
  OfferResponseLinks links;

  OfferResponse(this.id, this.pagingToken, this.seller, this.selling,
      this.buying, this.amount, this.price, this.links);

  factory OfferResponse.fromJson(Map<String, dynamic> json) {
    return new OfferResponse(
        convertInt(json['id']),
        json['paging_token'] as String,
        json['seller'] == null
            ? null
            : KeyPair.fromAccountId(json['seller'] as String),
        json['selling'] == null
            ? null
            : Asset.fromJson(json['selling'] as Map<String, dynamic>),
        json['buying'] == null
            ? null
            : Asset.fromJson(json['buying'] as Map<String, dynamic>),
        json['amount'] as String,
        json['price'] as String,
        json['_links'] == null
            ? null
            : new OfferResponseLinks.fromJson(
                json['_links'] as Map<String, dynamic>))
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'id': id,
        'paging_token': pagingToken,
        'seller': null,
        'selling': null,
        'buying': null,
        'amount': amount,
        'price': price,
        '_links': links
      };
}

///Represents fee stats response.
class OperationFeeStatsResponse extends Response {
  int min;
  int mode;
  int lastLedgerBaseFee;
  int lastLedger;

  OperationFeeStatsResponse(
      int min, int mode, int lastLedgerBaseFee, int lastLedger);

  factory OperationFeeStatsResponse.fromJson(Map<String, dynamic> json) {
    return new OperationFeeStatsResponse(
        convertInt(json['min_accepted_fee']),
        convertInt(json['mode_accepted_fee']),
        convertInt(json['last_ledger_base_fee']),
        convertInt(json['last_ledger']));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'min_accepted_fee': min,
        'mode_accepted_fee': mode,
        'last_ledger_base_fee': lastLedgerBaseFee,
        'last_ledger': lastLedger
      };
}

///Represents order book row.
class Row {
  String amount;
  String price;
  Price priceR;

  Row(String amount, String price, Price priceR) {
    this.amount = checkNotNull(amount, "amount cannot be null");
    this.price = checkNotNull(price, "price cannot be null");
    this.priceR = checkNotNull(priceR, "priceR cannot be null");
  }

  factory Row.fromJson(Map<String, dynamic> json) {
    return new Row(
        json['amount'] as String,
        json['price'] as String,
        json['price_r'] == null
            ? null
            : new Price.fromJson(json['price_r'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'amount': amount, 'price': price, 'price_r': priceR};
}

///Represents order book response.
class OrderBookResponse extends Response {
  Asset base;
  Asset counter;
  List<Row> asks;
  List<Row> bids;

  OrderBookResponse(this.base, this.counter, this.asks, this.bids);

  factory OrderBookResponse.fromJson(Map<String, dynamic> json) {
    return new OrderBookResponse(
        json['base'] == null
            ? null
            : Asset.fromJson(json['base'] as Map<String, dynamic>),
        json['counter'] == null
            ? null
            : Asset.fromJson(json['counter'] as Map<String, dynamic>),
        (json['asks'] as List)
            ?.map((e) =>
                e == null ? null : new Row.fromJson(e as Map<String, dynamic>))
            ?.toList(),
        (json['bids'] as List)
            ?.map((e) =>
                e == null ? null : new Row.fromJson(e as Map<String, dynamic>))
            ?.toList())
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'base': null,
        'counter': null,
        'asks': asks,
        'bids': bids
      };
}

///Links connected to path.
class PathResponseLinks {
  Link self;

  PathResponseLinks(this.self);

  factory PathResponseLinks.fromJson(Map<String, dynamic> json) {
    return new PathResponseLinks(json['self'] == null
        ? null
        : new Link.fromJson(json['self'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{'self': self};
}

///Represents path response.
class PathResponse extends Response {
  String destinationAmount;
  String destinationAssetType;
  String destinationAssetCode;
  String destinationAssetIssuer;

  String sourceAmount;
  String sourceAssetType;
  String sourceAssetCode;
  String sourceAssetIssuer;

  List<Asset> path;

  PathResponseLinks links;

  PathResponse(
      this.destinationAmount,
      this.destinationAssetType,
      this.destinationAssetCode,
      this.destinationAssetIssuer,
      this.sourceAmount,
      this.sourceAssetType,
      this.sourceAssetCode,
      this.sourceAssetIssuer,
      this.path,
      this.links);

  Asset get destinationAsset {
    if (destinationAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(destinationAssetIssuer);
      return Asset.createNonNativeAsset(destinationAssetCode, issuer);
    }
  }

  Asset get sourceAsset {
    if (sourceAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(sourceAssetIssuer);
      return Asset.createNonNativeAsset(sourceAssetCode, issuer);
    }
  }

  factory PathResponse.fromJson(Map<String, dynamic> json) {
    return new PathResponse(
        json['destination_amount'] as String,
        json['destination_asset_type'] as String,
        json['destination_asset_code'] as String,
        json['destination_asset_issuer'] as String,
        json['source_amount'] as String,
        json['source_asset_type'] as String,
        json['source_asset_code'] as String,
        json['source_asset_issuer'] as String,
        json['path'] == null
            ? null
            : (json['path'] as List)
                ?.map((e) => e == null
                    ? null
                    : Asset.fromJson(e as Map<String, dynamic>))
                ?.toList(),
        json['_links'] == null
            ? null
            : new PathResponseLinks.fromJson(
                json['_links'] as Map<String, dynamic>))
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'destination_amount': destinationAmount,
        'destination_asset_type': destinationAssetType,
        'destination_asset_code': destinationAssetCode,
        'destination_asset_issuer': destinationAssetIssuer,
        'source_amount': sourceAmount,
        'source_asset_type': sourceAssetType,
        'source_asset_code': sourceAssetCode,
        'source_asset_issuer': sourceAssetIssuer,
        'path': null,
        '_links': links
      };
}

///Represents root endpoint response.
class RootResponse extends Response {
  String horizonVersion;
  String stellarCoreVersion;
  int historyLatestLedger;
  int historyElderLedger;
  int coreLatestLedger;
  String networkPassphrase;
  int protocolVersion;

  RootResponse(
      this.horizonVersion,
      this.stellarCoreVersion,
      this.historyLatestLedger,
      this.historyElderLedger,
      this.coreLatestLedger,
      this.networkPassphrase,
      this.protocolVersion);

  factory RootResponse.fromJson(Map<String, dynamic> json) {
    return new RootResponse(
        json['horizon_version'] as String,
        json['core_version'] as String,
        convertInt(json['history_latest_ledger']),
        convertInt(json['history_elder_ledger']),
        convertInt(json['core_latest_ledger']),
        json['network_passphrase'] as String,
        convertInt(json['protocol_version']))
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'horizon_version': horizonVersion,
        'core_version': stellarCoreVersion,
        'history_latest_ledger': historyLatestLedger,
        'history_elder_ledger': historyElderLedger,
        'core_latest_ledger': coreLatestLedger,
        'network_passphrase': networkPassphrase,
        'protocol_version': protocolVersion
      };
}

///Contains result codes for this transaction.
class ExtrasResultCodes {
  String transactionResultCode;
  List<String> operationsResultCodes;

  ExtrasResultCodes(this.transactionResultCode, this.operationsResultCodes);

  factory ExtrasResultCodes.fromJson(Map<String, dynamic> json) {
    return new ExtrasResultCodes(json['transaction'] as String,
        (json['operations'] as List)?.map((e) => e as String)?.toList());
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'transaction': transactionResultCode,
        'operations': operationsResultCodes
      };
}

///Additional information returned by a server.
class SubmitTransactionResponseExtras {
  String envelopeXdr;
  String resultXdr;
  ExtrasResultCodes resultCodes;

  SubmitTransactionResponseExtras(
      this.envelopeXdr, this.resultXdr, this.resultCodes);

  factory SubmitTransactionResponseExtras.fromJson(Map<String, dynamic> json) {
    return new SubmitTransactionResponseExtras(
        json['envelope_xdr'] as String,
        json['result_xdr'] as String,
        json['result_codes'] == null
            ? null
            : new ExtrasResultCodes.fromJson(
                json['result_codes'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'envelope_xdr': envelopeXdr,
        'result_xdr': resultXdr,
        'result_codes': resultCodes
      };
}

///Represents server response after submitting transaction.
class SubmitTransactionResponse extends Response {
  String hash;
  int ledger;
  String envelopeXdr_;
  String resultXdr_;
  SubmitTransactionResponseExtras extras;

  SubmitTransactionResponse(
      this.extras, this.ledger, this.hash, this.envelopeXdr_, this.resultXdr_);

  bool get success => ledger != null;

  String get envelopeXdr {
    if (this.success) {
      return this.envelopeXdr_;
    } else {
      if (this.extras != null) {
        return this.extras.envelopeXdr;
      }
      return null;
    }
  }

  String get resultXdr {
    if (this.success) {
      return this.resultXdr_;
    } else {
      if (this.extras != null) {
        return this.extras.resultXdr;
      }
      return null;
    }
  }

  ///Helper method that returns Offer ID for ManageOffer from TransactionResult Xdr.
  ///This is helpful when you need ID of an offer to update it later.
  int getOfferIdFromResult(int position) {
    if (!this.success) {
      return null;
    }

    XdrDataInputStream xdrInputStream =
        new XdrDataInputStream(base64Decode(this.resultXdr));
    XdrTransactionResult result;

    try {
      result = XdrTransactionResult.decode(xdrInputStream);
    } catch (e) {
      return null;
    }

    if (result.result.results[position] == null) {
      return null;
    }

    if ((result.result.results[position] as XdrOperationResult)
            .tr
            .discriminant !=
        XdrOperationType.MANAGE_OFFER) {
      return null;
    }

    if ((result.result.results[0] as XdrOperationResult)
            .tr
            .manageOfferResult
            .success
            .offer
            .offer ==
        null) {
      return null;
    }

    return (result.result.results[0] as XdrOperationResult)
        .tr
        .manageOfferResult
        .success
        .offer
        .offer
        .offerID
        .uint64;
  }

  factory SubmitTransactionResponse.fromJson(Map<String, dynamic> json) {
    return new SubmitTransactionResponse(
        json['extras'] == null
            ? null
            : new SubmitTransactionResponseExtras.fromJson(
                json['extras'] as Map<String, dynamic>),
        convertInt(json['ledger']),
        json['hash'] as String,
        json['envelope_xdr'] as String,
        json['result_xdr'] as String)
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'hash': hash,
        'ledger': ledger,
        'envelope_xdr': envelopeXdr_,
        'result_xdr': resultXdr_,
        'extras': extras
      };
}

class SubmitTransactionTimeoutResponseException implements Exception {
  String toString() {
    return "Timeout. Please resubmit your transaction to receive submission status. More info: https://www.stellar.org/developers/horizon/reference/errors/timeout.html";
  }
}

class SubmitTransactionUnknownResponseException implements Exception {
  int _code;
  String _body;

  SubmitTransactionUnknownResponseException(this._code, this._body);

  String toString() {
    return "Unknown response from Horizon";
  }

  int get code => _code;
  String get body => _body;
}

///Represents trade aggregation response.
class TradeAggregationResponse extends Response {
  int timestamp;
  int tradeCount;
  String baseVolume;
  String counterVolume;
  String avg;
  String high;
  String low;
  String open;
  String close;

  TradeAggregationResponse(this.timestamp, this.tradeCount, this.baseVolume,
      this.counterVolume, this.avg, this.high, this.low, this.open, this.close);

  DateTime getDate() {
    return DateTime.fromMillisecondsSinceEpoch(this.timestamp);
  }

  factory TradeAggregationResponse.fromJson(Map<String, dynamic> json) {
    return new TradeAggregationResponse(
        convertInt(json['timestamp']),
        convertInt(json['trade_count']),
        json['base_volume'] as String,
        json['counter_volume'] as String,
        json['avg'] as String,
        json['high'] as String,
        json['low'] as String,
        json['open'] as String,
        json['close'] as String)
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset']);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'timestamp': timestamp,
        'trade_count': tradeCount,
        'base_volume': baseVolume,
        'counter_volume': counterVolume,
        'avg': avg,
        'high': high,
        'low': low,
        'open': open,
        'close': close
      };
}

///Links connected to a trade.
class TradeResponseLinks {
  Link base;
  Link counter;
  Link operation;

  TradeResponseLinks(this.base, this.counter, this.operation);

  factory TradeResponseLinks.fromJson(Map<String, dynamic> json) {
    return new TradeResponseLinks(
        json['base'] == null
            ? null
            : new Link.fromJson(json['base'] as Map<String, dynamic>),
        json['counter'] == null
            ? null
            : new Link.fromJson(json['counter'] as Map<String, dynamic>),
        json['operation'] == null
            ? null
            : new Link.fromJson(json['operation'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'base': base,
        'counter': counter,
        'operation': operation
      };
}

///Represents trades response.
class TradeResponse extends Response {
  String id;
  String pagingToken;
  String ledgerCloseTime;
  String offerId;
  bool baseIsSeller;

  KeyPair baseAccount;
  String baseOfferId;
  String baseAmount;
  String baseAssetType;
  String baseAssetCode;
  String baseAssetIssuer;

  KeyPair counterAccount;
  String counterOfferId;
  String counterAmount;
  String counterAssetType;
  String counterAssetCode;
  String counterAssetIssuer;

  Price price;

  TradeResponseLinks links;

  TradeResponse(
      this.id,
      this.pagingToken,
      this.ledgerCloseTime,
      this.offerId,
      this.baseIsSeller,
      this.baseAccount,
      this.baseOfferId,
      this.baseAmount,
      this.baseAssetType,
      this.baseAssetCode,
      this.baseAssetIssuer,
      this.counterAccount,
      this.counterOfferId,
      this.counterAmount,
      this.counterAssetType,
      this.counterAssetCode,
      this.counterAssetIssuer,
      this.price);

  Asset get baseAsset {
    return Asset.create(
        this.baseAssetType, this.baseAssetCode, this.baseAssetIssuer);
  }

  Asset get counterAsset {
    return Asset.create(
        this.counterAssetType, this.counterAssetCode, this.counterAssetIssuer);
  }

  factory TradeResponse.fromJson(Map<String, dynamic> json) {
    return new TradeResponse(
        json['id'] as String,
        json['paging_token'] as String,
        json['ledger_close_time'] as String,
        json['offer_id'] as String,
        json['base_is_seller'] as bool,
        json['base_account'] == null
            ? null
            : KeyPair.fromAccountId(json['base_account'] as String),
        json['base_offer_id'] as String,
        json['base_amount'] as String,
        json['base_asset_type'] as String,
        json['base_asset_code'] as String,
        json['base_asset_issuer'] as String,
        json['counter_account'] == null
            ? null
            : KeyPair.fromAccountId(json['counter_account'] as String),
        json['counter_offer_id'] as String,
        json['counter_amount'] as String,
        json['counter_asset_type'] as String,
        json['counter_asset_code'] as String,
        json['counter_asset_issuer'] as String,
        json['price'] == null
            ? null
            : new Price.fromJson(json['price'] as Map<String, dynamic>))
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset'])
      ..links = json['_links'] == null
          ? null
          : new TradeResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'id': id,
        'paging_token': pagingToken,
        'ledger_close_time': ledgerCloseTime,
        'offer_id': offerId,
        'base_is_seller': baseIsSeller,
        'base_account': null,
        'base_offer_id': baseOfferId,
        'base_amount': baseAmount,
        'base_asset_type': baseAssetType,
        'base_asset_code': baseAssetCode,
        'base_asset_issuer': baseAssetIssuer,
        'counter_account': null,
        'counter_offer_id': counterOfferId,
        'counter_amount': counterAmount,
        'counter_asset_type': counterAssetType,
        'counter_asset_code': counterAssetCode,
        'counter_asset_issuer': counterAssetIssuer,
        'price': price,
        '_links': links
      };
}

///Links connected to page response.
class PageLinks {
  Link next;
  Link prev;
  Link self;

  PageLinks(this.next, this.prev, this.self);

  factory PageLinks.fromJson(Map<String, dynamic> json) {
    return new PageLinks(
        json['next'] == null
            ? null
            : new Link.fromJson(json['next'] as Map<String, dynamic>),
        json['prev'] == null
            ? null
            : new Link.fromJson(json['prev'] as Map<String, dynamic>),
        json['self'] == null
            ? null
            : new Link.fromJson(json['self'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'next': next, 'prev': prev, 'self': self};
}

class TypeToken<T> {
  Type type;
  int hashCode;

  TypeToken() {
    type = T;
    hashCode = T.hashCode;
  }
}

///Indicates a generic container that requires type information to be provided after initialisation.
abstract class TypedResponse<T> {
  void setType(TypeToken<T> type);
}

///Represents page of objects.
class Page<T> extends Response implements TypedResponse<Page<T>> {
  List<T> records;
  PageLinks links;

  TypeToken<Page<T>> type;

  Page() {}

  ///The next page of results or null when there is no link for the next page of results
  Future<Page<T>> getNextPage(http.Client httpClient) async {
    if (this.links.next == null) {
      return null;
    }
    checkNotNull(
        this.type,
        "type cannot be null, is it being correctly set after the creation of this " +
            this.runtimeType.toString() +
            "?");
    ResponseHandler<Page<T>> responseHandler =
        new ResponseHandler<Page<T>>(this.type);
    String url = this.links.next.href;

    return await httpClient.get(url).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  @override
  void setType(TypeToken<Page<T>> type) {
    this.type = type;
  }

  factory Page.fromJson(Map<String, dynamic> json) {
    return new Page<T>()
      ..rateLimitLimit = convertInt(json['rateLimitLimit'])
      ..rateLimitRemaining = convertInt(json['rateLimitRemaining'])
      ..rateLimitReset = convertInt(json['rateLimitReset'])
      ..records = (json["_embedded"]['records'] as List)
          ?.map((e) => ResponseConverter.fromJson<T>(e) as T)
          ?.toList()
      ..links = json['_links'] == null
          ? null
          : new PageLinks.fromJson(json['_links'] as Map<String, dynamic>)
      ..setType(new TypeToken<Page<T>>());
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'rateLimitLimit': rateLimitLimit,
        'rateLimitRemaining': rateLimitRemaining,
        'rateLimitReset': rateLimitReset,
        'records': records,
        'links': links
      };
}

class ResponseConverter {
  static dynamic fromJson<T>(Map<String, dynamic> json){
    switch(T){
      case AccountResponse : return AccountResponse.fromJson(json);
      case AssetResponse : return AssetResponse.fromJson(json);
      case EffectResponse : return EffectResponse.fromJson(json);
      case LedgerResponse : return LedgerResponse.fromJson(json);
      case OfferResponse : return OfferResponse.fromJson(json);
      case OrderBookResponse : return OrderBookResponse.fromJson(json);
      case OperationResponse : return OperationResponse.fromJson(json);
      case OperationFeeStatsResponse : return OperationFeeStatsResponse.fromJson(json);
      case PathResponse : return PathResponse.fromJson(json);
      case RootResponse : return RootResponse.fromJson(json);
      case SubmitTransactionResponse : return SubmitTransactionResponse.fromJson(json);
      case TradeAggregationResponse : return TradeAggregationResponse.fromJson(json);
      case TradeResponse : return TradeResponse.fromJson(json);
      case TransactionResponse : return TransactionResponse.fromJson(json);
    }

    switch(T.toString()){
      case "Page<AccountResponse>": return Page<AccountResponse>.fromJson(json);
      case "Page<AssetResponse>": return Page<AssetResponse>.fromJson(json);
      case "Page<EffectResponse>": return Page<EffectResponse>.fromJson(json);
      case "Page<LedgerResponse>": return Page<LedgerResponse>.fromJson(json);
      case "Page<OfferResponse>": return Page<OfferResponse>.fromJson(json);
      case "Page<OrderBookResponse>": return Page<OrderBookResponse>.fromJson(json);
      case "Page<OperationResponse>": return Page<OperationResponse>.fromJson(json);
      case "Page<OperationFeeStatsResponse>": return Page<OperationFeeStatsResponse>.fromJson(json);
      case "Page<PathResponse>": return Page<PathResponse>.fromJson(json);
      case "Page<RootResponse>": return Page<RootResponse>.fromJson(json);
      case "Page<SubmitTransactionResponse>": return Page<SubmitTransactionResponse>.fromJson(json);
      case "Page<TradeAggregationResponse>": return Page<TradeAggregationResponse>.fromJson(json);
      case "Page<TradeResponse>": return Page<TradeResponse>.fromJson(json);
      case "Page<TransactionResponse>": return Page<TransactionResponse>.fromJson(json);
    }
  }
}
