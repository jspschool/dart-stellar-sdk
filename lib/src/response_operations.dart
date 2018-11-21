import 'assets.dart';
import 'key_pair.dart';
import 'response.dart';

///Represents operation links.
class OperationResponseLinks {
  Link effects;
  Link precedes;
  Link self;
  Link succeeds;
  Link transaction;

  OperationResponseLinks(this.effects, this.precedes, this.self,
      this.succeeds, this.transaction);

  factory OperationResponseLinks.fromJson(Map<String, dynamic> json) {
    return new OperationResponseLinks(
        json['effects'] == null
            ? null
            : new Link.fromJson(json['effects'] as Map<String, dynamic>),
        json['precedes'] == null
            ? null
            : new Link.fromJson(json['precedes'] as Map<String, dynamic>),
        json['self'] == null
            ? null
            : new Link.fromJson(json['self'] as Map<String, dynamic>),
        json['succeeds'] == null
            ? null
            : new Link.fromJson(json['succeeds'] as Map<String, dynamic>),
        json['transaction'] == null
            ? null
            : new Link.fromJson(json['transaction'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'effects': effects,
        'precedes': precedes,
        'self': self,
        'succeeds': succeeds,
        'transaction': transaction
      };
}

///Abstract class for operation responses.
///
/// <p>Possible types:</p>
/// <ul>
///   <li>create_account</li>
///   <li>payment</li>
///   <li>allow_trust</li>
///   <li>change_trust</li>
///   <li>set_options</li>
///   <li>account_merge</li>
///   <li>manage_offer</li>
///   <li>path_payment</li>
///   <li>create_passive_offer</li>
///   <li>inflation</li>
///   <li>manage_data</li>
/// </ul>
abstract class OperationResponse extends Response {
  int id;
  KeyPair sourceAccount;
  String pagingToken;
  String createdAt;
  String transactionHash;
  String type;
  OperationResponseLinks links;

  OperationResponse() {}

  factory OperationResponse.fromJson(Map<String, dynamic> json) {
    int type = convertInt(json["type_i"]);
    switch (type) {
      case 0:
        return CreateAccountOperationResponse.fromJson(json);
      case 1:
        return PaymentOperationResponse.fromJson(json);
      case 2:
        return PathPaymentOperationResponse.fromJson(json);
      case 3:
        return ManageOfferOperationResponse.fromJson(json);
      case 4:
        return CreatePassiveOfferOperationResponse.fromJson(json);
      case 5:
        return SetOptionsOperationResponse.fromJson(json);
      case 6:
        return ChangeTrustOperationResponse.fromJson(json);
      case 7:
        return AllowTrustOperationResponse.fromJson(json);
      case 8:
        return AccountMergeOperationResponse.fromJson(json);
      case 9:
        return InflationOperationResponse.fromJson(json);
      case 10:
        return ManageDataOperationResponse.fromJson(json);
      case 11:
        return BumpSequenceOperationResponse.fromJson(json);
      default:
        throw new Exception("Invalid operation type");
    }
  }
}

///Represents AccountMerge operation response.
class AccountMergeOperationResponse extends OperationResponse {
  KeyPair account;
  KeyPair into;

  AccountMergeOperationResponse(this.account, this.into);

  factory AccountMergeOperationResponse.fromJson(Map<String, dynamic> json) {
    return new AccountMergeOperationResponse(
        json['account'] == null
            ? null
            : KeyPair.fromAccountId(json['account'] as String),
        json['into'] == null
            ? null
            : KeyPair.fromAccountId(json['into'] as String))
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'account': null,
        'into': null
      };
}

///Represents AllowTrust operation response.
class AllowTrustOperationResponse extends OperationResponse {
  KeyPair trustor;
  KeyPair trustee;
  String assetType;
  String assetCode;
  String assetIssuer;
  bool authorize;

  AllowTrustOperationResponse(this.authorize, this.assetIssuer, this.assetCode,
      this.assetType, this.trustee, this.trustor);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
    }
  }

  factory AllowTrustOperationResponse.fromJson(Map<String, dynamic> json) {
    return new AllowTrustOperationResponse(
        json['authorize'] as bool,
        json['asset_issuer'] as String,
        json['asset_code'] as String,
        json['asset_type'] as String,
        json['trustee'] == null
            ? null
            : KeyPair.fromAccountId(json['trustee'] as String),
        json['trustor'] == null
            ? null
            : KeyPair.fromAccountId(json['trustor'] as String))
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account':
            sourceAccount == null ? null : serializeNull(sourceAccount),
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'trustor': trustor == null ? null : serializeNull(trustor),
        'trustee': trustee == null ? null : serializeNull(trustee),
        'asset_type': assetType,
        'asset_code': assetCode,
        'asset_issuer': assetIssuer,
        'authorize': authorize
      };
}

///Represents BumpSequence operation response.
class BumpSequenceOperationResponse extends OperationResponse {
  int bumpTo;

  BumpSequenceOperationResponse(this.bumpTo);

  factory BumpSequenceOperationResponse.fromJson(Map<String, dynamic> json) {
    return new BumpSequenceOperationResponse(int.parse(json['bump_to'] as String))
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'bump_to': bumpTo
      };
}

///Represents ChangeTrust operation response.
class ChangeTrustOperationResponse extends OperationResponse {
  KeyPair trustor;
  KeyPair trustee;
  String assetType;
  String assetCode;
  String assetIssuer;
  String limit;

  ChangeTrustOperationResponse(this.trustor, this.trustee, this.assetType,
      this.assetCode, this.assetIssuer, this.limit);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
    }
  }

  factory ChangeTrustOperationResponse.fromJson(Map<String, dynamic> json) {
    return new ChangeTrustOperationResponse(
        json['trustor'] == null
            ? null
            : KeyPair.fromAccountId(json['trustor'] as String),
        json['trustee'] == null
            ? null
            : KeyPair.fromAccountId(json['trustee'] as String),
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String,
        json['limit'] as String)
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'trustor': null,
        'trustee': null,
        'asset_type': assetType,
        'asset_code': assetCode,
        'asset_issuer': assetIssuer,
        'limit': limit
      };
}

///Represents CreateAccount operation response.
class CreateAccountOperationResponse extends OperationResponse {
  KeyPair account;
  KeyPair funder;
  String startingBalance;

  CreateAccountOperationResponse(
      this.funder, this.startingBalance, this.account);

  factory CreateAccountOperationResponse.fromJson(Map<String, dynamic> json) {
    return new CreateAccountOperationResponse(
        json['funder'] == null
            ? null
            : KeyPair.fromAccountId(json['funder'] as String),
        json['starting_balance'] as String,
        json['account'] == null
            ? null
            : KeyPair.fromAccountId(json['account'] as String))
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'account': null,
        'funder': null,
        'starting_balance': startingBalance
      };
}

///Represents CreatePassiveOffer operation response.
class CreatePassiveOfferOperationResponse extends OperationResponse {
  int offerId;
  String amount;
  String price;

  String buyingAssetType;
  String buyingAssetCode;
  String buyingAssetIssuer;

  String sellingAssetType;
  String sellingAssetCode;
  String sellingAssetIssuer;

  CreatePassiveOfferOperationResponse(
      this.offerId,
      this.amount,
      this.price,
      this.buyingAssetType,
      this.buyingAssetCode,
      this.buyingAssetIssuer,
      this.sellingAssetType,
      this.sellingAssetCode,
      this.sellingAssetIssuer);

  Asset get buyingAsset {
    if (buyingAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(buyingAssetIssuer);
      return Asset.createNonNativeAsset(buyingAssetCode, issuer);
    }
  }

  Asset get sellingAsset {
    if (sellingAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(sellingAssetIssuer);
      return Asset.createNonNativeAsset(sellingAssetCode, issuer);
    }
  }

  factory CreatePassiveOfferOperationResponse.fromJson(
      Map<String, dynamic> json) {
    return new CreatePassiveOfferOperationResponse(
        convertInt(json['offer_id']),
        json['amount'] as String,
        json['price'] as String,
        json['buying_asset_type'] as String,
        json['buying_asset_code'] as String,
        json['buying_asset_issuer'] as String,
        json['selling_asset_type'] as String,
        json['selling_asset_code'] as String,
        json['selling_asset_issuer'] as String)
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'offer_id': offerId,
        'amount': amount,
        'price': price,
        'buying_asset_type': buyingAssetType,
        'buying_asset_code': buyingAssetCode,
        'buying_asset_issuer': buyingAssetIssuer,
        'selling_asset_type': sellingAssetType,
        'selling_asset_code': sellingAssetCode,
        'selling_asset_issuer': sellingAssetIssuer
      };
}

///Represents Inflation operation response.
class InflationOperationResponse extends OperationResponse {
  InflationOperationResponse();

  factory InflationOperationResponse.fromJson(Map<String, dynamic> json) {
    return new InflationOperationResponse()
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links
      };
}

///Represents ManageDataoperation response.
class ManageDataOperationResponse extends OperationResponse {
  String name;
  String value;

  ManageDataOperationResponse(this.name, this.value);

  factory ManageDataOperationResponse.fromJson(Map<String, dynamic> json) {
    return new ManageDataOperationResponse(
        json['name'] as String, json['value'] as String)
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'name': name,
        'value': value
      };
}

///Represents ManageOffer operation response.
class ManageOfferOperationResponse extends OperationResponse {
  int offerId;
  String amount;
  String price;

  String buyingAssetType;
  String buyingAssetCode;
  String buyingAssetIssuer;

  String sellingAssetType;
  String sellingAssetCode;
  String sellingAssetIssuer;

  ManageOfferOperationResponse(
      this.offerId,
      this.amount,
      this.price,
      this.buyingAssetType,
      this.buyingAssetCode,
      this.buyingAssetIssuer,
      this.sellingAssetType,
      this.sellingAssetCode,
      this.sellingAssetIssuer);

  Asset get buyingAsset {
    if (buyingAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(buyingAssetIssuer);
      return Asset.createNonNativeAsset(buyingAssetCode, issuer);
    }
  }

  Asset get sellingAsset {
    if (sellingAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(sellingAssetIssuer);
      return Asset.createNonNativeAsset(sellingAssetCode, issuer);
    }
  }

  factory ManageOfferOperationResponse.fromJson(Map<String, dynamic> json) {
    return new ManageOfferOperationResponse(
        convertInt(json['offer_id']),
        json['amount'] as String,
        json['price'] as String,
        json['buying_asset_type'] as String,
        json['buying_asset_code'] as String,
        json['buying_asset_issuer'] as String,
        json['selling_asset_type'] as String,
        json['selling_asset_code'] as String,
        json['selling_asset_issuer'] as String)
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'offer_id': offerId,
        'amount': amount,
        'price': price,
        'buying_asset_type': buyingAssetType,
        'buying_asset_code': buyingAssetCode,
        'buying_asset_issuer': buyingAssetIssuer,
        'selling_asset_type': sellingAssetType,
        'selling_asset_code': sellingAssetCode,
        'selling_asset_issuer': sellingAssetIssuer
      };
}

///Represents PathPayment operation response.
class PathPaymentOperationResponse extends OperationResponse {
  String amount;
  String sourceMax;
  KeyPair from;
  KeyPair to;

  String assetType;
  String assetCode;
  String assetIssuer;

  String sourceAssetType;
  String sourceAssetCode;
  String sourceAssetIssuer;

  PathPaymentOperationResponse(
      this.amount,
      this.sourceMax,
      this.from,
      this.to,
      this.assetType,
      this.assetCode,
      this.assetIssuer,
      this.sourceAssetType,
      this.sourceAssetCode,
      this.sourceAssetIssuer);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
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

  factory PathPaymentOperationResponse.fromJson(Map<String, dynamic> json) {
    return new PathPaymentOperationResponse(
        json['amount'] as String,
        json['source_max'] as String,
        json['from'] == null
            ? null
            : KeyPair.fromAccountId(json['from'] as String),
        json['to'] == null ? null : KeyPair.fromAccountId(json['to'] as String),
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String,
        json['source_asset_type'] as String,
        json['source_asset_code'] as String,
        json['source_asset_issuer'] as String)
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'amount': amount,
        'source_max': sourceMax,
        'from': null,
        'to': null,
        'asset_type': assetType,
        'asset_code': assetCode,
        'asset_issuer': assetIssuer,
        'source_asset_type': sourceAssetType,
        'source_asset_code': sourceAssetCode,
        'source_asset_issuer': sourceAssetIssuer
      };
}

///Represents Payment operation response.
class PaymentOperationResponse extends OperationResponse {
  String amount;
  String assetType;
  String assetCode;
  String assetIssuer;
  KeyPair from;
  KeyPair to;

  PaymentOperationResponse(String amount, String assetType, String assetCode,
      String assetIssuer, KeyPair from, KeyPair to) {
    this.amount = amount;
    this.assetType = assetType;
    this.assetCode = assetCode;
    this.assetIssuer = assetIssuer;
    this.from = from;
    this.to = to;
  }

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
    }
  }

  factory PaymentOperationResponse.fromJson(Map<String, dynamic> json) {
    return new PaymentOperationResponse(
        json['amount'] as String,
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String,
        json['from'] == null
            ? null
            : KeyPair.fromAccountId(json['from'] as String),
        json['to'] == null ? null : KeyPair.fromAccountId(json['to'] as String))
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'amount': amount,
        'asset_type': assetType,
        'asset_code': assetCode,
        'asset_issuer': assetIssuer,
        'from': null,
        'to': null
      };
}

///Represents SetOptions operation response.
class SetOptionsOperationResponse extends OperationResponse {
  int lowThreshold;
  int medThreshold;
  int highThreshold;
  KeyPair inflationDestination;
  String homeDomain;
  String signerKey;
  int signerWeight;
  int masterKeyWeight;
  List<String> clearFlags;
  List<String> setFlags;

  SetOptionsOperationResponse(
      this.lowThreshold,
      this.medThreshold,
      this.highThreshold,
      this.inflationDestination,
      this.homeDomain,
      this.signerKey,
      this.signerWeight,
      this.masterKeyWeight,
      this.clearFlags,
      this.setFlags);

  KeyPair get signer {
    return KeyPair.fromAccountId(signerKey);
  }

  factory SetOptionsOperationResponse.fromJson(Map<String, dynamic> json) {
    return new SetOptionsOperationResponse(
        convertInt(json['low_threshold']),
        convertInt(json['med_threshold']),
        convertInt(json['high_threshold']),
        json['inflation_dest'] == null
            ? null
            : KeyPair.fromAccountId(json['inflation_dest'] as String),
        json['home_domain'] as String,
        json['signer_key'] as String,
        convertInt(json['signer_weight']),
        convertInt(json['master_key_weight']),
        (json['clear_flags_s'] as List)?.map((e) => e as String)?.toList(),
        (json['set_flags_s'] as List)?.map((e) => e as String)?.toList())
      ..id = int.parse(json['id'] as String)
      ..sourceAccount = json['source_account'] == null
          ? null
          : KeyPair.fromAccountId(json['source_account'] as String)
      ..pagingToken = json['paging_token'] as String
      ..createdAt = json['created_at'] as String
      ..transactionHash = json['transaction_hash'] as String
      ..type = json['type'] as String
      ..links = json['_links'] == null
          ? null
          : new OperationResponseLinks.fromJson(
              json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'source_account': null,
        'paging_token': pagingToken,
        'created_at': createdAt,
        'transaction_hash': transactionHash,
        'type': type,
        '_links': links,
        'low_threshold': lowThreshold,
        'med_threshold': medThreshold,
        'high_threshold': highThreshold,
        'inflation_dest': null,
        'home_domain': homeDomain,
        'signer_key': signerKey,
        'signer_weight': signerWeight,
        'master_key_weight': masterKeyWeight,
        'clear_flags_s': clearFlags,
        'set_flags_s': setFlags
      };
}
