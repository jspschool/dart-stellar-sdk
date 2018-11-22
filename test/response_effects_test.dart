import 'package:stellar/stellar.dart';
import 'dart:convert';

void testDeserializeAccountCreatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/65571265847297\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=65571265847297-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=65571265847297-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000065571265847297-0000000001\",\n" +
      "        \"paging_token\": \"65571265847297-1\",\n" +
      "        \"account\": \"GCBQ6JRBPF3SXQBQ6SO5MRBE7WVV4UCHYOSHQGXSZNPZLFRYVYOWBZRQ\",\n" +
      "        \"type\": \"account_created\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"30.0\"\n" +
      "      }";

  AccountCreatedEffectResponse effect =
      AccountCreatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GCBQ6JRBPF3SXQBQ6SO5MRBE7WVV4UCHYOSHQGXSZNPZLFRYVYOWBZRQ");
  assert(effect.startingBalance == "30.0");
  assert(effect.pagingToken == "65571265847297-1");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/65571265847297");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=65571265847297-1");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=65571265847297-1");
}

void testDeserializeAccountRemovedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/65571265847297\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=65571265847297-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=65571265847297-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000065571265847297-0000000001\",\n" +
      "        \"paging_token\": \"65571265847297-1\",\n" +
      "        \"account\": \"GCBQ6JRBPF3SXQBQ6SO5MRBE7WVV4UCHYOSHQGXSZNPZLFRYVYOWBZRQ\",\n" +
      "        \"type\": \"account_removed\",\n" +
      "        \"type_i\": 1\n" +
      "      }";

  AccountRemovedEffectResponse effect =
      AccountRemovedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GCBQ6JRBPF3SXQBQ6SO5MRBE7WVV4UCHYOSHQGXSZNPZLFRYVYOWBZRQ");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/65571265847297");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=65571265847297-1");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=65571265847297-1");
}

void testDeserializeAccountCreditedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/13563506724865\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=13563506724865-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=13563506724865-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000013563506724865-0000000001\",\n" +
      "        \"paging_token\": \"13563506724865-1\",\n" +
      "        \"account\": \"GDLGTRIBFH24364GPWPUS45GUFC2GU4ARPGWTXVCPLGTUHX3IOS3ON47\",\n" +
      "        \"type\": \"account_credited\",\n" +
      "        \"type_i\": 2,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"amount\": \"1000.0\"\n" +
      "      }";

  AccountCreditedEffectResponse effect =
      AccountCreditedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GDLGTRIBFH24364GPWPUS45GUFC2GU4ARPGWTXVCPLGTUHX3IOS3ON47");
  assert(effect.asset == new AssetTypeNative());
  assert(effect.amount == "1000.0");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/13563506724865");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=13563506724865-1");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=13563506724865-1");
}

void testDeserializeAccountDebitedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/65571265843201\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=65571265843201-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=65571265843201-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000065571265843201-0000000002\",\n" +
      "        \"paging_token\": \"65571265843201-2\",\n" +
      "        \"account\": \"GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H\",\n" +
      "        \"type\": \"account_debited\",\n" +
      "        \"type_i\": 3,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"amount\": \"30.0\"\n" +
      "      }";

  AccountDebitedEffectResponse effect =
      AccountDebitedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H");
  assert(effect.asset == new AssetTypeNative());
  assert(effect.amount == "30.0");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/65571265843201");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=65571265843201-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=65571265843201-2");
}

void testDeserializeAccountThresholdsUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/18970870550529\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=18970870550529-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=18970870550529-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000018970870550529-0000000001\",\n" +
      "        \"paging_token\": \"18970870550529-1\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"low_threshold\": 2,\n" +
      "        \"med_threshold\": 3,\n" +
      "        \"high_threshold\": 4,\n" +
      "        \"type\": \"account_thresholds_updated\",\n" +
      "        \"type_i\": 4\n" +
      "      }";

  AccountThresholdsUpdatedEffectResponse effect =
      AccountThresholdsUpdatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.lowThreshold == 2);
  assert(effect.medThreshold == 3);
  assert(effect.highThreshold == 4);

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/18970870550529");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=18970870550529-1");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=18970870550529-1");
}

void testDeserializeAccountHomeDomainUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/18970870550529\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=18970870550529-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=18970870550529-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000018970870550529-0000000001\",\n" +
      "        \"paging_token\": \"18970870550529-1\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"account_home_domain_updated\",\n" +
      "        \"type_i\": 5,\n" +
      "        \"home_domain\": \"stellar.org\"\n" +
      "      }";

  AccountHomeDomainUpdatedEffectResponse effect =
      AccountHomeDomainUpdatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.homeDomain == "stellar.org");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/18970870550529");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=18970870550529-1");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=18970870550529-1");
}

void testDeserializeAccountFlagsUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/18970870550529\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=18970870550529-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=18970870550529-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000018970870550529-0000000001\",\n" +
      "        \"paging_token\": \"18970870550529-1\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"account_flags_updated\",\n" +
      "        \"type_i\": 6,\n" +
      "        \"auth_required_flag\": false,\n" +
      "        \"auth_revokable_flag\": true\n" +
      "      }";

  AccountFlagsUpdatedEffectResponse effect =
      AccountFlagsUpdatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.authRequiredFlag == false);
  assert(effect.authRevokableFlag == true);

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/18970870550529");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=18970870550529-1");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=18970870550529-1");
}

void testDeserializeAccountInflationDestinationUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/operations/40181321724596225\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=desc&cursor=40181321724596225-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=asc&cursor=40181321724596225-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0040181321724596225-0000000001\",\n" +
      "        \"paging_token\": \"40181321724596225-1\",\n" +
      "        \"account\": \"GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF\",\n" +
      "        \"type\": \"account_inflation_destination_updated\",\n" +
      "        \"type_i\": 7,\n" +
      "        \"created_at\": \"2018-06-06T10:20:50Z\"\n" +
      "      }";

  AccountInflationDestinationUpdatedEffectResponse effect =
      AccountInflationDestinationUpdatedEffectResponse.fromJson(
          json.decode(jsonData));

  assert(effect.account.accountId ==
      "GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF");
  assert(effect.createdAt == "2018-06-06T10:20:50Z");
}

void testDeserializeSignerCreatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/65571265859585\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=65571265859585-3\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=65571265859585-3\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000065571265859585-0000000003\",\n" +
      "        \"paging_token\": \"65571265859585-3\",\n" +
      "        \"account\": \"GB24LPGAHYTWRYOXIDKXLI55SBRWW42T3TZKDAAW3BOJX4ADVIATFTLU\",\n" +
      "        \"type\": \"signer_created\",\n" +
      "        \"type_i\": 10,\n" +
      "        \"weight\": 1,\n" +
      "        \"public_key\": \"GB24LPGAHYTWRYOXIDKXLI55SBRWW42T3TZKDAAW3BOJX4ADVIATFTLU\"\n" +
      "      }";

  SignerCreatedEffectResponse effect =
      SignerCreatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GB24LPGAHYTWRYOXIDKXLI55SBRWW42T3TZKDAAW3BOJX4ADVIATFTLU");
  assert(effect.weight == 1);
  assert(effect.publicKey ==
      "GB24LPGAHYTWRYOXIDKXLI55SBRWW42T3TZKDAAW3BOJX4ADVIATFTLU");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/65571265859585");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=65571265859585-3");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=65571265859585-3");
}

void testDeserializeSignerRemovedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/43658342567940\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=43658342567940-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=43658342567940-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000043658342567940-0000000002\",\n" +
      "        \"paging_token\": \"43658342567940-2\",\n" +
      "        \"account\": \"GCFKT6BN2FEASCEVDNHEC4LLFT2KLUUPEMKM4OJPEJ65H2AEZ7IH4RV6\",\n" +
      "        \"type\": \"signer_removed\",\n" +
      "        \"type_i\": 11,\n" +
      "        \"weight\": 0,\n" +
      "        \"public_key\": \"GCFKT6BN2FEASCEVDNHEC4LLFT2KLUUPEMKM4OJPEJ65H2AEZ7IH4RV6\"\n" +
      "      }";

  SignerRemovedEffectResponse effect =
      SignerRemovedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GCFKT6BN2FEASCEVDNHEC4LLFT2KLUUPEMKM4OJPEJ65H2AEZ7IH4RV6");
  assert(effect.weight == 0);
  assert(effect.publicKey ==
      "GCFKT6BN2FEASCEVDNHEC4LLFT2KLUUPEMKM4OJPEJ65H2AEZ7IH4RV6");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/43658342567940");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=43658342567940-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=43658342567940-2");
}

void testDeserializeSignerUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"signer_updated\",\n" +
      "        \"type_i\": 12,\n" +
      "        \"weight\": 2,\n" +
      "        \"public_key\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\"\n" +
      "      }";

  SignerUpdatedEffectResponse effect =
      SignerUpdatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.weight == 2);
  assert(effect.publicKey ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeTrustlineCreatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"trustline_created\",\n" +
      "        \"type_i\": 20,\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"EUR\",\n" +
      "        \"asset_issuer\": \"GAZN3PPIDQCSP5JD4ETQQQ2IU2RMFYQTAL4NNQZUGLLO2XJJJ3RDSDGA\",\n" +
      "        \"limit\": \"1000.0\"\n" +
      "      }";

  TrustlineCreatedEffectResponse effect =
      TrustlineCreatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.asset ==
      Asset.createNonNativeAsset(
          "EUR",
          KeyPair.fromAccountId(
              "GAZN3PPIDQCSP5JD4ETQQQ2IU2RMFYQTAL4NNQZUGLLO2XJJJ3RDSDGA")));
  assert(effect.limit == "1000.0");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeTrustlineRemovedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"trustline_removed\",\n" +
      "        \"type_i\": 21,\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"EUR\",\n" +
      "        \"asset_issuer\": \"GAZN3PPIDQCSP5JD4ETQQQ2IU2RMFYQTAL4NNQZUGLLO2XJJJ3RDSDGA\",\n" +
      "        \"limit\": \"0.0\"\n" +
      "      }";

  TrustlineRemovedEffectResponse effect =
      TrustlineRemovedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.asset ==
      Asset.createNonNativeAsset(
          "EUR",
          KeyPair.fromAccountId(
              "GAZN3PPIDQCSP5JD4ETQQQ2IU2RMFYQTAL4NNQZUGLLO2XJJJ3RDSDGA")));
  assert(effect.limit == "0.0");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeTrustlineUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"trustline_updated\",\n" +
      "        \"type_i\": 22,\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"TESTTEST\",\n" +
      "        \"asset_issuer\": \"GAZN3PPIDQCSP5JD4ETQQQ2IU2RMFYQTAL4NNQZUGLLO2XJJJ3RDSDGA\",\n" +
      "        \"limit\": \"100.0\"\n" +
      "      }";

  TrustlineUpdatedEffectResponse effect =
      TrustlineUpdatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.asset ==
      Asset.createNonNativeAsset(
          "TESTTEST",
          KeyPair.fromAccountId(
              "GAZN3PPIDQCSP5JD4ETQQQ2IU2RMFYQTAL4NNQZUGLLO2XJJJ3RDSDGA")));
  assert(effect.limit == "100.0");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeTrustlineAuthorizedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"trustline_authorized\",\n" +
      "        \"type_i\": 23,\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"TESTTEST\",\n" +
      "        \"trustor\": \"GB3E4AB4VWXJDUVN4Z3CPBU5HTMWVEQXONZYVDFMHQD6333KHCOL3UBR\"\n" +
      "      }";

  TrustlineAuthorizedEffectResponse effect =
      TrustlineAuthorizedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.assetType == "credit_alphanum12");
  assert(effect.assetCode == "TESTTEST");
  assert(effect.trustor.accountId ==
      "GB3E4AB4VWXJDUVN4Z3CPBU5HTMWVEQXONZYVDFMHQD6333KHCOL3UBR");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeTrustlineDeauthorizedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"trustline_deauthorized\",\n" +
      "        \"type_i\": 24,\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"EUR\",\n" +
      "        \"trustor\": \"GB3E4AB4VWXJDUVN4Z3CPBU5HTMWVEQXONZYVDFMHQD6333KHCOL3UBR\"\n" +
      "      }";

  TrustlineDeauthorizedEffectResponse effect =
      TrustlineDeauthorizedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.assetType == "credit_alphanum4");
  assert(effect.assetCode == "EUR");
  assert(effect.trustor.accountId ==
      "GB3E4AB4VWXJDUVN4Z3CPBU5HTMWVEQXONZYVDFMHQD6333KHCOL3UBR");

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeTradeEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/33788507721730\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=33788507721730-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=33788507721730-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0000033788507721730-0000000002\",\n" +
      "        \"paging_token\": \"33788507721730-2\",\n" +
      "        \"account\": \"GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO\",\n" +
      "        \"type\": \"trade\",\n" +
      "        \"type_i\": 33,\n" +
      "        \"seller\": \"GCVHDLN6EHZBYW2M3BQIY32C23E4GPIRZZDBNF2Q73DAZ5VJDRGSMYRB\",\n" +
      "        \"offer_id\": 1,\n" +
      "        \"sold_amount\": \"1000.0\",\n" +
      "        \"sold_asset_type\": \"credit_alphanum4\",\n" +
      "        \"sold_asset_code\": \"EUR\",\n" +
      "        \"sold_asset_issuer\": \"GCWVFBJ24754I5GXG4JOEB72GJCL3MKWC7VAEYWKGQHPVH3ENPNBSKWS\",\n" +
      "        \"bought_amount\": \"60.0\",\n" +
      "        \"bought_asset_type\": \"credit_alphanum12\",\n" +
      "        \"bought_asset_code\": \"TESTTEST\",\n" +
      "        \"bought_asset_issuer\": \"GAHXPUDP3AK6F2QQM4FIRBGPNGKLRDDSTQCVKEXXKKRHJZUUQ23D5BU7\"\n" +
      "      }";

  TradeEffectResponse effect =
      TradeEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GA6U5X6WOPNKKDKQULBR7IDHDBAQKOWPHYEC7WSXHZBFEYFD3XVZAKOO");
  assert(effect.seller.accountId ==
      "GCVHDLN6EHZBYW2M3BQIY32C23E4GPIRZZDBNF2Q73DAZ5VJDRGSMYRB");
  assert(effect.offerId == 1);
  assert(effect.soldAmount == "1000.0");
  assert(effect.soldAsset ==
      Asset.createNonNativeAsset(
          "EUR",
          KeyPair.fromAccountId(
              "GCWVFBJ24754I5GXG4JOEB72GJCL3MKWC7VAEYWKGQHPVH3ENPNBSKWS")));
  assert(effect.boughtAmount == "60.0");
  assert(effect.boughtAsset ==
      Asset.createNonNativeAsset(
          "TESTTEST",
          KeyPair.fromAccountId(
              "GAHXPUDP3AK6F2QQM4FIRBGPNGKLRDDSTQCVKEXXKKRHJZUUQ23D5BU7")));

  assert(effect.links.operation.href ==
      "http://horizon-testnet.stellar.org/operations/33788507721730");
  assert(effect.links.succeeds.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&cursor=33788507721730-2");
  assert(effect.links.precedes.href ==
      "http://horizon-testnet.stellar.org/effects?order=asc&cursor=33788507721730-2");
}

void testDeserializeDataCreatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/operations/40181480638386177\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=desc&cursor=40181480638386177-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=asc&cursor=40181480638386177-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0040181480638386177-0000000001\",\n" +
      "        \"paging_token\": \"40181480638386177-1\",\n" +
      "        \"account\": \"GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF\",\n" +
      "        \"type\": \"data_created\",\n" +
      "        \"type_i\": 40,\n" +
      "        \"created_at\": \"2018-06-06T10:23:57Z\"\n" +
      "      }";

  DataCreatedEffectResponse effect =
      DataCreatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF");
  assert(effect.createdAt == "2018-06-06T10:23:57Z");
}

void testDeserializeDataRemovedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/operations/40181480638386177\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=desc&cursor=40181480638386177-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=asc&cursor=40181480638386177-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0040181480638386177-0000000001\",\n" +
      "        \"paging_token\": \"40181480638386177-1\",\n" +
      "        \"account\": \"GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF\",\n" +
      "        \"type\": \"data_removed\",\n" +
      "        \"type_i\": 41,\n" +
      "        \"created_at\": \"2018-06-06T10:23:57Z\"\n" +
      "      }";

  DataRemovedEffectResponse effect =
      DataRemovedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF");
  assert(effect.createdAt == "2018-06-06T10:23:57Z");
}

void testDeserializeDataUpdatedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/operations/40181480638386177\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=desc&cursor=40181480638386177-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=asc&cursor=40181480638386177-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0040181480638386177-0000000001\",\n" +
      "        \"paging_token\": \"40181480638386177-1\",\n" +
      "        \"account\": \"GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF\",\n" +
      "        \"type\": \"data_updated\",\n" +
      "        \"type_i\": 42,\n" +
      "        \"created_at\": \"2018-06-06T10:23:57Z\"\n" +
      "      }";

  DataUpdatedEffectResponse effect =
      DataUpdatedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF");
  assert(effect.createdAt == "2018-06-06T10:23:57Z");
}

void testDeserializeSequenceBumpedEffect() {
  String jsonData = "{\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/operations/40181480638386177\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=desc&cursor=40181480638386177-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/effects?order=asc&cursor=40181480638386177-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0040181480638386177-0000000001\",\n" +
      "        \"paging_token\": \"40181480638386177-1\",\n" +
      "        \"account\": \"GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF\",\n" +
      "        \"type\": \"sequence_bumped\",\n" +
      "        \"type_i\": 43,\n" +
      "        \"new_seq\": \"79473726952833048\",\n" +
      "        \"created_at\": \"2018-06-06T10:23:57Z\"\n" +
      "      }";

  SequenceBumpedEffectResponse effect =
      SequenceBumpedEffectResponse.fromJson(json.decode(jsonData));

  assert(effect.account.accountId ==
      "GDPFGP4IPE5DXG6XRXC4ZBUI43PAGRQ5VVNJ3LJTBXDBZ4ITO6HBHNSF");
  assert(effect.createdAt == "2018-06-06T10:23:57Z");
  assert(effect.newSequence == 79473726952833048);
}

void main() {
  testDeserializeAccountCreatedEffect();
  testDeserializeAccountRemovedEffect();
  testDeserializeAccountCreditedEffect();
  testDeserializeAccountDebitedEffect();
  testDeserializeAccountThresholdsUpdatedEffect();
  testDeserializeAccountHomeDomainUpdatedEffect();
  testDeserializeAccountFlagsUpdatedEffect();
  testDeserializeAccountInflationDestinationUpdatedEffect();
  testDeserializeSignerCreatedEffect();
  testDeserializeSignerRemovedEffect();
  testDeserializeSignerUpdatedEffect();
  testDeserializeTrustlineCreatedEffect();
  testDeserializeTrustlineRemovedEffect();
  testDeserializeTrustlineUpdatedEffect();
  testDeserializeTrustlineAuthorizedEffect();
  testDeserializeTrustlineDeauthorizedEffect();
  testDeserializeTradeEffect();
  testDeserializeDataCreatedEffect();
  testDeserializeDataRemovedEffect();
  testDeserializeDataUpdatedEffect();
  testDeserializeSequenceBumpedEffect();
}
