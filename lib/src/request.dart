import "package:eventsource/eventsource.dart";
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'assets.dart';
import 'key_pair.dart';
import 'response.dart';
import 'response_effects.dart';
import 'response_operations.dart';
import 'util.dart';

///Exception thrown when request returned an non-success HTTP code.
class ErrorResponse implements Exception {
  int _code;
  String _body;

  ErrorResponse(this._code, this._body);

  String toString() {
    return "Error response from the server.";
  }

  int get code => _code;
  String get body => _body;
}

///Exception thrown when too many requests were sent to the Horizon server.
class TooManyRequestsException implements Exception {
  int _retryAfter;

  TooManyRequestsException(this._retryAfter);

  String toString() {
    return "The rate limit for the requesting IP address is over its alloted limit.";
  }

  int get retryAfter => _retryAfter;
}

///This interface is used in RequestBuilder classes <code>stream</code> method.
abstract class EventListener<T> {
  void onEvent(T object);
}

///Represents possible <code>order</code> parameter values.
class RequestBuilderOrder {
  final _value;
  const RequestBuilderOrder._internal(this._value);
  toString() => 'RequestBuilderOrder.$_value';
  RequestBuilderOrder(this._value);
  get value => this._value;

  static const ASC = const RequestBuilderOrder._internal("asc");
  static const DESC = const RequestBuilderOrder._internal("desc");
}

///Abstract class for request builders.
abstract class RequestBuilder {
  Uri uriBuilder;
  http.Client httpClient;
  List<String> _segments;
  bool _segmentsAdded = false;
  Map<String, String> _queryParameters;

  RequestBuilder(
      http.Client httpClient, Uri serverURI, List<String> defaultSegment) {
    this.httpClient = httpClient;
    uriBuilder = serverURI;
    _segments = List<String>();
    if (defaultSegment != null) {
      this.setSegments(defaultSegment);
    }
    _segmentsAdded = false; // Allow overwriting segments
    _queryParameters = {};
  }

  RequestBuilder setSegments(List<String> segments) {
    if (_segmentsAdded) {
      throw new Exception("URL segments have been already added.");
    }

    _segmentsAdded = true;
    // Remove default segments
    this._segments.clear();
    for (String segment in segments) {
      this._segments.add(segment);
    }

    return this;
  }

  ///Sets <code>cursor</code> parameter on the request.
  ///A cursor is a value that points to a specific location in a collection of resources.
  ///The cursor attribute itself is an opaque value meaning that users should not try to parse it.
  RequestBuilder cursor(String cursor) {
    _queryParameters.addAll({"cursor": cursor});
    return this;
  }

  ///Sets <code>limit</code> parameter on the request.
  ///It defines maximum number of records to return.
  ///For range and default values check documentation of the endpoint requested.
  RequestBuilder limit(int number) {
    _queryParameters.addAll({"limit": number.toString()});
    return this;
  }

  ///Sets <code>order</code> parameter on the request.
  RequestBuilder order(RequestBuilderOrder direction) {
    _queryParameters.addAll({"order": direction.value});
    return this;
  }

  Uri buildUri() {
    Uri build = uriBuilder;

    if (_segments.length > 0) {
      build = build.replace(
        pathSegments: _segments,
      );
    }
    if (_queryParameters.length > 0) {
      build = build.replace(queryParameters: _queryParameters);
    }

    return build;
  }
}

class ResponseHandler<T> {
  TypeToken<T> _type;

  ResponseHandler(TypeToken<T> type) {
    this._type = type;
  }

  T handleResponse(final http.Response response) {
    // Too Many Requests
    if (response.statusCode == 429) {
      int retryAfter = int.parse(response.headers["Retry-After"]);
      throw TooManyRequestsException(retryAfter);
    }

    String content = response.body;

    // Other errors
    if (response.statusCode >= 300) {
      throw ErrorResponse(response.statusCode, content);
    }

    T object = ResponseConverter.fromJson<T>(json.decode(content));
    if (object is Response) {
      object.setHeaders(response.headers);
    }
    if (object is TypedResponse) {
      object.setType(_type);
    }
    return object;

  }
}

///Builds requests connected to accounts.
class AccountsRequestBuilder extends RequestBuilder {
  AccountsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["accounts"]);

  ///Requests specific <code>uri</code> and returns AccountResponse.
  ///This method is helpful for getting the links.
  Future<AccountResponse> accountURI(Uri uri) async {
    TypeToken type = new TypeToken<AccountResponse>();
    ResponseHandler<AccountResponse> responseHandler =
        ResponseHandler<AccountResponse>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Requests <code>GET /accounts/{account}</code>
  Future<AccountResponse> account(KeyPair account) {
    this.setSegments(["accounts", account.accountId]);
    return this.accountURI(this.buildUri());
  }

  ///Requests specific <code>uri</code> and returns Page of AccountResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<AccountResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<AccountResponse>>();
    ResponseHandler<Page<AccountResponse>> responseHandler =
        new ResponseHandler<Page<AccountResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<AccountResponse> stream() {
    StreamController<AccountResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        AccountResponse accountResponse =
            AccountResponse.fromJson(json.decode(event.data));
        listener.add(accountResponse);
      });
    });
    return listener.stream;
  }

  ///Build and execute request. <strong>Warning!</strong> AccountResponses in Page will contain only <code>keypair</code> field.
  Future<Page<AccountResponse>> execute() {
    return AccountsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  AccountsRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  AccountsRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  AccountsRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}

class AssetsRequestBuilder extends RequestBuilder {
  AssetsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["assets"]);

  AssetsRequestBuilder assetCode(String assetCode) {
    _queryParameters.addAll({"asset_code": assetCode});
    return this;
  }

  AssetsRequestBuilder assetIssuer(String assetIssuer) {
    _queryParameters.addAll({"asset_issuer": assetIssuer});
    return this;
  }

  static Future<Page<AssetResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<AssetResponse>>();
    ResponseHandler<Page<AssetResponse>> responseHandler =
        new ResponseHandler<Page<AssetResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  Future<Page<AssetResponse>> execute() {
    return AssetsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }
}

///Builds requests connected to effects.
class EffectsRequestBuilder extends RequestBuilder {
  EffectsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["effects"]);

  ///Builds request to <code>GET /accounts/[account]/effects</code>
  EffectsRequestBuilder forAccount(KeyPair account) {
    account = checkNotNull(account, "account cannot be null");
    this.setSegments(["accounts", account.accountId, "effects"]);
    return this;
  }

  ///Builds request to <code>GET /ledgers/[ledgerSeq]/effects</code>
  EffectsRequestBuilder forLedger(int ledgerSeq) {
    this.setSegments(["ledgers", ledgerSeq.toString(), "effects"]);
    return this;
  }

  ///Builds request to <code>GET /transactions/[transactionId]/effects</code>
  EffectsRequestBuilder forTransaction(String transactionId) {
    transactionId = checkNotNull(transactionId, "transactionId cannot be null");
    this.setSegments(["transactions", transactionId, "effects"]);
    return this;
  }

  ///Builds request to <code>GET /operation/[operationId]/effects</code>
  EffectsRequestBuilder forOperation(int operationId) {
    this.setSegments(["operations", operationId.toString(), "effects"]);
    return this;
  }

  ///Requests specific <code>uri</code> and returns Page of EffectResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<EffectResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<EffectResponse>>();
    ResponseHandler<Page<EffectResponse>> responseHandler =
        new ResponseHandler<Page<EffectResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<EffectResponse> stream() {
    StreamController<EffectResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        EffectResponse effectResponse =
            EffectResponse.fromJson(json.decode(event.data));
        listener.add(effectResponse);
      });
    });
    return listener.stream;
  }

  ///Build and execute request.
  Future<Page<EffectResponse>> execute() {
    return EffectsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  EffectsRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  EffectsRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  EffectsRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}

///Builds requests connected to ledgers.
class LedgersRequestBuilder extends RequestBuilder {
  LedgersRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["ledgers"]);

  ///Requests specific <code>uri</code> and returns LedgerResponse.
  ///This method is helpful for getting the links.
  Future<LedgerResponse> ledgerURI(Uri uri) async {
    TypeToken type = new TypeToken<LedgerResponse>();
    ResponseHandler<LedgerResponse> responseHandler =
        new ResponseHandler<LedgerResponse>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Requests <code>GET /ledgers/[ledgerSeq]</code>
  Future<LedgerResponse> ledger(int ledgerSeq) {
    this.setSegments(["ledgers", ledgerSeq.toString()]);
    return this.ledgerURI(this.buildUri());
  }

  ///Requests specific <code>uri</code> and returns Page of LedgerResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<LedgerResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<LedgerResponse>>();
    ResponseHandler<Page<LedgerResponse>> responseHandler =
        new ResponseHandler<Page<LedgerResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<LedgerResponse> stream() {
    StreamController<LedgerResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        LedgerResponse ledgerResponse =
            LedgerResponse.fromJson(json.decode(event.data));
        listener.add(ledgerResponse);
      });
    });
    return listener.stream;
  }

  ///Build and execute request.
  Future<Page<LedgerResponse>> execute() {
    return LedgersRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  LedgersRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  LedgersRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  LedgersRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}

///Builds requests connected to offers.
class OffersRequestBuilder extends RequestBuilder {
  OffersRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["offers"]);

  ///Builds request to <code>GET /accounts/[account]/offers</code>
  OffersRequestBuilder forAccount(KeyPair account) {
    account = checkNotNull(account, "account cannot be null");
    this.setSegments(["accounts", account.accountId, "offers"]);
    return this;
  }

  ///Requests specific <code>uri</code> and returns Page of OfferResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<OfferResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<OfferResponse>>();
    ResponseHandler<Page<OfferResponse>> responseHandler =
        new ResponseHandler<Page<OfferResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Build and execute request.
  Future<Page<OfferResponse>> execute() {
    return OffersRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  OffersRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  OffersRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  OffersRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}

class OperationFeeStatsRequestBuilder extends RequestBuilder {
  OperationFeeStatsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["operation_fee_stats"]);

  ///Requests <code>GET /operation_fee_stats</code>
  Future<OperationFeeStatsResponse> execute() async {
    TypeToken type = new TypeToken<OperationFeeStatsResponse>();
    ResponseHandler<OperationFeeStatsResponse> responseHandler =
        new ResponseHandler<OperationFeeStatsResponse>(type);

    return await httpClient.get(this.buildUri()).then((response) {
      return responseHandler.handleResponse(response);
    });
  }
}

///Builds requests connected to operations.
class OperationsRequestBuilder extends RequestBuilder {
  OperationsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["operations"]);

  ///Requests specific <code>uri</code> and returns OperationResponse.
  ///This method is helpful for getting the links.
  Future<OperationResponse> operationURI(Uri uri) async {
    TypeToken type = new TypeToken<OperationResponse>();
    ResponseHandler<OperationResponse> responseHandler =
        new ResponseHandler<OperationResponse>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Requests <code>GET /operations/[operationId]</code>
  Future<OperationResponse> operation(int operationId) {
    this.setSegments(["operation", operationId.toString()]);
    return this.operationURI(this.buildUri());
  }

  ///Builds request to <code>GET /accounts/[account]/operations</code>
  OperationsRequestBuilder forAccount(KeyPair account) {
    account = checkNotNull(account, "account cannot be null");
    this.setSegments(["accounts", account.accountId, "operations"]);
    return this;
  }

  ///Builds request to <code>GET /ledgers/[ledgerSeq]/operations</code>
  OperationsRequestBuilder forLedger(int ledgerSeq) {
    this.setSegments(["ledgers", ledgerSeq.toString(), "operations"]);
    return this;
  }

  ///Builds request to <code>GET /transactions/[transactionId]/operations</code>
  OperationsRequestBuilder forTransaction(String transactionId) {
    transactionId = checkNotNull(transactionId, "transactionId cannot be null");
    this.setSegments(["transactions", transactionId, "operations"]);
    return this;
  }

  ///Requests specific <code>uri</code> and returns Page of OperationResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<OperationResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<OperationResponse>>();
    ResponseHandler<Page<OperationResponse>> responseHandler =
        new ResponseHandler<Page<OperationResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<OperationResponse> stream() {
    StreamController<OperationResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        OperationResponse operationResponse =
            OperationResponse.fromJson(json.decode(event.data));
        listener.add(operationResponse);
      });
    });
    return listener.stream;
  }

  ///Build and execute request.
  Future<Page<OperationResponse>> execute() {
    return OperationsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  OperationsRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  OperationsRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  OperationsRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}

///Builds requests connected to order book.
class OrderBookRequestBuilder extends RequestBuilder {
  OrderBookRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["order_book"]);

  OrderBookRequestBuilder buyingAsset(Asset asset) {
    _queryParameters.addAll({"buying_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters.addAll({"buying_asset_code": creditAlphaNumAsset.code});
      _queryParameters.addAll(
          {"buying_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
    return this;
  }

  OrderBookRequestBuilder sellingAsset(Asset asset) {
    _queryParameters.addAll({"selling_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters.addAll({"selling_asset_code": creditAlphaNumAsset.code});
      _queryParameters.addAll(
          {"selling_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
    return this;
  }

  static Future<OrderBookResponse> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<OrderBookResponse>();
    ResponseHandler<OrderBookResponse> responseHandler =
        new ResponseHandler<OrderBookResponse>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<OrderBookResponse> stream() {
    StreamController<OrderBookResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        OrderBookResponse orderBookResponse =
            OrderBookResponse.fromJson(json.decode(event.data));
        listener.add(orderBookResponse);
      });
    });
    return listener.stream;
  }

  Future<OrderBookResponse> execute() {
    return OrderBookRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  RequestBuilder cursor(String cursor) {
    throw new Exception("Not implemented yet.");
  }

  @override
  RequestBuilder order(RequestBuilderOrder direction) {
    throw new Exception("Not implemented yet.");
  }
}

///Builds requests connected to paths.
class PathsRequestBuilder extends RequestBuilder {
  PathsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["paths"]);

  PathsRequestBuilder destinationAccount(KeyPair account) {
    _queryParameters.addAll({"destination_account": account.accountId});
    return this;
  }

  PathsRequestBuilder sourceAccount(KeyPair account) {
    _queryParameters.addAll({"source_account": account.accountId});
    return this;
  }

  PathsRequestBuilder destinationAmount(String amount) {
    _queryParameters.addAll({"destination_amount": amount});
    return this;
  }

  PathsRequestBuilder destinationAsset(Asset asset) {
    _queryParameters.addAll({"destination_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters
          .addAll({"destination_asset_code": creditAlphaNumAsset.code});
      _queryParameters.addAll(
          {"destination_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
    return this;
  }

  static Future<Page<PathResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<PathResponse>>();
    ResponseHandler<Page<PathResponse>> responseHandler =
        new ResponseHandler<Page<PathResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  Future<Page<PathResponse>> execute() {
    return PathsRequestBuilder.requestExecute(this.httpClient, this.buildUri());
  }
}

///Builds requests connected to payments.
class PaymentsRequestBuilder extends RequestBuilder {
  PaymentsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["payments"]);

  ///Builds request to <code>GET /accounts/[account]/payments</code>
  PaymentsRequestBuilder forAccount(KeyPair account) {
    account = checkNotNull(account, "account cannot be null");
    this.setSegments(["accounts", account.accountId, "payments"]);
    return this;
  }

  ///Builds request to <code>GET /ledgers/[ledgerSeq]/payments</code>
  PaymentsRequestBuilder forLedger(int ledgerSeq) {
    this.setSegments(["ledgers", ledgerSeq.toString(), "payments"]);
    return this;
  }

  ///Builds request to <code>GET /transactions/[transactionId]/payments</code>
  PaymentsRequestBuilder forTransaction(String transactionId) {
    transactionId = checkNotNull(transactionId, "transactionId cannot be null");
    this.setSegments(["transactions", transactionId, "payments"]);
    return this;
  }

  ///Requests specific <code>uri</code> and returns Page of OperationResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<OperationResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<OperationResponse>>();
    ResponseHandler<Page<OperationResponse>> responseHandler =
        new ResponseHandler<Page<OperationResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<OperationResponse> stream() {
    StreamController<OperationResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        OperationResponse payment =
            OperationResponse.fromJson(json.decode(event.data));
        listener.add(payment);
      });
    });
    return listener.stream;
  }

  ///Build and execute request.
  Future<Page<OperationResponse>> execute() {
    return PaymentsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  PaymentsRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  PaymentsRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  PaymentsRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}

///Builds requests connected to trades.
class TradeAggregationsRequestBuilder extends RequestBuilder {
  TradeAggregationsRequestBuilder(
      http.Client httpClient,
      Uri serverURI,
      Asset baseAsset,
      Asset counterAsset,
      int startTime,
      int endTime,
      int resolution,
      int offset)
      : super(httpClient, serverURI, ["trade_aggregations"]) {
    this._baseAsset(baseAsset);
    this._counterAsset(counterAsset);
    _queryParameters.addAll({"start_time": startTime.toString()});
    _queryParameters.addAll({"end_time": endTime.toString()});
    _queryParameters.addAll({"resolution": resolution.toString()});
    _queryParameters.addAll({"offset": offset.toString()});
  }

  void _baseAsset(Asset asset) {
    _queryParameters.addAll({"base_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters.addAll({"base_asset_code": creditAlphaNumAsset.code});
      _queryParameters
          .addAll({"base_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
  }

  void _counterAsset(Asset asset) {
    _queryParameters.addAll({"counter_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters.addAll({"counter_asset_code": creditAlphaNumAsset.code});
      _queryParameters.addAll(
          {"counter_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
  }

  static Future<Page<TradeAggregationResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<TradeAggregationResponse>>();
    ResponseHandler<Page<TradeAggregationResponse>> responseHandler =
        new ResponseHandler<Page<TradeAggregationResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  Future<Page<TradeAggregationResponse>> execute() {
    return TradeAggregationsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }
}

///Builds requests connected to trades.
class TradesRequestBuilder extends RequestBuilder {
  TradesRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["trades"]);

  TradesRequestBuilder baseAsset(Asset asset) {
    _queryParameters.addAll({"base_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters.addAll({"base_asset_code": creditAlphaNumAsset.code});
      _queryParameters
          .addAll({"base_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
    return this;
  }

  TradesRequestBuilder counterAsset(Asset asset) {
    _queryParameters.addAll({"counter_asset_type": asset.type});
    if (asset is AssetTypeCreditAlphaNum) {
      AssetTypeCreditAlphaNum creditAlphaNumAsset = asset;
      _queryParameters.addAll({"counter_asset_code": creditAlphaNumAsset.code});
      _queryParameters.addAll(
          {"counter_asset_issuer": creditAlphaNumAsset.issuer.accountId});
    }
    return this;
  }

  ///Builds request to <code>GET /accounts/[account]/trades</code>
  TradesRequestBuilder forAccount(KeyPair account) {
    account = checkNotNull(account, "account cannot be null");
    this.setSegments(["accounts", account.accountId, "trades"]);
    return this;
  }

  static Future<Page<TradeResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<TradeResponse>>();
    ResponseHandler<Page<TradeResponse>> responseHandler =
        new ResponseHandler<Page<TradeResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  Future<Page<TradeResponse>> execute() {
    return TradesRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  TradesRequestBuilder offerId(String offerId) {
    _queryParameters.addAll({"offer_id": offerId});
    return this;
  }
}

///Builds requests connected to transactions.
class TransactionsRequestBuilder extends RequestBuilder {
  TransactionsRequestBuilder(http.Client httpClient, Uri serverURI)
      : super(httpClient, serverURI, ["transactions"]);

  ///Requests specific <code>uri</code> and returns TransactionResponse.
  ///This method is helpful for getting the links.
  Future<TransactionResponse> transactionURI(Uri uri) async {
    TypeToken type = new TypeToken<TransactionResponse>();
    ResponseHandler<TransactionResponse> responseHandler =
        new ResponseHandler<TransactionResponse>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Requests <code>GET /transactions/[transactionId]</code>
  Future<TransactionResponse> transaction(String transactionId) {
    this.setSegments(["transactions", transactionId]);
    return this.transactionURI(this.buildUri());
  }

  ///Builds request to <code>GET /accounts/[account]/transactions</code>
  TransactionsRequestBuilder forAccount(KeyPair account) {
    account = checkNotNull(account, "account cannot be null");
    this.setSegments(["accounts", account.accountId, "transactions"]);
    return this;
  }

  ///Builds request to <code>GET /ledgers/[ledgerSeq]/transactions</code>
  TransactionsRequestBuilder forLedger(int ledgerSeq) {
    this.setSegments(["ledgers", ledgerSeq.toString(), "transactions"]);
    return this;
  }

  ///Requests specific <code>uri</code> and returns Page of TransactionResponse.
  ///This method is helpful for getting the next set of results.
  static Future<Page<TransactionResponse>> requestExecute(
      http.Client httpClient, Uri uri) async {
    TypeToken type = new TypeToken<Page<TransactionResponse>>();
    ResponseHandler<Page<TransactionResponse>> responseHandler =
        new ResponseHandler<Page<TransactionResponse>>(type);

    return await httpClient.get(uri).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Allows to stream SSE events from horizon.
  ///Certain endpoints in Horizon can be called in streaming mode using Server-Sent Events.
  ///This mode will keep the connection to horizon open and horizon will continue to return
  ///responses as ledgers close.
  Stream<TransactionResponse> stream() {
    StreamController<TransactionResponse> listener =
        new StreamController.broadcast();
    EventSource.connect(this.buildUri()).then((eventSource) {
      eventSource.listen((Event event) {
        if (event.data == "\"hello\"" || event.event == "close") {
          return null;
        }
        TransactionResponse transactionResponse =
            TransactionResponse.fromJson(json.decode(event.data));
        listener.add(transactionResponse);
      });
    });
    return listener.stream;
  }

  ///Build and execute request.
  Future<Page<TransactionResponse>> execute() {
    return TransactionsRequestBuilder.requestExecute(
        this.httpClient, this.buildUri());
  }

  @override
  TransactionsRequestBuilder cursor(String token) {
    super.cursor(token);
    return this;
  }

  @override
  TransactionsRequestBuilder limit(int number) {
    super.limit(number);
    return this;
  }

  @override
  TransactionsRequestBuilder order(RequestBuilderOrder direction) {
    super.order(direction);
    return this;
  }
}
