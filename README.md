Stellar client library for Dart developers.

## Usage

A simple usage example:

```dart
import 'package:stellar/stellar.dart';
import 'package:http/http.dart' as http;

void createKey() {
  KeyPair pair = KeyPair.random();
  print("Account Id  : " + pair.accountId);
  print("Secret Seed : " + pair.secretSeed);
}

void createTestAccount(String accountId) {
  var url = "https://friendbot.stellar.org/?addr=${accountId}";
  http.get(url).then((response) {
    switch (response.statusCode) {
      case 200:
        {
          print("SUCCESS! You have a new account : \n${response.body}");
          print("Response body: ${response.body}");
          break;
        }
      default:
        {
          print("ERROR! : \n${response.body}");
        }
    }
  });
}

void getAccountDetails(String accountId) {
  KeyPair pair = KeyPair.fromAccountId(accountId);

  Network.useTestNetwork();
  Server server = Server("https://horizon-testnet.stellar.org");
  server.accounts.account(pair).then((account) {
    print("Balances for account: ${pair.accountId}");

    for (Balance balance in account.balances) {
      print(
          "Type: ${balance.assetType}, Code: ${balance.assetCode}, Balance: ${balance.balance}");

      switch (balance.assetType) {
        case "native":
          {
            print("balance: ${balance.balance} XLM");
            break;
          }
        default:
          {
            print(
                "balance: ${balance.balance} ${balance.assetCode} issuer: ${balance.assetIssuer}");
          }
      }

      print("sequence number: ${account.sequenceNumber}");

      for (Signer signer in account.signers) {
        print("signer public key: ${signer.accountId}");
      }

      print("auth required: ${account.flags.authRequired}");
      print("auth revocable: ${account.flags.authRevocable}");

      for (String key in account.data.keys) {
        print("data key: ${key} value: ${account.data[key]}");
      }
    }
  });
}

void getAccountTransactions(String accountId) {
  KeyPair pair = KeyPair.fromAccountId(accountId);

  Network.useTestNetwork();
  Server server = Server("https://horizon-testnet.stellar.org");
  server.transactions
      .forAccount(pair)
      .order(RequestBuilderOrder.DESC)
      .limit(200)
      .execute()
      .then((page) {
    for (TransactionResponse transactionResponse in page.records) {
      print(transactionResponse);
    }
  });
}

void sendPayment() {
  Network.useTestNetwork();
  Server server = new Server("https://horizon-testnet.stellar.org");

  KeyPair source = KeyPair.fromSecretSeed(
      "SB7IAVKZJCK2T5TAN4F25TC7XGFB4BVLRPFJUT662Y2RK4MK7NAT4FO2");
  KeyPair destination = KeyPair.fromAccountId(
      "GDNHJLN2WQ7HP6TPZK6SPU273TG6P3RLOPR6FWMC57HVJRB3SVE7F7G3");

  server.accounts.account(source).then((sourceAccount) {
    Transaction transaction = new TransactionBuilder(sourceAccount)
        .addOperation(new PaymentOperationBuilder(
                destination, new AssetTypeNative(), "10")
            .build())
        .addMemo(Memo.text("Test Transaction"))
        .build();
    transaction.sign(source);

    server.submitTransaction(transaction).then((response) {
      print("Success!");
      print(response);
    }).catchError((error) {
      print("Something went wrong!");
    });
  });
}

void paymentStream() {
  Network.useTestNetwork();
  Server server = new Server("https://horizon-testnet.stellar.org");

  KeyPair destination = KeyPair.fromAccountId(
      "GDNHJLN2WQ7HP6TPZK6SPU273TG6P3RLOPR6FWMC57HVJRB3SVE7F7G3");

  server.payments.forAccount(destination).stream().listen((response) {
    if (response is PaymentOperationResponse) {
      switch (response.assetType) {
        case "native":
          print(
              "Payment of ${response.amount} XLM from ${response.sourceAccount.accountId} received");
          break;
        default:
          print(
              "Payment of ${response.amount} ${response.assetCode} from ${response.sourceAccount.accountId}");
      }
    }
  });
}

/*
Account Id  : GBHHJLRSEWACDUMZPGNEFVTMYW34OJIGOACK3H7WMKA3FQBHSHJPN5TC
Secret Seed : SB7IAVKZJCK2T5TAN4F25TC7XGFB4BVLRPFJUT662Y2RK4MK7NAT4FO2

Account Id  : GDNHJLN2WQ7HP6TPZK6SPU273TG6P3RLOPR6FWMC57HVJRB3SVE7F7G3
Secret Seed : SAACNKL2BBFVU7BVAVI2EIYSZQPQANZNYBVYUR7RFWTTRTOB6FPDR4NY
 */

void main() {
  createKey();
  createTestAccount("GBHHJLRSEWACDUMZPGNEFVTMYW34OJIGOACK3H7WMKA3FQBHSHJPN5TC");
  getAccountDetails("GBHHJLRSEWACDUMZPGNEFVTMYW34OJIGOACK3H7WMKA3FQBHSHJPN5TC");
  getAccountTransactions("GDNHJLN2WQ7HP6TPZK6SPU273TG6P3RLOPR6FWMC57HVJRB3SVE7F7G3");
  sendPayment();
  paymentStream();
}

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/jspschool/dart-stellar-sdk/issues
