import 'package:stellar/stellar.dart';

void testAccountsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.accounts
      .cursor("13537736921089")
      .limit(200)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/accounts?cursor=13537736921089&limit=200&order=asc" == uri.toString());
}

void testAssetsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.assets
      .assetCode("USD")
      .assetIssuer("GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN")
      .cursor("13537736921089")
      .limit(200)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/assets?asset_code=USD&asset_issuer=GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN&cursor=13537736921089&limit=200&order=asc" == uri.toString());
}

//EffectsRequestBuilder
void testEffectsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.effects
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/effects?limit=200&order=desc" == uri.toString());
}

void testEffectsRequestBuilderForAccount() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.effects
      .forAccount(KeyPair.fromAccountId("GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"))
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/accounts/GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H/effects?limit=200&order=desc" == uri.toString());
}

void testEffectsRequestBuilderForLedger() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.effects
      .forLedger(200000000000)
      .limit(50)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/ledgers/200000000000/effects?limit=50&order=asc" == uri.toString());
}

void testEffectsRequestBuilderForTransaction() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.effects
      .forTransaction("991534d902063b7715cd74207bef4e7bd7aa2f108f62d3eba837ce6023b2d4f3")
      .buildUri();
  assert("https://horizon-testnet.stellar.org/transactions/991534d902063b7715cd74207bef4e7bd7aa2f108f62d3eba837ce6023b2d4f3/effects" == uri.toString());
}

void testEffectsRequestBuilderForOperation() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.effects
      .forOperation(28798257847)
      .cursor("85794837")
      .buildUri();
  assert("https://horizon-testnet.stellar.org/operations/28798257847/effects?cursor=85794837" == uri.toString());
}
//EffectsRequestBuilder

void testLedgersRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.ledgers
      .limit(200)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/ledgers?limit=200&order=asc" == uri.toString());
}

void testOffersRequestBuilderForAccount() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.offers
      .forAccount(KeyPair.fromAccountId("GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"))
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/accounts/GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H/offers?limit=200&order=desc" == uri.toString());
}


//OperationsRequestBuilder
 void testOperationsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.operations
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/operations?limit=200&order=desc" == uri.toString());
}

void testOperationsRequestBuilderForAccount() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.operations
      .forAccount(KeyPair.fromAccountId("GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"))
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/accounts/GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H/operations?limit=200&order=desc" == uri.toString());
}

void testOperationsRequestBuilderForLedger() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.operations
      .forLedger(200000000000)
      .limit(50)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/ledgers/200000000000/operations?limit=50&order=asc" == uri.toString());
}

void testOperationsRequestBuilderForTransaction() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.operations
      .forTransaction("991534d902063b7715cd74207bef4e7bd7aa2f108f62d3eba837ce6023b2d4f3")
      .buildUri();
  assert("https://horizon-testnet.stellar.org/transactions/991534d902063b7715cd74207bef4e7bd7aa2f108f62d3eba837ce6023b2d4f3/operations" == uri.toString());
}
//OperationsRequestBuilder


void testOrderBookRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.orderBook
      .buyingAsset(Asset.createNonNativeAsset("EUR", KeyPair.fromAccountId("GAUPA4HERNBDPVO4IUA3MJXBCRRK5W54EVXTDK6IIUTGDQRB6D5W242W")))
      .sellingAsset(Asset.createNonNativeAsset("USD", KeyPair.fromAccountId("GDRRHSJMHXDTQBT4JTCILNGF5AS54FEMTXL7KOLMF6TFTHRK6SSUSUZZ")))
      .buildUri();

  assert(
      "https://horizon-testnet.stellar.org/order_book?" +
          "buying_asset_type=credit_alphanum4&" +
          "buying_asset_code=EUR&" +
          "buying_asset_issuer=GAUPA4HERNBDPVO4IUA3MJXBCRRK5W54EVXTDK6IIUTGDQRB6D5W242W&" +
          "selling_asset_type=credit_alphanum4&" +
          "selling_asset_code=USD&" +
          "selling_asset_issuer=GDRRHSJMHXDTQBT4JTCILNGF5AS54FEMTXL7KOLMF6TFTHRK6SSUSUZZ" ==
      uri.toString());
}

void testOperationFeeRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.operationFeeStats.buildUri();
  assert("https://horizon-testnet.stellar.org/operation_fee_stats" == uri.toString());
}

void testPathsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.paths
      .destinationAccount(KeyPair.fromAccountId("GB24QI3BJNKBY4YNJZ2I37HFIYK56BL2OURFML76X46RQQKDLVT7WKJF"))
      .sourceAccount(KeyPair.fromAccountId("GD4KO3IOYYWIYVI236Y35K2DU6VNYRH3BPNFJSH57J5BLLCQHBIOK3IN"))
      .destinationAmount("20.50")
      .destinationAsset(Asset.createNonNativeAsset("USD", KeyPair.fromAccountId("GAYSHLG75RPSMXWJ5KX7O7STE6RSZTD6NE4CTWAXFZYYVYIFRUVJIBJH")))
      .cursor("13537736921089")
      .limit(200)
      .order(RequestBuilderOrder.ASC)
      .buildUri();

  assert("https://horizon-testnet.stellar.org/paths?" +
      "destination_account=GB24QI3BJNKBY4YNJZ2I37HFIYK56BL2OURFML76X46RQQKDLVT7WKJF&" +
      "source_account=GD4KO3IOYYWIYVI236Y35K2DU6VNYRH3BPNFJSH57J5BLLCQHBIOK3IN&" +
      "destination_amount=20.50&" +
      "destination_asset_type=credit_alphanum4&" +
      "destination_asset_code=USD&" +
      "destination_asset_issuer=GAYSHLG75RPSMXWJ5KX7O7STE6RSZTD6NE4CTWAXFZYYVYIFRUVJIBJH&" +
      "cursor=13537736921089&" +
      "limit=200&" +
      "order=asc" == uri.toString());
}

//PaymentsRequestBuilder
void testPaymentsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.payments
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/payments?limit=200&order=desc" == uri.toString());
}

void testPaymentsRequestBuilderForAccount() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.payments
      .forAccount(KeyPair.fromAccountId("GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"))
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/accounts/GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H/payments?limit=200&order=desc" == uri.toString());
}

void testPaymentsRequestBuilderForLedger() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.payments
      .forLedger(200000000000)
      .limit(50)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/ledgers/200000000000/payments?limit=50&order=asc" == uri.toString());
}

void testPaymentsRequestBuilderForTransaction() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.payments
      .forTransaction("991534d902063b7715cd74207bef4e7bd7aa2f108f62d3eba837ce6023b2d4f3")
      .buildUri();
  assert("https://horizon-testnet.stellar.org/transactions/991534d902063b7715cd74207bef4e7bd7aa2f108f62d3eba837ce6023b2d4f3/payments" == uri.toString());
}
//PaymentsRequestBuilder

void testTradeAggregationsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.tradeAggregations(
      new AssetTypeNative(),
      Asset.createNonNativeAsset("BTC", KeyPair.fromAccountId("GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH")),
      1512689100000,
      1512775500000,
      300000,
      3600
  ).limit(200).order(RequestBuilderOrder.ASC).buildUri();

  assert("https://horizon-testnet.stellar.org/trade_aggregations?" +
      "base_asset_type=native&" +
      "counter_asset_type=credit_alphanum4&" +
      "counter_asset_code=BTC&" +
      "counter_asset_issuer=GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH&" +
      "start_time=1512689100000&" +
      "end_time=1512775500000&" +
      "resolution=300000&" +
      "offset=3600&" +
      "limit=200&" +
      "order=asc" == uri.toString());

}

//TradesRequestBuilder
void testTradesRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.trades
      .baseAsset(Asset.createNonNativeAsset("EUR", KeyPair.fromAccountId("GAUPA4HERNBDPVO4IUA3MJXBCRRK5W54EVXTDK6IIUTGDQRB6D5W242W")))
      .counterAsset(Asset.createNonNativeAsset("USD", KeyPair.fromAccountId("GDRRHSJMHXDTQBT4JTCILNGF5AS54FEMTXL7KOLMF6TFTHRK6SSUSUZZ")))
      .cursor("13537736921089")
      .limit(200)
      .order(RequestBuilderOrder.ASC)
      .buildUri();

  assert("https://horizon-testnet.stellar.org/trades?" +
      "base_asset_type=credit_alphanum4&" +
      "base_asset_code=EUR&" +
      "base_asset_issuer=GAUPA4HERNBDPVO4IUA3MJXBCRRK5W54EVXTDK6IIUTGDQRB6D5W242W&" +
      "counter_asset_type=credit_alphanum4&" +
      "counter_asset_code=USD&" +
      "counter_asset_issuer=GDRRHSJMHXDTQBT4JTCILNGF5AS54FEMTXL7KOLMF6TFTHRK6SSUSUZZ&" +
      "cursor=13537736921089&" +
      "limit=200&" +
      "order=asc" == uri.toString());
}

void testTradesRequestBuilderForAccount() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.trades
      .forAccount(KeyPair.fromAccountId("GDRRHSJMHXDTQBT4JTCILNGF5AS54FEMTXL7KOLMF6TFTHRK6SSUSUZZ"))
      .cursor("13537736921089")
      .limit(200)
      .order(RequestBuilderOrder.ASC)
      .buildUri();

  assert("https://horizon-testnet.stellar.org/accounts/GDRRHSJMHXDTQBT4JTCILNGF5AS54FEMTXL7KOLMF6TFTHRK6SSUSUZZ/trades?" +
      "cursor=13537736921089&" +
      "limit=200&" +
      "order=asc" == uri.toString());
}
//TradesRequestBuilder


//TransactionsRequestBuilder
void testTransactionsRequestBuilder() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.transactions
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/transactions?limit=200&order=desc" == uri.toString());
}

void testTransactionsRequestBuilderForAccount() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.transactions
      .forAccount(KeyPair.fromAccountId("GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H"))
      .limit(200)
      .order(RequestBuilderOrder.DESC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/accounts/GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H/transactions?limit=200&order=desc" == uri.toString());
}

void testTransactionsRequestBuilderForLedger() {
  Server server = new Server("https://horizon-testnet.stellar.org");
  Uri uri = server.transactions
      .forLedger(200000000000)
      .limit(50)
      .order(RequestBuilderOrder.ASC)
      .buildUri();
  assert("https://horizon-testnet.stellar.org/ledgers/200000000000/transactions?limit=50&order=asc" == uri.toString());
}
//TransactionsRequestBuilder

void main() {
  testAccountsRequestBuilder();
  testAssetsRequestBuilder();

  testEffectsRequestBuilder();
  testEffectsRequestBuilderForAccount();
  testEffectsRequestBuilderForLedger();
  testEffectsRequestBuilderForTransaction();
  testEffectsRequestBuilderForOperation();

  testLedgersRequestBuilder();
  testOffersRequestBuilderForAccount();

  testOperationsRequestBuilder();
  testOperationsRequestBuilderForAccount();
  testOperationsRequestBuilderForLedger();
  testOperationsRequestBuilderForTransaction();

  testOrderBookRequestBuilder();
  testOperationFeeRequestBuilder(); //?
  testPathsRequestBuilder();

  testPaymentsRequestBuilder();
  testPaymentsRequestBuilderForAccount();
  testPaymentsRequestBuilderForLedger();
  testPaymentsRequestBuilderForTransaction();

  testTradeAggregationsRequestBuilder();

  testTradesRequestBuilder();
  testTradesRequestBuilderForAccount();

  testTransactionsRequestBuilder();
  testTransactionsRequestBuilderForAccount();
  testTransactionsRequestBuilderForLedger();
}