import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'assets.dart';
import 'request.dart';
import 'response.dart';
import 'transaction.dart';
import 'util.dart';

///Network class is used to specify which Stellar network you want to use.
///Each network has a <code>networkPassphrase</code> which is hashed to
///every transaction id.
///There is no default network. You need to specify network when initializing your app by calling
class Network {
  static final String PUBLIC = "Public Global Stellar Network ; September 2015";
  static final String TESTNET = "Test SDF Network ; September 2015";
  static Network _current;

  String _networkPassphrase;

  ///Creates a new Network object to represent a network with a given passphrase
  Network(String networkPassphrase) {
    this._networkPassphrase =
        checkNotNull(networkPassphrase, "networkPassphrase cannot be null");
  }

  ///Returns network passphrase
  String get networkPassphrase => _networkPassphrase;

  ///Returns network id (SHA-256 hashed <code>networkPassphrase</code>).
  Uint8List get networkId => Util.hash(utf8.encode(_current.networkPassphrase));

  ///Returns currently used Network object.
  static Network current() {
    return _current;
  }

  ///Use <code>network</code> as a current network.
  static void use(Network network) {
    _current = network;
  }

  ///Use Stellar Public Network
  static void usePublicNetwork() {
    Network.use(new Network(PUBLIC));
  }

  ///Use Stellar Test Network.
  static void useTestNetwork() {
    Network.use(new Network(TESTNET));
  }
}

///Indicates that no network was selected.
class NoNetworkSelectedException implements Exception {
  NoNetworkSelectedException();
  String toString() {
    return "No network selected. Use `Network.use`, `Network.usePublicNetwork` or `Network.useTestNetwork` helper methods to select network.";
  }
}

///Main class used to connect to Horizon server.
class Server {
  Uri _serverURI;
  http.Client _httpClient;

  Server(String url) {
    _serverURI = Uri.parse(url);
    _httpClient = new http.Client();
  }

  http.Client get httpClient => _httpClient;

  set httpClient(http.Client httpClient) {
    this._httpClient = httpClient;
  }

  ///Returns RootResponse.
  Future<RootResponse> root() async {
    TypeToken type = new TypeToken<RootResponse>();
    ResponseHandler<RootResponse> responseHandler =
        new ResponseHandler<RootResponse>(type);

    return await httpClient.get(_serverURI).then((response) {
      return responseHandler.handleResponse(response);
    });
  }

  ///Returns AccountsRequestBuilder instance.
  AccountsRequestBuilder get accounts =>new AccountsRequestBuilder(httpClient, _serverURI);

  ///Returns AssetsRequestBuilder instance.
  AssetsRequestBuilder get assets => new AssetsRequestBuilder(httpClient, _serverURI);

  ///Returns EffectsRequestBuilder instance.
  EffectsRequestBuilder get effects => new EffectsRequestBuilder(httpClient, _serverURI);

  ///Returns LedgersRequestBuilder instance.
  LedgersRequestBuilder get ledgers => new LedgersRequestBuilder(httpClient, _serverURI);

  ///Returns OffersRequestBuilder instance.
  OffersRequestBuilder get offers => new OffersRequestBuilder(httpClient, _serverURI);

  ///Returns OperationsRequestBuilder instance.
  OperationsRequestBuilder get operations => new OperationsRequestBuilder(httpClient, _serverURI);

  ///Returns OperationFeeStatsResponse instance.
  OperationFeeStatsRequestBuilder get operationFeeStats => new OperationFeeStatsRequestBuilder(httpClient, _serverURI);

  ///Returns OrderBookRequestBuilder instance.
  OrderBookRequestBuilder get orderBook => new OrderBookRequestBuilder(httpClient, _serverURI);

  ///Returns TradesRequestBuilder instance.
  TradesRequestBuilder get trades => new TradesRequestBuilder(httpClient, _serverURI);

  ///Returns TradeAggregationsRequestBuilder instance.
  TradeAggregationsRequestBuilder tradeAggregations(
      Asset baseAsset,
      Asset counterAsset,
      int startTime,
      int endTime,
      int resolution,
      int offset) {
    return new TradeAggregationsRequestBuilder(httpClient, _serverURI,
        baseAsset, counterAsset, startTime, endTime, resolution, offset);
  }

  ///Returns PathsRequestBuilder instance.
  PathsRequestBuilder get paths => new PathsRequestBuilder(httpClient, _serverURI);

  ///Returns PaymentsRequestBuilder instance.
  PaymentsRequestBuilder get payments => new PaymentsRequestBuilder(httpClient, _serverURI);

  ///Returns TransactionsRequestBuilder instance.
  TransactionsRequestBuilder get transactions => new TransactionsRequestBuilder(httpClient, _serverURI);

  ///Submits transaction to the network.
  Future<SubmitTransactionResponse> submitTransaction(
      Transaction transaction) async {
    Uri callURI = _serverURI.replace(pathSegments: ["transactions"]);

    SubmitTransactionResponse result = await _httpClient.post(callURI,
        body: {"tx": transaction.toEnvelopeXdrBase64()}).then((response) {
      SubmitTransactionResponse submitTransactionResponse = null;

      switch (response.statusCode) {
        case 200:
        case 400:
          submitTransactionResponse =
              SubmitTransactionResponse.fromJson(json.decode(response.body));
          break;
        case 504:
          throw new SubmitTransactionTimeoutResponseException();
        default:
          throw new SubmitTransactionUnknownResponseException(
              response.statusCode, response.body);
      }
      return submitTransactionResponse;
    }).catchError((onError) {
      throw onError;
    });

    return result;
  }
}
