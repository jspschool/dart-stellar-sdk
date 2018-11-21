import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:stellar/stellar.dart';

void testNoDefaultNetwork() {
  assert(Network.current() == null);
}

void testSwitchToTestNetwork() {
  Network.useTestNetwork();
  assert("Test SDF Network ; September 2015" ==
      Network.current().networkPassphrase);
}

void testSwitchToPublicNetwork() {
  Network.usePublicNetwork();
  assert("Public Global Stellar Network ; September 2015" ==
      Network.current().networkPassphrase);
}

final String successResponse = "{\n" +
    "  \"_links\": {\n" +
    "    \"transaction\": {\n" +
    "      \"href\": \"/transactions/2634d2cf5adcbd3487d1df042166eef53830115844fdde1588828667bf93ff42\"\n" +
    "    }\n" +
    "  },\n" +
    "  \"hash\": \"2634d2cf5adcbd3487d1df042166eef53830115844fdde1588828667bf93ff42\",\n" +
    "  \"ledger\": 826150,\n" +
    "  \"envelope_xdr\": \"AAAAAKu3N77S+cHLEDfVD2eW/CqRiN9yvAKH+qkeLjHQs1u+AAAAZAAMkoMAAAADAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAbYQq8ek1GitmNBUloGnetfWxSpxlsgK48Xi66dIL3MoAAAAAC+vCAAAAAAAAAAAB0LNbvgAAAEDadQ25SNHWTg0L+2wr/KNWd8/EwSNFkX/ncGmBGA3zkNGx7lAow78q8SQmnn2IsdkD9MwICirhsOYDNbaqShwO\",\n" +
    "  \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=\",\n" +
    "  \"result_meta_xdr\": \"AAAAAAAAAAEAAAACAAAAAAAMmyYAAAAAAAAAAG2EKvHpNRorZjQVJaBp3rX1sUqcZbICuPF4uunSC9zKAAAAAAvrwgAADJsmAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAMmyYAAAAAAAAAAKu3N77S+cHLEDfVD2eW/CqRiN9yvAKH+qkeLjHQs1u+AAAAFzCfYtQADJKDAAAAAwAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\"\n" +
    "}";

final String failureResponse = "{\n" +
    "  \"type\": \"https://stellar.org/horizon-errors/transaction_failed\",\n" +
    "  \"title\": \"Transaction Failed\",\n" +
    "  \"status\": 400,\n" +
    "  \"detail\": \"TODO\",\n" +
    "  \"instance\": \"horizon-testnet-001.prd.stellar001.internal.stellar-ops.com/IxhaI70Tqo-112305\",\n" +
    "  \"extras\": {\n" +
    "    \"envelope_xdr\": \"AAAAAK4Pg4OEkjGmSN0AN37K/dcKyKPT2DC90xvjjawKp136AAAAZAAKsZQAAAABAAAAAAAAAAEAAAAJSmF2YSBGVFchAAAAAAAAAQAAAAAAAAABAAAAAG9wfBI7rRYoBlX3qRa0KOnI75W5BaPU6NbyKmm2t71MAAAAAAAAAAABMS0AAAAAAAAAAAEKp136AAAAQOWEjL+Sm+WP2puE9dLIxWlOibIEOz8PsXyG77jOCVdHZfQvkgB49Mu5wqKCMWWIsDSLFekwUsLaunvmXrpyBwQ=\",\n" +
    "    \"result_codes\": {\n" +
    "      \"transaction\": \"tx_failed\",\n" +
    "      \"operations\": [\n" +
    "        \"op_no_destination\"\n" +
    "      ]\n" +
    "    },\n" +
    "    \"result_xdr\": \"AAAAAAAAAGT/////AAAAAQAAAAAAAAAB////+wAAAAA=\"\n" +
    "  }\n" +
    "}";

final String timeoutResponse = "{\n" +
    "  \"type\": \"https://stellar.org/horizon-errors/transaction_failed\",\n" +
    "  \"title\": \"Timeout\",\n" +
    "  \"status\": 403,\n" +
    "  \"detail\": \"TODO\",\n" +
    "  \"instance\": \"horizon-testnet-001.prd.stellar001.internal.stellar-ops.com/IxhaI70Tqo-112305\"\n" +
    "}";

final String internalServerErrorResponse = "{\n" +
    "  \"type\":     \"https://www.stellar.org/docs/horizon/problems/server_error\",\n" +
    "  \"title\":    \"Internal Server Error\",\n" +
    "  \"status\":   500,\n" +
    "  \"instance\": \"d3465740-ec3a-4a0b-9d4a-c9ea734ce58a\"\n" +
    "}";

final String operationsPageResponse = "{\n" +
    "  \"_links\": {\n" +
    "    \"self\": {\n" +
    "      \"href\": \"http://horizon-testnet.stellar.org/operations?order=desc\\u0026limit=10\\u0026cursor=\"\n" +
    "    },\n" +
    "    \"next\": {\n" +
    "      \"href\": \"http://horizon-testnet.stellar.org/operations?order=desc\\u0026limit=10\\u0026cursor=3695540185337857\"\n" +
    "    },\n" +
    "    \"prev\": {\n" +
    "      \"href\": \"http://horizon-testnet.stellar.org/operations?order=asc\\u0026limit=10\\u0026cursor=3717508943056897\"\n" +
    "    }\n" +
    "  },\n" +
    "  \"_embedded\": {\n" +
    "    \"records\": [\n" +
    "      {\n" +
    "        \"_links\": {\n" +
    "          \"self\": {\n" +
    "            \"href\": \"http://horizon-testnet.stellar.org/operations/3717508943056897\"\n" +
    "          },\n" +
    "          \"transaction\": {\n" +
    "            \"href\": \"http://horizon-testnet.stellar.org/transactions/ce81d957352501a46d9b938462cbef76283dcba8108d2649e0d79279a8f36488\"\n" +
    "          },\n" +
    "          \"effects\": {\n" +
    "            \"href\": \"http://horizon-testnet.stellar.org/operations/3717508943056897/effects\"\n" +
    "          },\n" +
    "          \"succeeds\": {\n" +
    "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3717508943056897\"\n" +
    "          },\n" +
    "          \"precedes\": {\n" +
    "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3717508943056897\"\n" +
    "          }\n" +
    "        },\n" +
    "        \"id\": \"3717508943056897\",\n" +
    "        \"paging_token\": \"3717508943056897\",\n" +
    "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
    "        \"type\": \"create_account\",\n" +
    "        \"type_i\": 0,\n" +
    "        \"created_at\": \"2018-01-22T21:30:53Z\",\n" +
    "        \"transaction_hash\": \"dd9d10c80a344f4464df3ecaa63705a5ef4a0533ff2f2099d5ef371ab5e1c046\"," +
    "        \"starting_balance\": \"10000.0\",\n" +
    "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
    "        \"account\": \"GDFH4NIYMIIAKRVEJJZOIGWKXGQUF3XHJG6ZM6CEA64AMTVDN44LHOQE\"\n" +
    "      }\n" +
    "    ]\n" +
    "  }\n" +
    "}";

Transaction buildTransaction() {
  KeyPair source = KeyPair.fromSecretSeed(
      "SCH27VUZZ6UAKB67BDNF6FA42YMBMQCBKXWGMFD5TZ6S5ZZCZFLRXKHS");
  KeyPair destination = KeyPair.fromAccountId(
      "GDW6AUTBXTOC7FIKUO5BOO3OGLK4SF7ZPOBLMQHMZDI45J2Z6VXRB5NR");

  Account account = new Account(source, 2908908335136768);
  TransactionBuilder builder = new TransactionBuilder(account)
      .addOperation(
          new CreateAccountOperationBuilder(destination, "2000").build())
      .addMemo(Memo.text("Hello world!"));

  assert(1 == builder.operationsCount);
  Transaction transaction = builder.build();
  assert(2908908335136769 == transaction.sequenceNumber);
  assert(2908908335136769 == account.sequenceNumber);
  transaction.sign(source);
  return transaction;
}

void testSubmitTransactionSuccess() {
  var client = new MockClient((request) {
    return new Future.value(http.Response(successResponse, 200,
        request: request, headers: {'content-type': 'application/json'}));
  });

  Server server = new Server("https://horizon-testnet.stellar.org");
  server.httpClient = client;

  server
      .submitTransaction(buildTransaction())
      .then<SubmitTransactionResponse>((response) {
    assert(response.success);
    assert(response.ledger == 826150);
    assert(response.hash ==
        "2634d2cf5adcbd3487d1df042166eef53830115844fdde1588828667bf93ff42");
    assert(response.envelopeXdr ==
        "AAAAAKu3N77S+cHLEDfVD2eW/CqRiN9yvAKH+qkeLjHQs1u+AAAAZAAMkoMAAAADAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAbYQq8ek1GitmNBUloGnetfWxSpxlsgK48Xi66dIL3MoAAAAAC+vCAAAAAAAAAAAB0LNbvgAAAEDadQ25SNHWTg0L+2wr/KNWd8/EwSNFkX/ncGmBGA3zkNGx7lAow78q8SQmnn2IsdkD9MwICirhsOYDNbaqShwO");
    assert(
        response.resultXdr == "AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=");
    assert(response.extras == null);
  });
}

void testSubmitTransactionFail() {
  var client = new MockClient((request) {
    return new Future.value(http.Response(failureResponse, 400,
        request: request, headers: {'content-type': 'application/json'}));
  });

  Server server = new Server("https://horizon-testnet.stellar.org");
  server.httpClient = client;

  server
      .submitTransaction(buildTransaction())
      .then<SubmitTransactionResponse>((response) {
    assert(response.success == false);
    assert(response.ledger == null);
    assert(response.hash == null);
    assert(response.extras.envelopeXdr ==
        "AAAAAK4Pg4OEkjGmSN0AN37K/dcKyKPT2DC90xvjjawKp136AAAAZAAKsZQAAAABAAAAAAAAAAEAAAAJSmF2YSBGVFchAAAAAAAAAQAAAAAAAAABAAAAAG9wfBI7rRYoBlX3qRa0KOnI75W5BaPU6NbyKmm2t71MAAAAAAAAAAABMS0AAAAAAAAAAAEKp136AAAAQOWEjL+Sm+WP2puE9dLIxWlOibIEOz8PsXyG77jOCVdHZfQvkgB49Mu5wqKCMWWIsDSLFekwUsLaunvmXrpyBwQ=");
    assert(response.envelopeXdr ==
        "AAAAAK4Pg4OEkjGmSN0AN37K/dcKyKPT2DC90xvjjawKp136AAAAZAAKsZQAAAABAAAAAAAAAAEAAAAJSmF2YSBGVFchAAAAAAAAAQAAAAAAAAABAAAAAG9wfBI7rRYoBlX3qRa0KOnI75W5BaPU6NbyKmm2t71MAAAAAAAAAAABMS0AAAAAAAAAAAEKp136AAAAQOWEjL+Sm+WP2puE9dLIxWlOibIEOz8PsXyG77jOCVdHZfQvkgB49Mu5wqKCMWWIsDSLFekwUsLaunvmXrpyBwQ=");
    assert(response.extras.resultXdr ==
        "AAAAAAAAAGT/////AAAAAQAAAAAAAAAB////+wAAAAA=");
    assert(
        response.resultXdr == "AAAAAAAAAGT/////AAAAAQAAAAAAAAAB////+wAAAAA=");
    assert(response.extras != null);
    assert("tx_failed" == response.extras.resultCodes.transactionResultCode);
    assert("op_no_destination" ==
        response.extras.resultCodes.operationsResultCodes[0]);
  });
}

void testSubmitTransactionInternalError() {
  var client = new MockClient((request) {
    return new Future.value(http.Response(internalServerErrorResponse, 500,
        request: request, headers: {'content-type': 'application/json'}));
  });

  Server server = new Server("https://horizon-testnet.stellar.org");
  server.httpClient = client;

  server
      .submitTransaction(buildTransaction())
      .then<SubmitTransactionResponse>((response) {
    throw Exception("submitTransaction didn't throw exception");
  }).catchError((onError) {
    if (onError is SubmitTransactionUnknownResponseException) {
      assert(500 == onError.code);
    } else {
      throw onError;
    }
  });
  ;
}

void testNextPage() {
  var client = new MockClient((request) {
    return new Future.value(http.Response(operationsPageResponse, 200,
        request: request, headers: {'content-type': 'application/json'}));
  });

  var client2 = new MockClient((request) {
    return new Future.value(http.Response(operationsPageResponse, 200,
        request: request, headers: {'content-type': 'application/json'}));
  });

  Server server = new Server("https://horizon-testnet.stellar.org");
  server.httpClient = client;

   server.operations.execute().then<Page<OperationResponse>>((page){
     assert(1 == page.records.length);
     assert("dd9d10c80a344f4464df3ecaa63705a5ef4a0533ff2f2099d5ef371ab5e1c046" ==
         page.records[0].transactionHash);
     page.getNextPage(client2).then((page){
       assert(1 == page.records.length);
     });

   });

}

void main() {
  testNoDefaultNetwork();
  Network.use(null);
  testSwitchToTestNetwork();
  Network.use(null);
  testSwitchToPublicNetwork();
  Network.use(null);

  Network.useTestNetwork();
  testSubmitTransactionSuccess();
  testSubmitTransactionFail();
  testSubmitTransactionInternalError();
  testNextPage();
}
