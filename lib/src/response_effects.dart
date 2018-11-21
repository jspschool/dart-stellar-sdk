import 'assets.dart';
import 'key_pair.dart';
import 'response.dart';

///Represents effect links.
class EffectResponseLinks {
  Link operation;
  Link precedes;
  Link succeeds;

  EffectResponseLinks(this.operation, this.precedes, this.succeeds);

  factory EffectResponseLinks.fromJson(Map<String, dynamic> json){
    return new EffectResponseLinks(
        json['operation'] == null
            ? null
            : new Link.fromJson(json['operation'] as Map<String, dynamic>),
        json['precedes'] == null
            ? null
            : new Link.fromJson(json['precedes'] as Map<String, dynamic>),
        json['succeeds'] == null
            ? null
            : new Link.fromJson(json['succeeds'] as Map<String, dynamic>));
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'operation': operation,
    'precedes': precedes,
    'succeeds': succeeds
  };
}

///Abstract class for effect responses.
///
///<p>Possible types:</p>
///<ul>
///  <li>account_created</li>
///  <li>account_removed</li>
///  <li>account_credited</li>
///  <li>account_debited</li>
///  <li>account_thresholds_updated</li>
///  <li>account_home_domain_updated</li>
///  <li>account_flags_updated</li>
///  <li>account_inflation_destination_updated</li>
///  <li>signer_created</li>
///  <li>signer_removed</li>
///  <li>signer_updated</li>
///  <li>trustline_created</li>
///  <li>trustline_removed</li>
///  <li>trustline_updated</li>
///  <li>trustline_authorized</li>
///  <li>trustline_deauthorized</li>
///  <li>offer_created</li>
///  <li>offer_removed</li>
///  <li>offer_updated</li>
///  <li>trade</li>
///  <li>data_created</li>
///  <li>data_removed</li>
///  <li>data_updated</li>
///  <li>sequence_bumped</li>
///</ul>
///
abstract class EffectResponse extends Response {
  String id;
  KeyPair account;
  String type;
  String createdAt;
  String pagingToken;
  EffectResponseLinks links;

  EffectResponse(){}

  factory EffectResponse.fromJson(Map<String, dynamic> json) {

    int type = convertInt(json["type_i"]);
    switch (type) {
    // Account effects
      case 0:
        return AccountCreatedEffectResponse.fromJson(json);
      case 1:
        return AccountRemovedEffectResponse.fromJson(json);
      case 2:
        return AccountCreditedEffectResponse.fromJson(json);
      case 3:
        return AccountDebitedEffectResponse.fromJson(json);
      case 4:
        return AccountThresholdsUpdatedEffectResponse.fromJson(json);
      case 5:
        return AccountHomeDomainUpdatedEffectResponse.fromJson(json);
      case 6:
        return AccountFlagsUpdatedEffectResponse.fromJson(json);
      case 7:
        return AccountInflationDestinationUpdatedEffectResponse.fromJson(json);
    // Signer effects
      case 10:
        return SignerCreatedEffectResponse.fromJson(json);
      case 11:
        return SignerRemovedEffectResponse.fromJson(json);
      case 12:
        return SignerUpdatedEffectResponse.fromJson(json);
    // Trustline effects
      case 20:
        return TrustlineCreatedEffectResponse.fromJson(json);
      case 21:
        return TrustlineRemovedEffectResponse.fromJson(json);
      case 22:
        return TrustlineUpdatedEffectResponse.fromJson(json);
      case 23:
        return TrustlineAuthorizedEffectResponse.fromJson(json);
      case 24:
        return TrustlineDeauthorizedEffectResponse.fromJson(json);
    // Trading effects
      case 30:
        return OfferCreatedEffectResponse.fromJson(json);
      case 31:
        return OfferRemovedEffectResponse.fromJson(json);
      case 32:
        return OfferUpdatedEffectResponse.fromJson(json);
      case 33:
        return TradeEffectResponse.fromJson(json);
    // Data effects
      case 40:
        return DataCreatedEffectResponse.fromJson(json);
      case 41:
        return DataRemovedEffectResponse.fromJson(json);
      case 42:
        return DataUpdatedEffectResponse.fromJson(json);
    // Bump Sequence effects
      case 43:
        return SequenceBumpedEffectResponse.fromJson(json);
      default:
        throw new Exception("Invalid operation type");
    }

  }
}

///Represents account_created effect response.
class AccountCreatedEffectResponse extends EffectResponse {
  String startingBalance;

  AccountCreatedEffectResponse(this.startingBalance);

  factory AccountCreatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountCreatedEffectResponse(json['starting_balance'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'starting_balance': startingBalance
  };
}

///Represents account_credited effect response.
class AccountCreditedEffectResponse extends EffectResponse {
  String amount;
  String assetType;
  String assetCode;
  String assetIssuer;

  AccountCreditedEffectResponse(
      this.amount, this.assetType, this.assetCode, this.assetIssuer);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
    }
  }

  factory AccountCreditedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountCreditedEffectResponse(
        json['amount'] as String,
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'amount': amount,
    'asset_type': assetType,
    'asset_code': assetCode,
    'asset_issuer': assetIssuer
  };
}

///Represents account_debited effect response.
class AccountDebitedEffectResponse extends EffectResponse {
  String amount;
  String assetType;
  String assetCode;
  String assetIssuer;

  AccountDebitedEffectResponse(
      this.amount, this.assetType, this.assetCode, this.assetIssuer);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
    }
  }

  factory AccountDebitedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountDebitedEffectResponse(
        json['amount'] as String,
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'amount': amount,
    'asset_type': assetType,
    'asset_code': assetCode,
    'asset_issuer': assetIssuer
  };
}

///Represents account_flags_updated effect response.
class AccountFlagsUpdatedEffectResponse extends EffectResponse {
  bool authRequiredFlag;
  bool authRevokableFlag;

  AccountFlagsUpdatedEffectResponse(this.authRequiredFlag, this.authRevokableFlag);

  factory AccountFlagsUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountFlagsUpdatedEffectResponse(
        json['auth_required_flag'] as bool, json['auth_revokable_flag'] as bool)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'auth_required_flag': authRequiredFlag,
    'auth_revokable_flag': authRevokableFlag
  };
}

///Represents account_home_domain_updated effect response.
class AccountHomeDomainUpdatedEffectResponse extends EffectResponse {
  String homeDomain;

  AccountHomeDomainUpdatedEffectResponse(this.homeDomain);

  factory AccountHomeDomainUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountHomeDomainUpdatedEffectResponse(
        json['home_domain'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'home_domain': homeDomain
  };
}

///Represents account_inflation_destination_updated effect response.
class AccountInflationDestinationUpdatedEffectResponse extends EffectResponse {

  AccountInflationDestinationUpdatedEffectResponse();

  factory AccountInflationDestinationUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountInflationDestinationUpdatedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
  
}

///Represents account_removed effect response.
class AccountRemovedEffectResponse extends EffectResponse {

  AccountRemovedEffectResponse();

  factory AccountRemovedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountRemovedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents account_thresholds_updated effect response.
class AccountThresholdsUpdatedEffectResponse extends EffectResponse {
  int lowThreshold;
  int medThreshold;
  int highThreshold;

  AccountThresholdsUpdatedEffectResponse(this.lowThreshold, this.medThreshold, this.highThreshold);

  factory AccountThresholdsUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new AccountThresholdsUpdatedEffectResponse(
        convertInt(json['low_threshold']),
        convertInt(json['med_threshold']),
        convertInt(json['high_threshold']))
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'low_threshold': lowThreshold,
    'med_threshold': medThreshold,
    'high_threshold': highThreshold
  };
}

///Represents data_created effect response.
class DataCreatedEffectResponse extends EffectResponse {

  DataCreatedEffectResponse();

  factory DataCreatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new DataCreatedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents data_removed effect response.
class DataRemovedEffectResponse extends EffectResponse {

  DataRemovedEffectResponse();

  factory DataRemovedEffectResponse.fromJson(Map<String, dynamic> json){
    return new DataRemovedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents data_updated effect response.
class DataUpdatedEffectResponse extends EffectResponse {

  DataUpdatedEffectResponse();

  factory DataUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new DataUpdatedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents offer_created effect response.
class OfferCreatedEffectResponse extends EffectResponse {

  OfferCreatedEffectResponse();

  factory OfferCreatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new OfferCreatedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents offer_removed effect response.
class OfferRemovedEffectResponse extends EffectResponse {

  OfferRemovedEffectResponse();

  factory OfferRemovedEffectResponse.fromJson(Map<String, dynamic> json){
    return new OfferRemovedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents offer_updated effect response.
class OfferUpdatedEffectResponse extends EffectResponse {

  OfferUpdatedEffectResponse();

  factory OfferUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new OfferUpdatedEffectResponse()
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links
  };
}

///Represents sequence_bumped effect response.
class SequenceBumpedEffectResponse extends EffectResponse {
  int newSequence;

  SequenceBumpedEffectResponse(this.newSequence);
  factory SequenceBumpedEffectResponse.fromJson(Map<String, dynamic> json){
    return new SequenceBumpedEffectResponse(convertInt(json['new_seq']))
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'new_seq': newSequence
  };
}

///Represents signer_created effect response.
class SignerCreatedEffectResponse extends SignerEffectResponse {
  SignerCreatedEffectResponse(int weight, String publicKey)
      : super(weight, publicKey);
  factory SignerCreatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new SignerCreatedEffectResponse(convertInt(json['weight']), json['public_key'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'weight': weight,
    'public_key': publicKey
  };
}

abstract class SignerEffectResponse extends EffectResponse {
  int weight;
  String publicKey;

  SignerEffectResponse(this.weight, this.publicKey);
}

///Represents signer_removed effect response.
class SignerRemovedEffectResponse extends SignerEffectResponse {
  SignerRemovedEffectResponse(int weight, String publicKey)
      : super(weight, publicKey);
  factory SignerRemovedEffectResponse.fromJson(Map<String, dynamic> json){
    return new SignerRemovedEffectResponse(
        convertInt(json['weight']), json['public_key'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'weight': weight,
    'public_key': publicKey
  };
}

///Represents signed_updated effect response.
class SignerUpdatedEffectResponse extends SignerEffectResponse {
  SignerUpdatedEffectResponse(int weight, String publicKey)
      : super(weight, publicKey);
  factory SignerUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new SignerUpdatedEffectResponse(
        convertInt(json['weight']), json['public_key'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'weight': weight,
    'public_key': publicKey
  };
}

///Represents trade effect response.
class TradeEffectResponse extends EffectResponse {
  KeyPair seller;
  int offerId;

  String soldAmount;
  String soldAssetType;
  String soldAssetCode;
  String soldAssetIssuer;

  String boughtAmount;
  String boughtAssetType;
  String boughtAssetCode;
  String boughtAssetIssuer;

  TradeEffectResponse(this.seller, this.offerId, this.soldAmount, this.soldAssetType,
      this.soldAssetCode, this.soldAssetIssuer, this.boughtAmount, this.boughtAssetType,
      this.boughtAssetCode, this.boughtAssetIssuer);

  Asset get soldAsset {
    if (soldAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(soldAssetIssuer);
      return Asset.createNonNativeAsset(soldAssetCode, issuer);
    }
  }

  Asset get boughtAsset {
    if (boughtAssetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(boughtAssetIssuer);
      return Asset.createNonNativeAsset(boughtAssetCode, issuer);
    }
  }

  factory TradeEffectResponse.fromJson(Map<String, dynamic> json){
    return new TradeEffectResponse(
        json['seller'] == null
            ? null
            : KeyPair.fromAccountId(json['seller'] as String),
        convertInt(json['offer_id']),
        json['sold_amount'] as String,
        json['sold_asset_type'] as String,
        json['sold_asset_code'] as String,
        json['sold_asset_issuer'] as String,
        json['bought_amount'] as String,
        json['bought_asset_type'] as String,
        json['bought_asset_code'] as String,
        json['bought_asset_issuer'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'seller': null,
    'offer_id': offerId,
    'sold_amount': soldAmount,
    'sold_asset_type': soldAssetType,
    'sold_asset_code': soldAssetCode,
    'sold_asset_issuer': soldAssetIssuer,
    'bought_amount': boughtAmount,
    'bought_asset_type': boughtAssetType,
    'bought_asset_code': boughtAssetCode,
    'bought_asset_issuer': boughtAssetIssuer
  };
}

abstract class TrustlineAuthorizationResponse extends EffectResponse {
  KeyPair trustor;
  String assetType;
  String assetCode;

  TrustlineAuthorizationResponse(this.trustor, this.assetType, this.assetCode);
}

///Represents trustline_authorized effect response.
class TrustlineAuthorizedEffectResponse extends TrustlineAuthorizationResponse {
  TrustlineAuthorizedEffectResponse(
      KeyPair trustor, String assetType, String assetCode)
      : super(trustor, assetType, assetCode);

  factory TrustlineAuthorizedEffectResponse.fromJson(Map<String, dynamic> json){
    return new TrustlineAuthorizedEffectResponse(
        json['trustor'] == null
            ? null
            : KeyPair.fromAccountId(json['trustor'] as String),
        json['asset_type'] as String,
        json['asset_code'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'trustor': null,
    'asset_type': assetType,
    'asset_code': assetCode
  };
}

///Represents trustline_created effect response.
class TrustlineCreatedEffectResponse extends TrustlineCUDResponse {
  TrustlineCreatedEffectResponse(
      String limit, String assetType, String assetCode, String assetIssuer)
      : super(limit, assetType, assetCode, assetIssuer);

  factory TrustlineCreatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new TrustlineCreatedEffectResponse(
        json['limit'] as String,
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'limit': limit,
    'asset_type': assetType,
    'asset_code': assetCode,
    'asset_issuer': assetIssuer
  };
}

abstract class TrustlineCUDResponse extends EffectResponse {
  String limit;
  String assetType;
  String assetCode;
  String assetIssuer;

  TrustlineCUDResponse(this.limit, this.assetType, this.assetCode, this.assetIssuer);

  Asset get asset {
    if (assetType == "native") {
      return new AssetTypeNative();
    } else {
      KeyPair issuer = KeyPair.fromAccountId(assetIssuer);
      return Asset.createNonNativeAsset(assetCode, issuer);
    }
  }
}

///Represents trustline_deauthorized effect response.
class TrustlineDeauthorizedEffectResponse
    extends TrustlineAuthorizationResponse {
  TrustlineDeauthorizedEffectResponse(
      KeyPair trustor, String assetType, String assetCode)
      : super(trustor, assetType, assetCode);

  factory TrustlineDeauthorizedEffectResponse.fromJson(Map<String, dynamic> json){
    return new TrustlineDeauthorizedEffectResponse(
        json['trustor'] == null
            ? null
            : KeyPair.fromAccountId(json['trustor'] as String),
        json['asset_type'] as String,
        json['asset_code'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'trustor': trustor == null ? null : serializeNull(trustor),
    'asset_type': assetType,
    'asset_code': assetCode
  };
}

///Represents trustline_removed effect response.
class TrustlineRemovedEffectResponse extends TrustlineCUDResponse {
  TrustlineRemovedEffectResponse(
      String limit, String assetType, String assetCode, String assetIssuer)
      : super(limit, assetType, assetCode, assetIssuer);

  factory TrustlineRemovedEffectResponse.fromJson(Map<String, dynamic> json){
    return new TrustlineRemovedEffectResponse(
        json['limit'] as String,
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'limit': limit,
    'asset_type': assetType,
    'asset_code': assetCode,
    'asset_issuer': assetIssuer
  };
}

///Represents trustline_updated effect response.
class TrustlineUpdatedEffectResponse extends TrustlineCUDResponse {
  TrustlineUpdatedEffectResponse(
      String limit, String assetType, String assetCode, String assetIssuer)
      : super(limit, assetType, assetCode, assetIssuer);

  factory TrustlineUpdatedEffectResponse.fromJson(Map<String, dynamic> json){
    return new TrustlineUpdatedEffectResponse(
        json['limit'] as String,
        json['asset_type'] as String,
        json['asset_code'] as String,
        json['asset_issuer'] as String)
      ..id = json['id'] as String
      ..account = json['account'] == null
          ? null
          : KeyPair.fromAccountId(json['account'] as String)
      ..type = json['type'] as String
      ..createdAt = json['created_at'] as String
      ..pagingToken = json['paging_token'] as String
      ..links = json['_links'] == null
          ? null
          : new EffectResponseLinks.fromJson(
          json['_links'] as Map<String, dynamic>);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'account': null,
    'type': type,
    'created_at': createdAt,
    'paging_token': pagingToken,
    '_links': links,
    'limit': limit,
    'asset_type': assetType,
    'asset_code': assetCode,
    'asset_issuer': assetIssuer
  };
}
