import 'package:collection/collection.dart';
import 'package:stellar/stellar.dart';
import 'dart:convert';

Function eq = const ListEquality().equals;

void testAccountDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"effects\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/effects{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"offers\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/offers{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"operations\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/operations{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\"\n" +
      "    },\n" +
      "    \"transactions\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/transactions{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    }\n" +
      "  }," +
      "  \"id\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "  \"paging_token\": \"1\",\n" +
      "  \"account_id\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "  \"sequence\": 2319149195853854,\n" +
      "  \"subentry_count\": 0,\n" +
      "  \"inflation_destination\": \"GAGRSA6QNQJN2OQYCBNQGMFLO4QLZFNEHIFXOMTQVSUTWVTWT66TOFSC\",\n" +
      "  \"home_domain\": \"stellar.org\",\n" +
      "  \"thresholds\": {\n" +
      "    \"low_threshold\": 10,\n" +
      "    \"med_threshold\": 20,\n" +
      "    \"high_threshold\": 30\n" +
      "  },\n" +
      "  \"flags\": {\n" +
      "    \"auth_required\": false,\n" +
      "    \"auth_revocable\": true,\n" +
      "    \"auth_immutable\": true\n" +
      "  },\n" +
      "  \"balances\": [\n" +
      "    {\n" +
      "      \"balance\": \"1001.0000000\",\n" +
      "      \"buying_liabilities\": \"100.1234567\",\n" +
      "      \"selling_liabilities\": \"100.7654321\",\n" +
      "      \"limit\": \"12000.4775807\",\n" +
      "      \"asset_type\": \"credit_alphanum4\",\n" +
      "      \"asset_code\": \"ABC\",\n" +
      "      \"asset_issuer\": \"GCRA6COW27CY5MTKIA7POQ2326C5ABYCXODBN4TFF5VL4FMBRHOT3YHU\"\n" +
      "    }," +
      "    {\n" +
      "      \"asset_type\": \"native\",\n" +
      "      \"balance\": \"20.0000300\",\n" +
      "      \"buying_liabilities\": \"5.1234567\",\n" +
      "      \"selling_liabilities\": \"1.7654321\"\n" +
      "    }\n" +
      "  ],\n" +
      "  \"signers\": [\n" +
      "    {\n" +
      "      \"public_key\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "      \"key\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "      \"weight\": 0,\n" +
      "      \"type\": \"ed25519_public_key\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"public_key\": \"GCR2KBCIU6KQXSQY5F5GZYC4WLNHCHCKW4NEGXNEZRYWLTNZIRJJY7D2\",\n" +
      "      \"key\": \"GCR2KBCIU6KQXSQY5F5GZYC4WLNHCHCKW4NEGXNEZRYWLTNZIRJJY7D2\",\n" +
      "      \"weight\": 1,\n" +
      "      \"type\": \"ed25519_public_key\"\n" +
      "    }\n" +
      "  ],\n" +
      "  \"data\": {\n" +
      "    \"entry1\": \"dGVzdA==\",\n" +
      "    \"entry2\": \"dGVzdDI=\"\n" +
      "  }" +
      "}";

  AccountResponse account = AccountResponse.fromJson(json.decode(jsonData));
  assert(account.keypair.accountId ==
      "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7");
  assert(account.pagingToken == "1");
  assert(account.sequenceNumber == 2319149195853854);
  assert(account.subentryCount == 0);
  assert(account.inflationDestination ==
      "GAGRSA6QNQJN2OQYCBNQGMFLO4QLZFNEHIFXOMTQVSUTWVTWT66TOFSC");
  assert(account.homeDomain == "stellar.org");

  assert(account.thresholds.lowThreshold == 10);
  assert(account.thresholds.medThreshold == 20);
  assert(account.thresholds.highThreshold == 30);

  assert(account.flags.authRequired == false);
  assert(account.flags.authRevocable == true);
  assert(account.flags.authImmutable == true);

  assert(account.balances[0].assetType == "credit_alphanum4");
  assert(account.balances[0].assetCode == "ABC");
  assert(account.balances[0].assetIssuer.accountId ==
      "GCRA6COW27CY5MTKIA7POQ2326C5ABYCXODBN4TFF5VL4FMBRHOT3YHU");
  assert(account.balances[0].balance == "1001.0000000");
  assert(account.balances[0].limit == "12000.4775807");
  assert(account.balances[0].buyingLiabilities == "100.1234567");
  assert(account.balances[0].sellingLiabilities == "100.7654321");

  assert(account.balances[1].assetType == "native");
  assert(account.balances[1].balance == "20.0000300");
  assert(account.balances[1].buyingLiabilities == "5.1234567");
  assert(account.balances[1].sellingLiabilities == "1.7654321");
  assert(account.balances[1].limit == null);

  assert(account.signers[0].accountId ==
      "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7");
  assert(account.signers[0].weight == 0);
  assert(account.signers[0].type == "ed25519_public_key");
  assert(account.signers[1].key ==
      "GCR2KBCIU6KQXSQY5F5GZYC4WLNHCHCKW4NEGXNEZRYWLTNZIRJJY7D2");
  assert(account.signers[1].weight == 1);
  assert(account.signers[1].type == "ed25519_public_key");

  assert(account.data.length == 2);
  assert(account.data["entry1"] == "dGVzdA==");
  assert(eq(account.data.getDecoded("entry1"), utf8.encode("test")));
  assert(account.data["entry2"] == "dGVzdDI=");
  assert(eq(account.data.getDecoded("entry2"), utf8.encode("test2")));

  assert(account.links.effects.href ==
      "/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/effects{?cursor,limit,order}");
  assert(account.links.offers.href ==
      "/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/offers{?cursor,limit,order}");
  assert(account.links.operations.href ==
      "/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/operations{?cursor,limit,order}");
  assert(account.links.self.href ==
      "/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7");
  assert(account.links.transactions.href ==
      "/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/transactions{?cursor,limit,order}");
}

void testAccountDeserializeV9() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"effects\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/effects{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"offers\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/offers{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"operations\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/operations{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\"\n" +
      "    },\n" +
      "    \"transactions\": {\n" +
      "      \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7/transactions{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    }\n" +
      "  }," +
      "  \"id\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "  \"paging_token\": \"1\",\n" +
      "  \"account_id\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "  \"sequence\": 2319149195853854,\n" +
      "  \"subentry_count\": 0,\n" +
      "  \"inflation_destination\": \"GAGRSA6QNQJN2OQYCBNQGMFLO4QLZFNEHIFXOMTQVSUTWVTWT66TOFSC\",\n" +
      "  \"home_domain\": \"stellar.org\",\n" +
      "  \"thresholds\": {\n" +
      "    \"low_threshold\": 10,\n" +
      "    \"med_threshold\": 20,\n" +
      "    \"high_threshold\": 30\n" +
      "  },\n" +
      "  \"flags\": {\n" +
      "    \"auth_required\": false,\n" +
      "    \"auth_revocable\": true\n" +
      "  },\n" +
      "  \"balances\": [\n" +
      "    {\n" +
      "      \"balance\": \"1001.0000000\",\n" +
      "      \"limit\": \"12000.4775807\",\n" +
      "      \"asset_type\": \"credit_alphanum4\",\n" +
      "      \"asset_code\": \"ABC\",\n" +
      "      \"asset_issuer\": \"GCRA6COW27CY5MTKIA7POQ2326C5ABYCXODBN4TFF5VL4FMBRHOT3YHU\"\n" +
      "    }," +
      "    {\n" +
      "      \"asset_type\": \"native\",\n" +
      "      \"balance\": \"20.0000300\"\n" +
      "    }\n" +
      "  ],\n" +
      "  \"signers\": [\n" +
      "    {\n" +
      "      \"public_key\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "      \"weight\": 0\n" +
      "    },\n" +
      "    {\n" +
      "      \"public_key\": \"GCR2KBCIU6KQXSQY5F5GZYC4WLNHCHCKW4NEGXNEZRYWLTNZIRJJY7D2\",\n" +
      "      \"weight\": 1\n" +
      "    }\n" +
      "  ]\n" +
      "}";

  AccountResponse account = AccountResponse.fromJson(json.decode(jsonData));

  assert(account.balances[0].assetType == "credit_alphanum4");
  assert(account.balances[0].assetCode == "ABC");
  assert(account.balances[0].assetIssuer.accountId ==
      "GCRA6COW27CY5MTKIA7POQ2326C5ABYCXODBN4TFF5VL4FMBRHOT3YHU");
  assert(account.balances[0].balance == "1001.0000000");
  assert(account.balances[0].limit == "12000.4775807");
  assert(account.balances[0].buyingLiabilities == null);
  assert(account.balances[0].sellingLiabilities == null);

  assert(account.balances[1].assetType == "native");
  assert(account.balances[1].balance == "20.0000300");
  assert(account.balances[1].buyingLiabilities == null);
  assert(account.balances[1].sellingLiabilities == null);
  assert(account.balances[1].limit == null);
}

void testAccountsPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"id\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "        \"paging_token\": \"1\",\n" +
      "        \"account_id\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"paging_token\": \"12884905985\",\n" +
      "        \"account_id\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GAP2KHWUMOHY7IO37UJY7SEBIITJIDZS5DRIIQRPEUT4VUKHZQGIRWS4\",\n" +
      "        \"paging_token\": \"33676838572033\",\n" +
      "        \"account_id\": \"GAP2KHWUMOHY7IO37UJY7SEBIITJIDZS5DRIIQRPEUT4VUKHZQGIRWS4\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GCZTBYH66ISTZKUPVJWTMHWBH4S4JIJ7WNLQJXCTQJKWY3FIT34BWZCJ\",\n" +
      "        \"paging_token\": \"33676838572034\",\n" +
      "        \"account_id\": \"GCZTBYH66ISTZKUPVJWTMHWBH4S4JIJ7WNLQJXCTQJKWY3FIT34BWZCJ\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GBEZOC5U4TVH7ZY5N3FLYHTCZSI6VFGTULG7PBITLF5ZEBPJXFT46YZM\",\n" +
      "        \"paging_token\": \"33676838572035\",\n" +
      "        \"account_id\": \"GBEZOC5U4TVH7ZY5N3FLYHTCZSI6VFGTULG7PBITLF5ZEBPJXFT46YZM\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GAENIE5LBJIXLMJIAJ7225IUPA6CX7EGHUXRX5FLCZFFAQSG2ZUYSWFK\",\n" +
      "        \"paging_token\": \"37288906067969\",\n" +
      "        \"account_id\": \"GAENIE5LBJIXLMJIAJ7225IUPA6CX7EGHUXRX5FLCZFFAQSG2ZUYSWFK\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GBCXF42Q26WFS2KJ5XDM5KGOWR5M4GHR3DBTFBJVRYKRUYJK4DBIH3RX\",\n" +
      "        \"paging_token\": \"84340272795649\",\n" +
      "        \"account_id\": \"GBCXF42Q26WFS2KJ5XDM5KGOWR5M4GHR3DBTFBJVRYKRUYJK4DBIH3RX\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GDVXG2FMFFSUMMMBIUEMWPZAIU2FNCH7QNGJMWRXRD6K5FZK5KJS4DDR\",\n" +
      "        \"paging_token\": \"85164906516481\",\n" +
      "        \"account_id\": \"GDVXG2FMFFSUMMMBIUEMWPZAIU2FNCH7QNGJMWRXRD6K5FZK5KJS4DDR\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GAORN5O6AQUHW3F6ZVOTN67RAZSONRNKP7WOHZ4XBHDMRKKLBTFTSNC6\",\n" +
      "        \"paging_token\": \"85718957297665\",\n" +
      "        \"account_id\": \"GAORN5O6AQUHW3F6ZVOTN67RAZSONRNKP7WOHZ4XBHDMRKKLBTFTSNC6\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"id\": \"GACFGMEV7A5H44O3K4EN6GRQ4SA543YJBZTKGNKPEMEQEAJFO4Q7ENG6\",\n" +
      "        \"paging_token\": \"86861418598401\",\n" +
      "        \"account_id\": \"GACFGMEV7A5H44O3K4EN6GRQ4SA543YJBZTKGNKPEMEQEAJFO4Q7ENG6\"\n" +
      "      }\n" +
      "    ]\n" +
      "  },\n" +
      "  \"_links\": {\n" +
      "    \"next\": {\n" +
      "      \"href\": \"/accounts?order=asc\\u0026limit=10\\u0026cursor=86861418598401\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"/accounts?order=desc\\u0026limit=10\\u0026cursor=1\"\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/accounts?order=asc\\u0026limit=10\\u0026cursor=\"\n" +
      "    }\n" +
      "  }\n" +
      "}";

  Page<AccountResponse> accountsPage =
      Page<AccountResponse>.fromJson(json.decode(jsonData));

  assert(accountsPage.records[0].keypair.accountId ==
      "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7");
  assert(accountsPage.records[0].pagingToken == "1");
  assert(accountsPage.records[9].keypair.accountId ==
      "GACFGMEV7A5H44O3K4EN6GRQ4SA543YJBZTKGNKPEMEQEAJFO4Q7ENG6");
  assert(accountsPage.links.next.href ==
      "/accounts?order=asc&limit=10&cursor=86861418598401");
  assert(
      accountsPage.links.prev.href == "/accounts?order=desc&limit=10&cursor=1");
  assert(
      accountsPage.links.self.href == "/accounts?order=asc&limit=10&cursor=");
}

void testAssetDeserializeNative() {
  String jsonData = "{\"asset_type\": \"native\"}";
  Asset asset = Asset.fromJson(json.decode(jsonData));
  assert(asset.type == "native");
}

void testAssetDeserializeCredit() {
  String jsonData = "{\n" +
      "  \"asset_type\": \"credit_alphanum4\",\n" +
      "  \"asset_code\": \"CNY\",\n" +
      "  \"asset_issuer\": \"GAREELUB43IRHWEASCFBLKHURCGMHE5IF6XSE7EXDLACYHGRHM43RFOX\"\n" +
      "}";
  Asset asset = Asset.fromJson(json.decode(jsonData));
  assert(asset.type == "credit_alphanum4");
  AssetTypeCreditAlphaNum creditAsset = asset as AssetTypeCreditAlphaNum;
  assert(creditAsset.code == "CNY");
  assert(creditAsset.issuer.accountId ==
      "GAREELUB43IRHWEASCFBLKHURCGMHE5IF6XSE7EXDLACYHGRHM43RFOX");
}

void testAssetsPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"self\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/assets?order=asc\\u0026limit=10\\u0026cursor=\"\n" +
      "    },\n" +
      "    \"next\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/assets?order=asc\\u0026limit=10\\u0026cursor=AsrtoDollar_GDJWXY5XUASXNL4ABCONR6T5MOXJ2S4HD6WDNAJDSDKQ4VS3TVUQJEDJ_credit_alphanum12\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/assets?order=desc\\u0026limit=10\\u0026cursor=6497847_GCGNWKCJ3KHRLPM3TM6N7D3W5YKDJFL6A2YCXFXNMRTZ4Q66MEMZ6FI2_credit_alphanum12\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"https://www.stellar.org/.well-known/stellar.toml\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"6497847\",\n" +
      "        \"asset_issuer\": \"GCGNWKCJ3KHRLPM3TM6N7D3W5YKDJFL6A2YCXFXNMRTZ4Q66MEMZ6FI2\",\n" +
      "        \"paging_token\": \"6497847_GCGNWKCJ3KHRLPM3TM6N7D3W5YKDJFL6A2YCXFXNMRTZ4Q66MEMZ6FI2_credit_alphanum12\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 1,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": true,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"9HORIZONS\",\n" +
      "        \"asset_issuer\": \"GB2HXY7UEDCSHOWZ4553QFGFILNU73OFS2P4HU5IB3UUU66TWPBPVTGW\",\n" +
      "        \"paging_token\": \"9HORIZONS_GB2HXY7UEDCSHOWZ4553QFGFILNU73OFS2P4HU5IB3UUU66TWPBPVTGW_credit_alphanum12\",\n" +
      "        \"amount\": \"1000000.0000000\",\n" +
      "        \"num_accounts\": 3,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"AIR\",\n" +
      "        \"asset_issuer\": \"GB2SQ74JCS6F4MVDU4BF4L4S4Z5Z36ABOTP6DF5JJOFGFE3ETZAUVUQK\",\n" +
      "        \"paging_token\": \"AIR_GB2SQ74JCS6F4MVDU4BF4L4S4Z5Z36ABOTP6DF5JJOFGFE3ETZAUVUQK_credit_alphanum4\",\n" +
      "        \"amount\": \"100000000000.0000000\",\n" +
      "        \"num_accounts\": 2,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"AlambLedgerS\",\n" +
      "        \"asset_issuer\": \"GCMXATSZBEYTNPFQXHFQXUYXOTHA4HA5L2YZEKKOVGYWTUT24KIHECG3\",\n" +
      "        \"paging_token\": \"AlambLedgerS_GCMXATSZBEYTNPFQXHFQXUYXOTHA4HA5L2YZEKKOVGYWTUT24KIHECG3_credit_alphanum12\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 0,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"AMO\",\n" +
      "        \"asset_issuer\": \"GBOMFBZG5PWUXDIIW5ITVRVEL6YCIC6ZDXLNBH33BNPCX3D7AXDCDKHF\",\n" +
      "        \"paging_token\": \"AMO_GBOMFBZG5PWUXDIIW5ITVRVEL6YCIC6ZDXLNBH33BNPCX3D7AXDCDKHF_credit_alphanum4\",\n" +
      "        \"amount\": \"10000000.0000000\",\n" +
      "        \"num_accounts\": 1,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"AMO\",\n" +
      "        \"asset_issuer\": \"GDIAIZ7S7L2OBEQBH62KE7IWXK76XA7ES7XCH7JCPXQGV7VB3V6VETOX\",\n" +
      "        \"paging_token\": \"AMO_GDIAIZ7S7L2OBEQBH62KE7IWXK76XA7ES7XCH7JCPXQGV7VB3V6VETOX_credit_alphanum4\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 1,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"ASD\",\n" +
      "        \"asset_issuer\": \"GAOMRMILWSX7UXZMYC4X7B7BVJXORYV36XUK3EURVJF7DA6B77ABFVOJ\",\n" +
      "        \"paging_token\": \"ASD_GAOMRMILWSX7UXZMYC4X7B7BVJXORYV36XUK3EURVJF7DA6B77ABFVOJ_credit_alphanum4\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 0,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"https://mystellar.tools/.well-known/stellar.toml\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum4\",\n" +
      "        \"asset_code\": \"ASD\",\n" +
      "        \"asset_issuer\": \"GDP4SJE5Y5ODX627DO2F7ZNBAPVXRFHKKR3W4UJ6I4XMW3S3OH2XRWYD\",\n" +
      "        \"paging_token\": \"ASD_GDP4SJE5Y5ODX627DO2F7ZNBAPVXRFHKKR3W4UJ6I4XMW3S3OH2XRWYD_credit_alphanum4\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 0,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"AsrtoDollar\",\n" +
      "        \"asset_issuer\": \"GBPGO557IQWSWOIKHWB7YJ5QIBWVF4QS6SPGWT5YBGDUPE6QKOD7RR7S\",\n" +
      "        \"paging_token\": \"AsrtoDollar_GBPGO557IQWSWOIKHWB7YJ5QIBWVF4QS6SPGWT5YBGDUPE6QKOD7RR7S_credit_alphanum12\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 0,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"toml\": {\n" +
      "            \"href\": \"\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"asset_type\": \"credit_alphanum12\",\n" +
      "        \"asset_code\": \"AsrtoDollar\",\n" +
      "        \"asset_issuer\": \"GDJWXY5XUASXNL4ABCONR6T5MOXJ2S4HD6WDNAJDSDKQ4VS3TVUQJEDJ\",\n" +
      "        \"paging_token\": \"AsrtoDollar_GDJWXY5XUASXNL4ABCONR6T5MOXJ2S4HD6WDNAJDSDKQ4VS3TVUQJEDJ_credit_alphanum12\",\n" +
      "        \"amount\": \"0.0000000\",\n" +
      "        \"num_accounts\": 0,\n" +
      "        \"flags\": {\n" +
      "          \"auth_required\": false,\n" +
      "          \"auth_revocable\": false\n" +
      "        }\n" +
      "      }\n" +
      "    ]\n" +
      "  }\n" +
      "}";

  Page<AssetResponse> page =
      Page<AssetResponse>.fromJson(json.decode(jsonData));

  assert(page.links.self.href ==
      "https://horizon.stellar.org/assets?order=asc&limit=10&cursor=");
  assert(page.links.next.href ==
      "https://horizon.stellar.org/assets?order=asc&limit=10&cursor=AsrtoDollar_GDJWXY5XUASXNL4ABCONR6T5MOXJ2S4HD6WDNAJDSDKQ4VS3TVUQJEDJ_credit_alphanum12");

  assert(page.records[0].assetType == "credit_alphanum12");
  assert(page.records[0].assetCode == "6497847");
  assert(page.records[0].assetIssuer ==
      "GCGNWKCJ3KHRLPM3TM6N7D3W5YKDJFL6A2YCXFXNMRTZ4Q66MEMZ6FI2");
  assert(page.records[0].pagingToken ==
      "6497847_GCGNWKCJ3KHRLPM3TM6N7D3W5YKDJFL6A2YCXFXNMRTZ4Q66MEMZ6FI2_credit_alphanum12");
  assert(page.records[0].amount == "0.0000000");
  assert(page.records[0].numAccounts == 1);
  assert(page.records[0].links.toml.href ==
      "https://www.stellar.org/.well-known/stellar.toml");
  assert(page.records[0].flags.authRequired == true);
  assert(page.records[0].flags.authRevocable == false);
}

void testEffectsPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"self\": {\n" +
      "      \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026limit=10\\u0026cursor=\"\n" +
      "    },\n" +
      "    \"next\": {\n" +
      "      \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026limit=10\\u0026cursor=3962163165138945-3\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026limit=10\\u0026cursor=3964757325385729-3\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3964757325385729\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3964757325385729-3\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3964757325385729-3\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003964757325385729-0000000003\",\n" +
      "        \"paging_token\": \"3964757325385729-3\",\n" +
      "        \"account\": \"GAZHVTAM3NRJ6W643LOVA76T2W3TUKPF34ED5VNE4ZKJ2B5T2EUQHIQI\",\n" +
      "        \"type\": \"signer_created\",\n" +
      "        \"type_i\": 10,\n" +
      "        \"weight\": 1,\n" +
      "        \"public_key\": \"GAZHVTAM3NRJ6W643LOVA76T2W3TUKPF34ED5VNE4ZKJ2B5T2EUQHIQI\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3964757325385729\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3964757325385729-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3964757325385729-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003964757325385729-0000000002\",\n" +
      "        \"paging_token\": \"3964757325385729-2\",\n" +
      "        \"account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"account_debited\",\n" +
      "        \"type_i\": 3,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"amount\": \"10000.0\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3964757325385729\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3964757325385729-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3964757325385729-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003964757325385729-0000000001\",\n" +
      "        \"paging_token\": \"3964757325385729-1\",\n" +
      "        \"account\": \"GAZHVTAM3NRJ6W643LOVA76T2W3TUKPF34ED5VNE4ZKJ2B5T2EUQHIQI\",\n" +
      "        \"type\": \"account_created\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3964645656236033\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3964645656236033-3\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3964645656236033-3\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003964645656236033-0000000003\",\n" +
      "        \"paging_token\": \"3964645656236033-3\",\n" +
      "        \"account\": \"GA43X7ERPZQUVNDVHBGN42AK3SYJRVJ7TUWQGNFVY2O74YVDQFW2KP7C\",\n" +
      "        \"type\": \"signer_created\",\n" +
      "        \"type_i\": 10,\n" +
      "        \"weight\": 1,\n" +
      "        \"public_key\": \"GA43X7ERPZQUVNDVHBGN42AK3SYJRVJ7TUWQGNFVY2O74YVDQFW2KP7C\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3964645656236033\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3964645656236033-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3964645656236033-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003964645656236033-0000000002\",\n" +
      "        \"paging_token\": \"3964645656236033-2\",\n" +
      "        \"account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"account_debited\",\n" +
      "        \"type_i\": 3,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"amount\": \"10000.0\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3964645656236033\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3964645656236033-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3964645656236033-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003964645656236033-0000000001\",\n" +
      "        \"paging_token\": \"3964645656236033-1\",\n" +
      "        \"account\": \"GA43X7ERPZQUVNDVHBGN42AK3SYJRVJ7TUWQGNFVY2O74YVDQFW2KP7C\",\n" +
      "        \"type\": \"account_created\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3963559029510145\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3963559029510145-3\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3963559029510145-3\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003963559029510145-0000000003\",\n" +
      "        \"paging_token\": \"3963559029510145-3\",\n" +
      "        \"account\": \"GDIQJ6G5AWSBRMHIZYWVWCFN64Q4BZ4TYEAQRO5GVR4EWR23RKBJ2A4R\",\n" +
      "        \"type\": \"signer_created\",\n" +
      "        \"type_i\": 10,\n" +
      "        \"weight\": 1,\n" +
      "        \"public_key\": \"GDIQJ6G5AWSBRMHIZYWVWCFN64Q4BZ4TYEAQRO5GVR4EWR23RKBJ2A4R\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3963559029510145\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3963559029510145-2\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3963559029510145-2\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003963559029510145-0000000002\",\n" +
      "        \"paging_token\": \"3963559029510145-2\",\n" +
      "        \"account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"account_debited\",\n" +
      "        \"type_i\": 3,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"amount\": \"10000.0\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3963559029510145\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3963559029510145-1\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3963559029510145-1\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003963559029510145-0000000001\",\n" +
      "        \"paging_token\": \"3963559029510145-1\",\n" +
      "        \"account\": \"GDIQJ6G5AWSBRMHIZYWVWCFN64Q4BZ4TYEAQRO5GVR4EWR23RKBJ2A4R\",\n" +
      "        \"type\": \"account_created\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3962163165138945\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3962163165138945-3\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3962163165138945-3\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0003962163165138945-0000000003\",\n" +
      "        \"paging_token\": \"3962163165138945-3\",\n" +
      "        \"account\": \"GAXHEECODLEAGGSC4ERUH3YW7G47IS7TS32NZQT4YLP5FK7HQZZWLLFC\",\n" +
      "        \"type\": \"signer_created\",\n" +
      "        \"type_i\": 10,\n" +
      "        \"weight\": 1,\n" +
      "        \"public_key\": \"GAXHEECODLEAGGSC4ERUH3YW7G47IS7TS32NZQT4YLP5FK7HQZZWLLFC\"\n" +
      "      }\n" +
      "    ]\n" +
      "  }\n" +
      "}";

  Page<EffectResponse> effectsPage =
      Page<EffectResponse>.fromJson(json.decode(jsonData));

  SignerCreatedEffectResponse signerCreatedEffect =
      effectsPage.records[0] as SignerCreatedEffectResponse;
  assert(signerCreatedEffect.publicKey ==
      "GAZHVTAM3NRJ6W643LOVA76T2W3TUKPF34ED5VNE4ZKJ2B5T2EUQHIQI");
  assert(signerCreatedEffect.pagingToken == "3964757325385729-3");

  AccountCreatedEffectResponse accountCreatedEffect =
      effectsPage.records[8] as AccountCreatedEffectResponse;
  assert(accountCreatedEffect.startingBalance == "10000.0");
  assert(accountCreatedEffect.account.accountId ==
      "GDIQJ6G5AWSBRMHIZYWVWCFN64Q4BZ4TYEAQRO5GVR4EWR23RKBJ2A4R");

  assert(effectsPage.links.next.href ==
      "http://horizon-testnet.stellar.org/effects?order=desc&limit=10&cursor=3962163165138945-3");
}

void testLedgerDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"effects\": {\n" +
      "      \"href\": \"/ledgers/898826/effects{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"operations\": {\n" +
      "      \"href\": \"/ledgers/898826/operations{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/ledgers/898826\"\n" +
      "    },\n" +
      "    \"transactions\": {\n" +
      "      \"href\": \"/ledgers/898826/transactions{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    }\n" +
      "  },\n" +
      "  \"id\": \"686bb246db89b099cd3963a4633eb5e4315d89dfd3c00594c80b41a483847bfa\",\n" +
      "  \"paging_token\": \"3860428274794496\",\n" +
      "  \"hash\": \"686bb246db89b099cd3963a4633eb5e4315d89dfd3c00594c80b41a483847bfa\",\n" +
      "  \"prev_hash\": \"50c8695eb32171a19858413e397cc50b504ceacc819010bdf8ff873aff7858d7\",\n" +
      "  \"sequence\": 898826,\n" +
      "  \"transaction_count\": 1,\n" +
      "  \"operation_count\": 2,\n" +
      "  \"closed_at\": \"2015-11-19T21:35:59Z\",\n" +
      "  \"total_coins\": \"101343867604.8975480\",\n" +
      "  \"fee_pool\": \"1908.2248818\",\n" +
      "  \"base_fee\": 100,\n" +
      "  \"base_reserve\": \"10.0000000\",\n" +
      "  \"max_tx_set_size\": 50,\n" +
      "  \"protocol_version\": 10,\n" +
      "  \"header_xdr\": \"AAAACvkxR60p1bwRO3PdsRy48pkWVtuyF08xyvB3jU7u437r9tK/G7DoXa+J8N5ptWhpHGrc/" +
      "a+5k9Ak3kHnZSAaiPgAAAAAW4aHyQAAAAAAAAAAyz4xx/YIt7Z9PLeCHj/ZrFGcDaNSJpQX+jpL1IX3uqSCiFrU4CFidqxjmmJzXNWN1rY4cBwliHN21hicu/" +
      "JyawCkgzIOdhy8pVTcbQA+gekx1NpNAAAA2QAAAAAACsLiAAAAZABMS0AAAAAykmy96ckoDVk3UDBm7B4n8oC6+cdCxGDnWu7tO6aU34xipth5GRNy+I5Y8m+E/" +
      "bHlElCDX2J8y6kuKr7yU6xvyjMb9nwaii7EHN74adNyyUuselmxQcKfEVf/tj3j5l9yOMqgE05NDyU0+LycHY47062IWxvG0o2yDaaxp2Z72pwAAAAA\"\n" +
      "}";

  LedgerResponse ledger = LedgerResponse.fromJson(json.decode(jsonData));
  assert(ledger.hash ==
      "686bb246db89b099cd3963a4633eb5e4315d89dfd3c00594c80b41a483847bfa");
  assert(ledger.pagingToken == "3860428274794496");
  assert(ledger.prevHash ==
      "50c8695eb32171a19858413e397cc50b504ceacc819010bdf8ff873aff7858d7");
  assert(ledger.sequence == 898826);
  assert(ledger.transactionCount == 1);
  assert(ledger.operationCount == 2);
  assert(ledger.closedAt == "2015-11-19T21:35:59Z");
  assert(ledger.totalCoins == "101343867604.8975480");
  assert(ledger.feePool == "1908.2248818");
  assert(ledger.baseFee == 100);
  assert(ledger.baseReserve == "10.0000000");
  assert(ledger.maxTxSetSize == 50);
  assert(ledger.protocolVersion == 10);
  assert(ledger.headerXdr ==
      "AAAACvkxR60p1bwRO3PdsRy48pkWVtuyF08xyvB3jU7u437r9tK/G7DoXa+J8N5ptWhpHGrc/" +
          "a+5k9Ak3kHnZSAaiPgAAAAAW4aHyQAAAAAAAAAAyz4xx/YIt7Z9PLeCHj/ZrFGcDaNSJpQX+jpL1IX3uqSCiFrU4CFidqxjmmJzXNWN1rY4cBwliHN21hicu/" +
          "JyawCkgzIOdhy8pVTcbQA+gekx1NpNAAAA2QAAAAAACsLiAAAAZABMS0AAAAAykmy96ckoDVk3UDBm7B4n8oC6+cdCxGDnWu7tO6aU34xipth5GRNy+I5Y8m+E/" +
          "bHlElCDX2J8y6kuKr7yU6xvyjMb9nwaii7EHN74adNyyUuselmxQcKfEVf/tj3j5l9yOMqgE05NDyU0+LycHY47062IWxvG0o2yDaaxp2Z72pwAAAAA");
  assert(ledger.links.effects.href ==
      "/ledgers/898826/effects{?cursor,limit,order}");
  assert(ledger.links.operations.href ==
      "/ledgers/898826/operations{?cursor,limit,order}");
  assert(ledger.links.self.href == "/ledgers/898826");
  assert(ledger.links.transactions.href ==
      "/ledgers/898826/transactions{?cursor,limit,order}");
}

void testLedgerPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899239/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899239/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899239\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899239/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"f6fc9a29b5ecec90348e17a10a60e019c5cb8ea24f66a1063e92c13391b09b8d\",\n" +
      "        \"paging_token\": \"3862202096287744\",\n" +
      "        \"hash\": \"f6fc9a29b5ecec90348e17a10a60e019c5cb8ea24f66a1063e92c13391b09b8d\",\n" +
      "        \"prev_hash\": \"0bc807d3be86e8a9f7c913bc0e408f67402f50fbf4c0ea6583bc0f788075a567\",\n" +
      "        \"sequence\": 899239,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:34Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899238/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899238/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899238\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899238/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"0bc807d3be86e8a9f7c913bc0e408f67402f50fbf4c0ea6583bc0f788075a567\",\n" +
      "        \"paging_token\": \"3862197801320448\",\n" +
      "        \"hash\": \"0bc807d3be86e8a9f7c913bc0e408f67402f50fbf4c0ea6583bc0f788075a567\",\n" +
      "        \"prev_hash\": \"4a88c758baf11ff4265df0d7b304b737db7c7fad4b605deb887abaa1994c9be7\",\n" +
      "        \"sequence\": 899238,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:27Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899237/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899237/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899237\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899237/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"4a88c758baf11ff4265df0d7b304b737db7c7fad4b605deb887abaa1994c9be7\",\n" +
      "        \"paging_token\": \"3862193506353152\",\n" +
      "        \"hash\": \"4a88c758baf11ff4265df0d7b304b737db7c7fad4b605deb887abaa1994c9be7\",\n" +
      "        \"prev_hash\": \"6c8c24c0f4668e8f67d868bbfc851863f309da50f70341607a442f201da17190\",\n" +
      "        \"sequence\": 899237,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:25Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899236/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899236/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899236\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899236/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"6c8c24c0f4668e8f67d868bbfc851863f309da50f70341607a442f201da17190\",\n" +
      "        \"paging_token\": \"3862189211385856\",\n" +
      "        \"hash\": \"6c8c24c0f4668e8f67d868bbfc851863f309da50f70341607a442f201da17190\",\n" +
      "        \"prev_hash\": \"32efbdd295310a379621bda41397258708e5a4e606ad3c33c5a343289979ee7f\",\n" +
      "        \"sequence\": 899236,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:20Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899235/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899235/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899235\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899235/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"32efbdd295310a379621bda41397258708e5a4e606ad3c33c5a343289979ee7f\",\n" +
      "        \"paging_token\": \"3862184916418560\",\n" +
      "        \"hash\": \"32efbdd295310a379621bda41397258708e5a4e606ad3c33c5a343289979ee7f\",\n" +
      "        \"prev_hash\": \"65349e138f295aff14f30d1bcce6f9fb76055ca561004416194572e90cb2d05f\",\n" +
      "        \"sequence\": 899235,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:15Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899234/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899234/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899234\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899234/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"65349e138f295aff14f30d1bcce6f9fb76055ca561004416194572e90cb2d05f\",\n" +
      "        \"paging_token\": \"3862180621451264\",\n" +
      "        \"hash\": \"65349e138f295aff14f30d1bcce6f9fb76055ca561004416194572e90cb2d05f\",\n" +
      "        \"prev_hash\": \"ec548930241d677c712381cfc72b0c57bd4c0ce10ef7e7c3b7c693387f932aa5\",\n" +
      "        \"sequence\": 899234,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:12Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899233/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899233/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899233\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899233/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"ec548930241d677c712381cfc72b0c57bd4c0ce10ef7e7c3b7c693387f932aa5\",\n" +
      "        \"paging_token\": \"3862176326483968\",\n" +
      "        \"hash\": \"ec548930241d677c712381cfc72b0c57bd4c0ce10ef7e7c3b7c693387f932aa5\",\n" +
      "        \"prev_hash\": \"03dfe28b30dad13a95eaf20681613ecad1795f527182103524e1f5b106fefd53\",\n" +
      "        \"sequence\": 899233,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:09Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899232/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899232/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899232\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899232/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"03dfe28b30dad13a95eaf20681613ecad1795f527182103524e1f5b106fefd53\",\n" +
      "        \"paging_token\": \"3862172031516672\",\n" +
      "        \"hash\": \"03dfe28b30dad13a95eaf20681613ecad1795f527182103524e1f5b106fefd53\",\n" +
      "        \"prev_hash\": \"03abed895270fd6a534c7d8813778e932dd6b5894aa350b085ce8d9e46ce32fa\",\n" +
      "        \"sequence\": 899232,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:05Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899231/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899231/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899231\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899231/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"03abed895270fd6a534c7d8813778e932dd6b5894aa350b085ce8d9e46ce32fa\",\n" +
      "        \"paging_token\": \"3862167736549376\",\n" +
      "        \"hash\": \"03abed895270fd6a534c7d8813778e932dd6b5894aa350b085ce8d9e46ce32fa\",\n" +
      "        \"prev_hash\": \"8552b7d130e602ed068bcfec729b3056d0c8b94d77f06d91cd1ec8323c2d6177\",\n" +
      "        \"sequence\": 899231,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:01:02Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/ledgers/899230/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/ledgers/899230/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/ledgers/899230\"\n" +
      "          },\n" +
      "          \"transactions\": {\n" +
      "            \"href\": \"/ledgers/899230/transactions{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"8552b7d130e602ed068bcfec729b3056d0c8b94d77f06d91cd1ec8323c2d6177\",\n" +
      "        \"paging_token\": \"3862163441582080\",\n" +
      "        \"hash\": \"8552b7d130e602ed068bcfec729b3056d0c8b94d77f06d91cd1ec8323c2d6177\",\n" +
      "        \"prev_hash\": \"62efa4d5059f438aef2e3c059162b8fca9c59317bdbdd1b04dc92924302a455e\",\n" +
      "        \"sequence\": 899230,\n" +
      "        \"transaction_count\": 0,\n" +
      "        \"operation_count\": 0,\n" +
      "        \"closed_at\": \"2015-11-19T22:00:59Z\",\n" +
      "        \"total_coins\": \"101343867604.8975480\",\n" +
      "        \"fee_pool\": \"1908.2251218\",\n" +
      "        \"base_fee\": 100,\n" +
      "        \"base_reserve\": \"10.0000000\",\n" +
      "        \"max_tx_set_size\": 50\n" +
      "      }\n" +
      "    ]\n" +
      "  },\n" +
      "  \"_links\": {\n" +
      "    \"next\": {\n" +
      "      \"href\": \"/ledgers?order=desc\\u0026limit=10\\u0026cursor=3862163441582080\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"/ledgers?order=asc\\u0026limit=10\\u0026cursor=3862202096287744\"\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/ledgers?order=desc\\u0026limit=10\\u0026cursor=\"\n" +
      "    }\n" +
      "  }\n" +
      "}";

  Page<LedgerResponse> ledgersPage =
      Page<LedgerResponse>.fromJson(json.decode(jsonData));

  assert(ledgersPage.records[0].hash ==
      "f6fc9a29b5ecec90348e17a10a60e019c5cb8ea24f66a1063e92c13391b09b8d");
  assert(ledgersPage.records[0].pagingToken == "3862202096287744");
  assert(ledgersPage.records[9].hash ==
      "8552b7d130e602ed068bcfec729b3056d0c8b94d77f06d91cd1ec8323c2d6177");
  assert(ledgersPage.links.next.href ==
      "/ledgers?order=desc&limit=10&cursor=3862163441582080");
  assert(ledgersPage.links.prev.href ==
      "/ledgers?order=asc&limit=10&cursor=3862202096287744");
  assert(ledgersPage.links.self.href == "/ledgers?order=desc&limit=10&cursor=");
}

void testOfferPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"self\": {\n" +
      "      \"href\": \"https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD/offers?order=asc\\u0026limit=10\\u0026cursor=\"\n" +
      "    },\n" +
      "    \"next\": {\n" +
      "      \"href\": \"https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD/offers?order=asc\\u0026limit=10\\u0026cursor=241\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD/offers?order=desc\\u0026limit=10\\u0026cursor=241\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/offers/241\"\n" +
      "          },\n" +
      "          \"offer_maker\": {\n" +
      "            \"href\": \"https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": 241,\n" +
      "        \"paging_token\": \"241\",\n" +
      "        \"seller\": \"GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD\",\n" +
      "        \"selling\": {\n" +
      "          \"asset_type\": \"credit_alphanum4\",\n" +
      "          \"asset_code\": \"INR\",\n" +
      "          \"asset_issuer\": \"GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD\"\n" +
      "        },\n" +
      "        \"buying\": {\n" +
      "          \"asset_type\": \"credit_alphanum4\",\n" +
      "          \"asset_code\": \"USD\",\n" +
      "          \"asset_issuer\": \"GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD\"\n" +
      "        },\n" +
      "        \"amount\": \"10.0000000\",\n" +
      "        \"price_r\": {\n" +
      "          \"n\": 10,\n" +
      "          \"d\": 1\n" +
      "        },\n" +
      "        \"price\": \"11.0000000\"\n" +
      "      }\n" +
      "    ]\n" +
      "  }\n" +
      "}";

  Page<OfferResponse> transactionsPage =
      Page<OfferResponse>.fromJson(json.decode(jsonData));

  assert(transactionsPage.records[0].id == 241);
  assert(transactionsPage.records[0].seller.accountId ==
      "GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD");
  assert(transactionsPage.records[0].pagingToken == "241");
  assert(transactionsPage.records[0].selling ==
      Asset.createNonNativeAsset(
          "INR",
          KeyPair.fromAccountId(
              "GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD")));
  assert(transactionsPage.records[0].buying ==
      Asset.createNonNativeAsset(
          "USD",
          KeyPair.fromAccountId(
              "GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD")));
  assert(transactionsPage.records[0].amount == "10.0000000");
  assert(transactionsPage.records[0].price == "11.0000000");

  assert(transactionsPage.links.next.href ==
      "https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD/offers?order=asc&limit=10&cursor=241");
  assert(transactionsPage.links.prev.href ==
      "https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD/offers?order=desc&limit=10&cursor=241");
  assert(transactionsPage.links.self.href ==
      "https://horizon-testnet.stellar.org/accounts/GA2IYMIZSAMDD6QQTTSIEL73H2BKDJQTA7ENDEEAHJ3LMVF7OYIZPXQD/offers?order=asc&limit=10&cursor=");
}

void testOperationsPageDeserialize() {
  String jsonData = "{\n" +
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
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3715417293983745\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/57d3ff20b53a21bd2a5c24838401e01fc13abc0193437d050dbdb8b7784cd674\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3715417293983745/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3715417293983745\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3715417293983745\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3715417293983745\",\n" +
      "        \"paging_token\": \"3715417293983745\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GA4GQOVE7SQCPGDCXOKIUWGZYJCMMA3TCJUB54ZYYCNMZD7MVILGEADL\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3711620542894081\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/e37b9dd7f36397e7a06ef121fb5446431585d30f8f3cf1d63a6d283e8f7b5a8c\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3711620542894081/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3711620542894081\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3711620542894081\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3711620542894081\",\n" +
      "        \"paging_token\": \"3711620542894081\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GDD2PUGSEGWN6TSHQNE6EDHVUYH6I37Y7727V3WFXUS2GGO4ZJ72EPEZ\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3709305555521537\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/af6ab37cfbeefc62a215ab7c4f64b007b666eed0c12dd92abbe0af08461d7b7f\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3709305555521537/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3709305555521537\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3709305555521537\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3709305555521537\",\n" +
      "        \"paging_token\": \"3709305555521537\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GDPMWVUTK7T5NG2OHDAZLGLT7QS5GCL23CFVNUR3BNKVPDLW2RULWE7Z\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3704821609664513\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/d4cb66d51cf773a4126ef8d535f03ba08cdc2389dc067e05c5d2ba1b335f19f2\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3704821609664513/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3704821609664513\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3704821609664513\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3704821609664513\",\n" +
      "        \"paging_token\": \"3704821609664513\",\n" +
      "        \"source_account\": \"GCYK67DDGBOANS6UODJ62QWGLEB2A7JQ3XUV25HCMLT7CI23PMMK3W6R\",\n" +
      "        \"type\": \"payment\",\n" +
      "        \"type_i\": 1,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"from\": \"GCYK67DDGBOANS6UODJ62QWGLEB2A7JQ3XUV25HCMLT7CI23PMMK3W6R\",\n" +
      "        \"to\": \"GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H\",\n" +
      "        \"amount\": \"10.123\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3704778659991553\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/741a66dee5bafdefa1803bd80108fb86b075bbca80165bc4137c8f8ad1959efa\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3704778659991553/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3704778659991553\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3704778659991553\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3704778659991553\",\n" +
      "        \"paging_token\": \"3704778659991553\",\n" +
      "        \"source_account\": \"GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H\",\n" +
      "        \"type\": \"payment\",\n" +
      "        \"type_i\": 1,\n" +
      "        \"asset_type\": \"native\",\n" +
      "        \"from\": \"GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H\",\n" +
      "        \"to\": \"GCYK67DDGBOANS6UODJ62QWGLEB2A7JQ3XUV25HCMLT7CI23PMMK3W6R\",\n" +
      "        \"amount\": \"10.123\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3704435062607873\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/9bf15f7003c098c935d03bd178eda02b39cecb7a6eb53b4dd278aa9d4620c45b\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3704435062607873/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3704435062607873\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3704435062607873\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3704435062607873\",\n" +
      "        \"paging_token\": \"3704435062607873\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GCYK67DDGBOANS6UODJ62QWGLEB2A7JQ3XUV25HCMLT7CI23PMMK3W6R\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3700453627924481\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/aae8986da322e9405fd27f0e284817cb2e86618151ac54ef8734f629d8cf9446\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3700453627924481/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3700453627924481\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3700453627924481\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3700453627924481\",\n" +
      "        \"paging_token\": \"3700453627924481\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GA3J26UB775RW6M5INM75MJDPG72PMSUNZYBYU7IJL75UKMOIMJSHVEY\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3696369114025985\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/e852c069fbd0f3eafa691c276b0b57a4d0fad833e979fa192ad6b7a741892083\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3696369114025985/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3696369114025985\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3696369114025985\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3696369114025985\",\n" +
      "        \"paging_token\": \"3696369114025985\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GDIEI4DXAV57TDMNJSYWU7WDNVVS4GYU65YFMP7KQRGOU4TQALFYZUIJ\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3695540185337857\"\n" +
      "          },\n" +
      "          \"transaction\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/transactions/0028e0d640a74b372c4195575c785da61605b6a7da95998cbb56553850e97963\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/operations/3695540185337857/effects\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=desc\\u0026cursor=3695540185337857\"\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"http://horizon-testnet.stellar.org/effects?order=asc\\u0026cursor=3695540185337857\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3695540185337857\",\n" +
      "        \"paging_token\": \"3695540185337857\",\n" +
      "        \"source_account\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"type\": \"create_account\",\n" +
      "        \"type_i\": 0,\n" +
      "        \"starting_balance\": \"10000.0\",\n" +
      "        \"funder\": \"GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K\",\n" +
      "        \"account\": \"GB3ZROOPBSDASLJUYCV7FJVGRWDJRB3MZAEY5CUZTRHLADEE5WW4AOIK\"\n" +
      "      }\n" +
      "    ]\n" +
      "  }\n" +
      "}";

  Page<OperationResponse> operationsPage =
      Page<OperationResponse>.fromJson(json.decode(jsonData));

  CreateAccountOperationResponse createAccountOperation =
      operationsPage.records[0] as CreateAccountOperationResponse;
  assert(createAccountOperation.startingBalance == "10000.0");
  assert(createAccountOperation.pagingToken == "3717508943056897");
  assert(createAccountOperation.account.accountId ==
      "GDFH4NIYMIIAKRVEJJZOIGWKXGQUF3XHJG6ZM6CEA64AMTVDN44LHOQE");
  assert(createAccountOperation.funder.accountId ==
      "GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K");
  assert(createAccountOperation.createdAt == "2018-01-22T21:30:53Z");
  assert(createAccountOperation.transactionHash ==
      "dd9d10c80a344f4464df3ecaa63705a5ef4a0533ff2f2099d5ef371ab5e1c046");

  PaymentOperationResponse paymentOperation =
      operationsPage.records[4] as PaymentOperationResponse;
  assert(paymentOperation.amount == "10.123");
  assert(paymentOperation.asset == new AssetTypeNative());
  assert(paymentOperation.from.accountId ==
      "GCYK67DDGBOANS6UODJ62QWGLEB2A7JQ3XUV25HCMLT7CI23PMMK3W6R");
  assert(paymentOperation.to.accountId ==
      "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H");
}

void testOrderBookDeserialize() {
  String jsonData = "{\n" +
      "  \"bids\": [\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 4638606,\n" +
      "        \"d\": 1914900241\n" +
      "      },\n" +
      "      \"price\": \"0.0024224\",\n" +
      "      \"amount\": \"31.4007644\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2048926,\n" +
      "        \"d\": 845926319\n" +
      "      },\n" +
      "      \"price\": \"0.0024221\",\n" +
      "      \"amount\": \"5.9303650\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 4315154,\n" +
      "        \"d\": 1782416791\n" +
      "      },\n" +
      "      \"price\": \"0.0024210\",\n" +
      "      \"amount\": \"2.6341583\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3360181,\n" +
      "        \"d\": 1397479136\n" +
      "      },\n" +
      "      \"price\": \"0.0024045\",\n" +
      "      \"amount\": \"5.9948532\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2367836,\n" +
      "        \"d\": 985908229\n" +
      "      },\n" +
      "      \"price\": \"0.0024017\",\n" +
      "      \"amount\": \"3.8896537\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 4687363,\n" +
      "        \"d\": 1952976585\n" +
      "      },\n" +
      "      \"price\": \"0.0024001\",\n" +
      "      \"amount\": \"1.5747618\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 903753,\n" +
      "        \"d\": 380636870\n" +
      "      },\n" +
      "      \"price\": \"0.0023743\",\n" +
      "      \"amount\": \"1.6182054\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2562439,\n" +
      "        \"d\": 1081514977\n" +
      "      },\n" +
      "      \"price\": \"0.0023693\",\n" +
      "      \"amount\": \"15.1310429\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2588843,\n" +
      "        \"d\": 1129671233\n" +
      "      },\n" +
      "      \"price\": \"0.0022917\",\n" +
      "      \"amount\": \"2.7172038\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3249035,\n" +
      "        \"d\": 1425861493\n" +
      "      },\n" +
      "      \"price\": \"0.0022786\",\n" +
      "      \"amount\": \"6.7610234\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 629489,\n" +
      "        \"d\": 284529942\n" +
      "      },\n" +
      "      \"price\": \"0.0022124\",\n" +
      "      \"amount\": \"8.6216043\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 1428194,\n" +
      "        \"d\": 664535371\n" +
      "      },\n" +
      "      \"price\": \"0.0021492\",\n" +
      "      \"amount\": \"11.0263350\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 1653667,\n" +
      "        \"d\": 771446377\n" +
      "      },\n" +
      "      \"price\": \"0.0021436\",\n" +
      "      \"amount\": \"26.0527506\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3613348,\n" +
      "        \"d\": 1709911165\n" +
      "      },\n" +
      "      \"price\": \"0.0021132\",\n" +
      "      \"amount\": \"1.6923954\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2674223,\n" +
      "        \"d\": 1280335392\n" +
      "      },\n" +
      "      \"price\": \"0.0020887\",\n" +
      "      \"amount\": \"0.9882259\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3594842,\n" +
      "        \"d\": 1769335169\n" +
      "      },\n" +
      "      \"price\": \"0.0020317\",\n" +
      "      \"amount\": \"6.6846233\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 1526497,\n" +
      "        \"d\": 751849545\n" +
      "      },\n" +
      "      \"price\": \"0.0020303\",\n" +
      "      \"amount\": \"3.5964310\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3935093,\n" +
      "        \"d\": 1962721319\n" +
      "      },\n" +
      "      \"price\": \"0.0020049\",\n" +
      "      \"amount\": \"8.9918771\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 1314209,\n" +
      "        \"d\": 815844646\n" +
      "      },\n" +
      "      \"price\": \"0.0016109\",\n" +
      "      \"amount\": \"11.9847854\"\n" +
      "    }\n" +
      "  ],\n" +
      "  \"asks\": [\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2017413,\n" +
      "        \"d\": 803984111\n" +
      "      },\n" +
      "      \"price\": \"0.0025093\",\n" +
      "      \"amount\": \"541.4550766\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 25093,\n" +
      "        \"d\": 10000000\n" +
      "      },\n" +
      "      \"price\": \"0.0025093\",\n" +
      "      \"amount\": \"121.9999600\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2687972,\n" +
      "        \"d\": 1067615183\n" +
      "      },\n" +
      "      \"price\": \"0.0025177\",\n" +
      "      \"amount\": \"6286.5014925\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 845303,\n" +
      "        \"d\": 332925720\n" +
      "      },\n" +
      "      \"price\": \"0.0025390\",\n" +
      "      \"amount\": \"1203.8364195\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 5147713,\n" +
      "        \"d\": 2017340695\n" +
      "      },\n" +
      "      \"price\": \"0.0025517\",\n" +
      "      \"amount\": \"668.0464888\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 13,\n" +
      "        \"d\": 5000\n" +
      "      },\n" +
      "      \"price\": \"0.0026000\",\n" +
      "      \"amount\": \"2439.9999300\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2372938,\n" +
      "        \"d\": 877879233\n" +
      "      },\n" +
      "      \"price\": \"0.0027030\",\n" +
      "      \"amount\": \"4953.5042925\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 5177131,\n" +
      "        \"d\": 1895808254\n" +
      "      },\n" +
      "      \"price\": \"0.0027308\",\n" +
      "      \"amount\": \"3691.8772552\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2219932,\n" +
      "        \"d\": 812231813\n" +
      "      },\n" +
      "      \"price\": \"0.0027331\",\n" +
      "      \"amount\": \"1948.1788496\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 4285123,\n" +
      "        \"d\": 1556796383\n" +
      "      },\n" +
      "      \"price\": \"0.0027525\",\n" +
      "      \"amount\": \"5274.3733332\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3945179,\n" +
      "        \"d\": 1402780548\n" +
      "      },\n" +
      "      \"price\": \"0.0028124\",\n" +
      "      \"amount\": \"1361.9590574\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 4683683,\n" +
      "        \"d\": 1664729678\n" +
      "      },\n" +
      "      \"price\": \"0.0028135\",\n" +
      "      \"amount\": \"5076.0909147\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 1489326,\n" +
      "        \"d\": 524639179\n" +
      "      },\n" +
      "      \"price\": \"0.0028388\",\n" +
      "      \"amount\": \"2303.2370107\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 3365104,\n" +
      "        \"d\": 1176168157\n" +
      "      },\n" +
      "      \"price\": \"0.0028611\",\n" +
      "      \"amount\": \"8080.5751770\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 2580607,\n" +
      "        \"d\": 899476885\n" +
      "      },\n" +
      "      \"price\": \"0.0028690\",\n" +
      "      \"amount\": \"3733.5054174\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 5213871,\n" +
      "        \"d\": 1788590825\n" +
      "      },\n" +
      "      \"price\": \"0.0029151\",\n" +
      "      \"amount\": \"485.7370041\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 4234565,\n" +
      "        \"d\": 1447134374\n" +
      "      },\n" +
      "      \"price\": \"0.0029262\",\n" +
      "      \"amount\": \"7936.6430110\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 674413,\n" +
      "        \"d\": 230022877\n" +
      "      },\n" +
      "      \"price\": \"0.0029319\",\n" +
      "      \"amount\": \"101.5325328\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 1554515,\n" +
      "        \"d\": 514487004\n" +
      "      },\n" +
      "      \"price\": \"0.0030215\",\n" +
      "      \"amount\": \"5407.8562112\"\n" +
      "    },\n" +
      "    {\n" +
      "      \"price_r\": {\n" +
      "        \"n\": 5638983,\n" +
      "        \"d\": 1850050675\n" +
      "      },\n" +
      "      \"price\": \"0.0030480\",\n" +
      "      \"amount\": \"3024.9341116\"\n" +
      "    }\n" +
      "  ],\n" +
      "  \"base\": {\n" +
      "    \"asset_type\": \"native\"\n" +
      "  },\n" +
      "  \"counter\": {\n" +
      "    \"asset_type\": \"credit_alphanum4\",\n" +
      "    \"asset_code\": \"DEMO\",\n" +
      "    \"asset_issuer\": \"GBAMBOOZDWZPVV52RCLJQYMQNXOBLOXWNQAY2IF2FREV2WL46DBCH3BE\"\n" +
      "  }\n" +
      "}";

  OrderBookResponse orderBook =
      OrderBookResponse.fromJson(json.decode(jsonData));

  assert(orderBook.base == new AssetTypeNative());
  assert(orderBook.counter ==
      Asset.createNonNativeAsset(
          "DEMO",
          KeyPair.fromAccountId(
              "GBAMBOOZDWZPVV52RCLJQYMQNXOBLOXWNQAY2IF2FREV2WL46DBCH3BE")));

  assert(orderBook.bids[0].amount == "31.4007644");
  assert(orderBook.bids[0].price == "0.0024224");
  assert(orderBook.bids[0].priceR.numerator == 4638606);
  assert(orderBook.bids[0].priceR.denominator == 1914900241);

  assert(orderBook.bids[1].amount == "5.9303650");
  assert(orderBook.bids[1].price == "0.0024221");

  assert(orderBook.asks[0].amount == "541.4550766");
  assert(orderBook.asks[0].price == "0.0025093");

  assert(orderBook.asks[1].amount == "121.9999600");
  assert(orderBook.asks[1].price == "0.0025093");
}

void testPathsPageDeserialize() {
  String jsonData = "{\n" +
      "    \"_embedded\": {\n" +
      "        \"records\": [\n" +
      "            {\n" +
      "                \"destination_amount\": \"20.0000000\",\n" +
      "                \"destination_asset_code\": \"EUR\",\n" +
      "                \"destination_asset_issuer\": \"GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN\",\n" +
      "                \"destination_asset_type\": \"credit_alphanum4\",\n" +
      "                \"path\": [],\n" +
      "                \"source_amount\": \"30.0000000\",\n" +
      "                \"source_asset_code\": \"USD\",\n" +
      "                \"source_asset_issuer\": \"GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN\",\n" +
      "                \"source_asset_type\": \"credit_alphanum4\"\n" +
      "            },\n" +
      "            {\n" +
      "                \"destination_amount\": \"50.0000000\",\n" +
      "                \"destination_asset_code\": \"EUR\",\n" +
      "                \"destination_asset_issuer\": \"GBFMFKDUFYYITWRQXL4775CVUV3A3WGGXNJUAP4KTXNEQ2HG7JRBITGH\",\n" +
      "                \"destination_asset_type\": \"credit_alphanum4\",\n" +
      "                \"path\": [\n" +
      "                    {\n" +
      "                        \"asset_code\": \"GBP\",\n" +
      "                        \"asset_issuer\": \"GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN\",\n" +
      "                        \"asset_type\": \"credit_alphanum4\"\n" +
      "                    }\n" +
      "                ],\n" +
      "                \"source_amount\": \"60.0000000\",\n" +
      "                \"source_asset_code\": \"USD\",\n" +
      "                \"source_asset_issuer\": \"GBRAOXQDNQZRDIOK64HZI4YRDTBFWNUYH3OIHQLY4VEK5AIGMQHCLGXI\",\n" +
      "                \"source_asset_type\": \"credit_alphanum4\"\n" +
      "            },\n" +
      "            {\n" +
      "                \"destination_amount\": \"200.0000000\",\n" +
      "                \"destination_asset_code\": \"EUR\",\n" +
      "                \"destination_asset_issuer\": \"GBRCOBK7C7UE72PB5JCPQU3ZI45ZCEM7HKQ3KYV3YD3XB7EBOPBEDN2G\",\n" +
      "                \"destination_asset_type\": \"credit_alphanum4\",\n" +
      "                \"path\": [\n" +
      "                    {\n" +
      "                        \"asset_code\": \"GBP\",\n" +
      "                        \"asset_issuer\": \"GAX7B3ZT3EOZW5POAMV4NGPPKCYUOYW2QQDIAF23JAXF72NMGRYPYOPM\",\n" +
      "                        \"asset_type\": \"credit_alphanum4\"\n" +
      "                    },\n" +
      "                    {\n" +
      "                        \"asset_code\": \"PLN\",\n" +
      "                        \"asset_issuer\": \"GACWIA2XGDFWWN3WKPX63JTK4S2J5NDPNOIVYMZY6RVTS7LWF2VHZLV3\",\n" +
      "                        \"asset_type\": \"credit_alphanum4\"\n" +
      "                    }\n" +
      "                ],\n" +
      "                \"source_amount\": \"300.0000000\",\n" +
      "                \"source_asset_code\": \"USD\",\n" +
      "                \"source_asset_issuer\": \"GC7J5IHS3GABSX7AZLRINXWLHFTL3WWXLU4QX2UGSDEAIAQW2Q72U3KH\",\n" +
      "                \"source_asset_type\": \"credit_alphanum4\"\n" +
      "            }        ]\n" +
      "    },\n" +
      "    \"_links\": {\n" +
      "        \"self\": {\n" +
      "            \"href\": \"/paths\"\n" +
      "        }\n" +
      "    }\n" +
      "}";

  Page<PathResponse> pathsPage =
      Page<PathResponse>.fromJson(json.decode(jsonData));

  assert(pathsPage.records[0].destinationAmount == "20.0000000");
  assert(pathsPage.records[0].destinationAsset ==
      Asset.createNonNativeAsset(
          "EUR",
          KeyPair.fromAccountId(
              "GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN")));
  assert(pathsPage.records[0].path.length == 0);
  assert(pathsPage.records[0].sourceAmount == "30.0000000");
  assert(pathsPage.records[0].sourceAsset ==
      Asset.createNonNativeAsset(
          "USD",
          KeyPair.fromAccountId(
              "GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN")));

  assert(pathsPage.records[1].destinationAmount == "50.0000000");
  assert(pathsPage.records[1].destinationAsset ==
      Asset.createNonNativeAsset(
          "EUR",
          KeyPair.fromAccountId(
              "GBFMFKDUFYYITWRQXL4775CVUV3A3WGGXNJUAP4KTXNEQ2HG7JRBITGH")));
  assert(pathsPage.records[1].path.length == 1);
  assert(pathsPage.records[1].path[0] ==
      Asset.createNonNativeAsset(
          "GBP",
          KeyPair.fromAccountId(
              "GDSBCQO34HWPGUGQSP3QBFEXVTSR2PW46UIGTHVWGWJGQKH3AFNHXHXN")));
  assert(pathsPage.records[1].sourceAmount == "60.0000000");
  assert(pathsPage.records[1].sourceAsset ==
      Asset.createNonNativeAsset(
          "USD",
          KeyPair.fromAccountId(
              "GBRAOXQDNQZRDIOK64HZI4YRDTBFWNUYH3OIHQLY4VEK5AIGMQHCLGXI")));

  assert(pathsPage.records[2].destinationAmount == "200.0000000");
  assert(pathsPage.records[2].destinationAsset ==
      Asset.createNonNativeAsset(
          "EUR",
          KeyPair.fromAccountId(
              "GBRCOBK7C7UE72PB5JCPQU3ZI45ZCEM7HKQ3KYV3YD3XB7EBOPBEDN2G")));
  assert(pathsPage.records[2].path.length == 2);
  assert(pathsPage.records[2].path[0] ==
      Asset.createNonNativeAsset(
          "GBP",
          KeyPair.fromAccountId(
              "GAX7B3ZT3EOZW5POAMV4NGPPKCYUOYW2QQDIAF23JAXF72NMGRYPYOPM")));
  assert(pathsPage.records[2].path[1] ==
      Asset.createNonNativeAsset(
          "PLN",
          KeyPair.fromAccountId(
              "GACWIA2XGDFWWN3WKPX63JTK4S2J5NDPNOIVYMZY6RVTS7LWF2VHZLV3")));
  assert(pathsPage.records[2].sourceAmount == "300.0000000");
  assert(pathsPage.records[2].sourceAsset ==
      Asset.createNonNativeAsset(
          "USD",
          KeyPair.fromAccountId(
              "GC7J5IHS3GABSX7AZLRINXWLHFTL3WWXLU4QX2UGSDEAIAQW2Q72U3KH")));
}

void testRootDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"account\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/accounts/{account_id}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"account_transactions\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/accounts/{account_id}/transactions{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"assets\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/assets{?asset_code,asset_issuer,cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"friendbot\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/friendbot{?addr}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"metrics\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/metrics\"\n" +
      "    },\n" +
      "    \"order_book\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/order_book{?selling_asset_type,selling_asset_code,selling_issuer,buying_asset_type,buying_asset_code,buying_issuer,limit}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/\"\n" +
      "    },\n" +
      "    \"transaction\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/transactions/{hash}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"transactions\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/transactions{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    }\n" +
      "  },\n" +
      "  \"horizon_version\": \"snapshot-c5fe0ff\",\n" +
      "  \"core_version\": \"stellar-core 9.2.0 (7561c1d53366ec79b908de533726269e08474f77)\",\n" +
      "  \"history_latest_ledger\": 18369116,\n" +
      "  \"history_elder_ledger\": 1,\n" +
      "  \"core_latest_ledger\": 18369117,\n" +
      "  \"network_passphrase\": \"Public Global Stellar Network ; September 2015\",\n" +
      "  \"protocol_version\": 9\n" +
      "}";

  RootResponse root = RootResponse.fromJson(json.decode(jsonData));

  assert(root.horizonVersion == "snapshot-c5fe0ff");
  assert(root.stellarCoreVersion ==
      "stellar-core 9.2.0 (7561c1d53366ec79b908de533726269e08474f77)");
  assert(root.historyLatestLedger == 18369116);
  assert(root.historyElderLedger == 1);
  assert(root.coreLatestLedger == 18369117);
  assert(root.networkPassphrase ==
      "Public Global Stellar Network ; September 2015");
  assert(root.protocolVersion == 9);
}

void testSubmitTransactionResponseDeserializeTransactionFailureResponse() {
  String jsonData = "{\n" +
      "  \"type\": \"https://stellar.org/horizon-errors/transaction_failed\",\n" +
      "  \"title\": \"Transaction Failed\",\n" +
      "  \"status\": 400,\n" +
      "  \"detail\": \"The transaction failed when submitted to the stellar network. The `extras.result_codes` field on this response contains further details.  Descriptions of each code can be found at: https://www.stellar.org/developers/learn/concepts/list-of-operations.html\",\n" +
      "  \"instance\": \"horizon-testnet-001.prd.stellar001.internal.stellar-ops.com/4elYz2fHhC-528285\",\n" +
      "  \"extras\": {\n" +
      "    \"envelope_xdr\": \"AAAAAKpmDL6Z4hvZmkTBkYpHftan4ogzTaO4XTB7joLgQnYYAAAAZAAAAAAABeoyAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAAAAD3sEVVGZGi/NoC3ta/8f/YZKMzyi9ZJpOi0H47x7IqYAAAAAAAAAAAF9eEAAAAAAAAAAAA=\",\n" +
      "    \"result_codes\": {\n" +
      "      \"transaction\": \"tx_no_source_account\"\n" +
      "    },\n" +
      "    \"result_xdr\": \"AAAAAAAAAAD////4AAAAAA==\"\n" +
      "  }\n" +
      "}";

  SubmitTransactionResponse submitTransactionResponse =
      SubmitTransactionResponse.fromJson(json.decode(jsonData));
  assert(submitTransactionResponse.success == false);
  assert(submitTransactionResponse.envelopeXdr ==
      "AAAAAKpmDL6Z4hvZmkTBkYpHftan4ogzTaO4XTB7joLgQnYYAAAAZAAAAAAABeoyAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAAAAD3sEVVGZGi/NoC3ta/8f/YZKMzyi9ZJpOi0H47x7IqYAAAAAAAAAAAF9eEAAAAAAAAAAAA=");
  assert(submitTransactionResponse.resultXdr == "AAAAAAAAAAD////4AAAAAA==");
  assert(submitTransactionResponse.extras.resultCodes.transactionResultCode ==
      "tx_no_source_account");
}

void testSubmitTransactionResponseDeserializeOperationFailureResponse() {
  String jsonData = "{\n" +
      "  \"type\": \"https://stellar.org/horizon-errors/transaction_failed\",\n" +
      "  \"title\": \"Transaction Failed\",\n" +
      "  \"status\": 400,\n" +
      "  \"detail\": \"The transaction failed when submitted to the stellar network. The `extras.result_codes` field on this response contains further details.  Descriptions of each code can be found at: https://www.stellar.org/developers/learn/concepts/list-of-operations.html\",\n" +
      "  \"instance\": \"horizon-testnet-001.prd.stellar001.internal.stellar-ops.com/4elYz2fHhC-528366\",\n" +
      "  \"extras\": {\n" +
      "    \"envelope_xdr\": \"AAAAAF2O0axA67+p2jMunG6G188kDSHIvqQ13d9l29YCSA/uAAAAZAAvvc0AAAABAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAAAAD3sEVVGZGi/NoC3ta/8f/YZKMzyi9ZJpOi0H47x7IqYAAAAAAAAAAAF9eEAAAAAAAAAAAECSA/uAAAAQFuZVAjftHa+JZes1VxSk8naOfjjAz9V86mY1AZf8Ik6PtTsBpDsCfG57EYsq4jWyZcT+vhXyWsw5evF1ELqMw4=\",\n" +
      "    \"result_codes\": {\n" +
      "      \"transaction\": \"tx_failed\",\n" +
      "      \"operations\": [\n" +
      "        \"op_no_destination\"\n" +
      "      ]\n" +
      "    },\n" +
      "    \"result_xdr\": \"AAAAAAAAAGT/////AAAAAQAAAAAAAAAB////+wAAAAA=\"\n" +
      "  }\n" +
      "}";

  SubmitTransactionResponse submitTransactionResponse =
      SubmitTransactionResponse.fromJson(json.decode(jsonData));
  assert(submitTransactionResponse.success == false);
  assert(submitTransactionResponse.envelopeXdr ==
      "AAAAAF2O0axA67+p2jMunG6G188kDSHIvqQ13d9l29YCSA/uAAAAZAAvvc0AAAABAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAAAAD3sEVVGZGi/NoC3ta/8f/YZKMzyi9ZJpOi0H47x7IqYAAAAAAAAAAAF9eEAAAAAAAAAAAECSA/uAAAAQFuZVAjftHa+JZes1VxSk8naOfjjAz9V86mY1AZf8Ik6PtTsBpDsCfG57EYsq4jWyZcT+vhXyWsw5evF1ELqMw4=");
  assert(submitTransactionResponse.resultXdr ==
      "AAAAAAAAAGT/////AAAAAQAAAAAAAAAB////+wAAAAA=");
  assert(submitTransactionResponse.extras.resultCodes.transactionResultCode ==
      "tx_failed");
  assert(
      submitTransactionResponse.extras.resultCodes.operationsResultCodes[0] ==
          "op_no_destination");
}

void testSubmitTransactionResponseDeserializeSuccessResponse() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"transaction\": {\n" +
      "      \"href\": \"https://horizon-testnet.stellar.org/transactions/ee14b93fcd31d4cfe835b941a0a8744e23a6677097db1fafe0552d8657bed940\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"hash\": \"ee14b93fcd31d4cfe835b941a0a8744e23a6677097db1fafe0552d8657bed940\",\n" +
      "  \"ledger\": 3128812,\n" +
      "  \"envelope_xdr\": \"AAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAZAAT3TUAAAAwAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABSU5SAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAAAFVU0QAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAX14QAAAAAKAAAAAQAAAAAAAAAAAAAAAAAAAAG/dhGXAAAAQLuStfImg0OeeGAQmvLkJSZ1MPSkCzCYNbGqX5oYNuuOqZ5SmWhEsC7uOD9ha4V7KengiwNlc0oMNqBVo22S7gk=\",\n" +
      "  \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAAAAPEAAAABSU5SAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAAAFVU0QAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAX14QAAAAAKAAAAAQAAAAAAAAAAAAAAAA==\",\n" +
      "  \"result_meta_xdr\": \"AAAAAAAAAAEAAAACAAAAAAAvoHwAAAACAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAAAAPEAAAABSU5SAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAAAFVU0QAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAX14QAAAAAKAAAAAQAAAAAAAAAAAAAAAAAAAAEAL6B8AAAAAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAABZ9zvNAABPdNQAAADAAAAAEAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==\"\n" +
      "}";

  SubmitTransactionResponse submitTransactionResponse =
      SubmitTransactionResponse.fromJson(json.decode(jsonData));
  assert(submitTransactionResponse.success == true);
  assert(submitTransactionResponse.hash ==
      "ee14b93fcd31d4cfe835b941a0a8744e23a6677097db1fafe0552d8657bed940");
  assert(submitTransactionResponse.ledger == 3128812);
  assert(submitTransactionResponse.envelopeXdr ==
      "AAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAZAAT3TUAAAAwAAAAAAAAAAAAAAABAAAAAAAAAAMAAAABSU5SAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAAAFVU0QAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAX14QAAAAAKAAAAAQAAAAAAAAAAAAAAAAAAAAG/dhGXAAAAQLuStfImg0OeeGAQmvLkJSZ1MPSkCzCYNbGqX5oYNuuOqZ5SmWhEsC7uOD9ha4V7KengiwNlc0oMNqBVo22S7gk=");
  assert(submitTransactionResponse.resultXdr ==
      "AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAAAAAAAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAAAAPEAAAABSU5SAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAAAFVU0QAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAX14QAAAAAKAAAAAQAAAAAAAAAAAAAAAA==");
  assert(submitTransactionResponse.getOfferIdFromResult(0) == 241);
}

void testSubmitTransactionResponseDeserializeNoOfferID() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"transaction\": {\n" +
      "      \"href\": \"https://horizon-testnet.stellar.org/transactions/ee14b93fcd31d4cfe835b941a0a8744e23a6677097db1fafe0552d8657bed940\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"hash\": \"ee14b93fcd31d4cfe835b941a0a8744e23a6677097db1fafe0552d8657bed940\",\n" +
      "  \"ledger\": 3128812,\n" +
      "  \"envelope_xdr\": \"AAAAAP0uDCJGzWofMAUkG/F3YCPctgLkeP3VTr3P1mHKznAHAAAAZAA5klgAAABLAAAAAAAAAAAAAAABAAAAAQAAAAD9LgwiRs1qHzAFJBvxd2Aj3LYC5Hj91U69z9Zhys5wBwAAAAMAAAABRVVSAAAAAAD9LgwiRs1qHzAFJBvxd2Aj3LYC5Hj91U69z9Zhys5wBwAAAAFVU0QAAAAAAOw4Vbv3zJ23hiG1bjU7M/AOuVNHKnREERoitIr1Zj/ZAAAAAAOThwAAAAACAAAAAQAAAAAAAAAAAAAAAAAAAAHKznAHAAAAQEe1jyNCeK3TckPuuKeWIICf6nvz2zBZ8mbbUamWLnOFMMqvQPTllOe9DIdloNxaixgle9zi2F+yyOhLzpNhkAg=\",\n" +
      "  \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAADAAAAAAAAAAEAAAAA7DhVu/fMnbeGIbVuNTsz8A65U0cqdEQRGiK0ivVmP9kAAAAAAAASJQAAAAFVU0QAAAAAAOw4Vbv3zJ23hiG1bjU7M/AOuVNHKnREERoitIr1Zj/ZAAAAAAcnDgAAAAABRVVSAAAAAAD9LgwiRs1qHzAFJBvxd2Aj3LYC5Hj91U69z9Zhys5wBwAAAAADk4cAAAAAAgAAAAA=\",\n" +
      "  \"result_meta_xdr\": \"AAAAAAAAAAEAAAACAAAAAAAvoHwAAAACAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAAAAPEAAAABSU5SAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAAAFVU0QAAAAAADSMMRmQGDH6EJzkgi/7PoKhphMHyNGQgDp2tlS/dhGXAAAAAAX14QAAAAAKAAAAAQAAAAAAAAAAAAAAAAAAAAEAL6B8AAAAAAAAAAA0jDEZkBgx+hCc5IIv+z6CoaYTB8jRkIA6drZUv3YRlwAAABZ9zvNAABPdNQAAADAAAAAEAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==\"\n" +
      "}";

  SubmitTransactionResponse submitTransactionResponse =
      SubmitTransactionResponse.fromJson(json.decode(jsonData));
  assert(submitTransactionResponse.success == true);
  assert(submitTransactionResponse.getOfferIdFromResult(0) == null);
}

void testTradeAggregationsPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"self\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/trade_aggregations?base_asset_type=native\\u0026start_time=1512689100000\\u0026counter_asset_issuer=GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH\\u0026limit=200\\u0026end_time=1512775500000\\u0026counter_asset_type=credit_alphanum4\\u0026resolution=300000\\u0026order=asc\\u0026counter_asset_code=BTC\"\n" +
      "    },\n" +
      "    \"next\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/trade_aggregations?base_asset_type=native\\u0026counter_asset_code=BTC\\u0026counter_asset_issuer=GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH\\u0026counter_asset_type=credit_alphanum4\\u0026end_time=1512775500000\\u0026limit=200\\u0026order=asc\\u0026resolution=300000\\u0026start_time=1512765000000\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"timestamp\": 1512731100000,\n" +
      "        \"trade_count\": 2,\n" +
      "        \"base_volume\": \"341.8032786\",\n" +
      "        \"counter_volume\": \"0.0041700\",\n" +
      "        \"avg\": \"0.0000122\",\n" +
      "        \"high\": \"0.0000123\",\n" +
      "        \"low\": \"0.0000124\",\n" +
      "        \"open\": \"0.0000125\",\n" +
      "        \"close\": \"0.0000126\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"timestamp\": 1512732300000,\n" +
      "        \"trade_count\": 1,\n" +
      "        \"base_volume\": \"233.6065573\",\n" +
      "        \"counter_volume\": \"0.0028500\",\n" +
      "        \"avg\": \"0.0000122\",\n" +
      "        \"high\": \"0.0000122\",\n" +
      "        \"low\": \"0.0000122\",\n" +
      "        \"open\": \"0.0000122\",\n" +
      "        \"close\": \"0.0000122\"\n" +
      "      },\n" +
      "      {\n" +
      "        \"timestamp\": 1512764700000,\n" +
      "        \"trade_count\": 1,\n" +
      "        \"base_volume\": \"451.0000000\",\n" +
      "        \"counter_volume\": \"0.0027962\",\n" +
      "        \"avg\": \"0.0000062\",\n" +
      "        \"high\": \"0.0000062\",\n" +
      "        \"low\": \"0.0000062\",\n" +
      "        \"open\": \"0.0000062\",\n" +
      "        \"close\": \"0.0000062\"\n" +
      "      }\n" +
      "    ]\n" +
      "  }\n" +
      "}";

  Page<TradeAggregationResponse> page =
      Page<TradeAggregationResponse>.fromJson(json.decode(jsonData));

  assert(page.links.self.href ==
      "https://horizon.stellar.org/trade_aggregations?base_asset_type=native&start_time=1512689100000&counter_asset_issuer=GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH&limit=200&end_time=1512775500000&counter_asset_type=credit_alphanum4&resolution=300000&order=asc&counter_asset_code=BTC");
  assert(page.links.next.href ==
      "https://horizon.stellar.org/trade_aggregations?base_asset_type=native&counter_asset_code=BTC&counter_asset_issuer=GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH&counter_asset_type=credit_alphanum4&end_time=1512775500000&limit=200&order=asc&resolution=300000&start_time=1512765000000");

  assert(page.records[0].timestamp == 1512731100000);
  assert(page.records[0].tradeCount == 2);
  assert(page.records[0].baseVolume == "341.8032786");
  assert(page.records[0].counterVolume == "0.0041700");
  assert(page.records[0].avg == "0.0000122");
  assert(page.records[0].high == "0.0000123");
  assert(page.records[0].low == "0.0000124");
  assert(page.records[0].open == "0.0000125");
  assert(page.records[0].close == "0.0000126");
}

void testTradesPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"self\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/trades?cursor=\\u0026limit=10\\u0026order=asc\"\n" +
      "    },\n" +
      "    \"next\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/trades?cursor=3748308153536513-0\\u0026limit=10\\u0026order=asc\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"https://horizon.stellar.org/trades?cursor=3697472920621057-0\\u0026limit=10\\u0026order=desc\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3697472920621057\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3697472920621057-0\",\n" +
      "        \"paging_token\": \"3697472920621057-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T03:47:47Z\",\n" +
      "        \"offer_id\": \"9\",\n" +
      "        \"base_offer_id\": \"10\",\n" +
      "        \"base_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"base_amount\": \"10.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_offer_id\": \"11\",\n" +
      "        \"counter_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"counter_amount\": \"2.6700000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 267,\n" +
      "          \"d\": 1000\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3697472920621057\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3697472920621057-1\",\n" +
      "        \"paging_token\": \"3697472920621057-1\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T03:47:47Z\",\n" +
      "        \"offer_id\": \"4\",\n" +
      "        \"base_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"base_amount\": \"10.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"counter_amount\": \"2.6800000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 67,\n" +
      "          \"d\": 250\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3697472920621057\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3697472920621057-2\",\n" +
      "        \"paging_token\": \"3697472920621057-2\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T03:47:47Z\",\n" +
      "        \"offer_id\": \"8\",\n" +
      "        \"base_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"base_amount\": \"20.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"counter_amount\": \"5.3600000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 67,\n" +
      "          \"d\": 250\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3712329212497921\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3712329212497921-0\",\n" +
      "        \"paging_token\": \"3712329212497921-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T07:26:21Z\",\n" +
      "        \"offer_id\": \"36\",\n" +
      "        \"base_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"base_amount\": \"5.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"counter_amount\": \"1.2000192\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": false,\n" +
      "        \"price\": {\n" +
      "          \"n\": 5000,\n" +
      "          \"d\": 20833\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3716237632737281\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3716237632737281-0\",\n" +
      "        \"paging_token\": \"3716237632737281-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T08:27:26Z\",\n" +
      "        \"offer_id\": \"37\",\n" +
      "        \"base_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"base_amount\": \"10.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"counter_amount\": \"2.4500000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 49,\n" +
      "          \"d\": 200\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3716302057246721\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3716302057246721-0\",\n" +
      "        \"paging_token\": \"3716302057246721-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T08:28:40Z\",\n" +
      "        \"offer_id\": \"35\",\n" +
      "        \"base_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"base_amount\": \"10.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"counter_amount\": \"2.5000000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 1,\n" +
      "          \"d\": 4\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3716302057246721\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3716302057246721-1\",\n" +
      "        \"paging_token\": \"3716302057246721-1\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T08:28:40Z\",\n" +
      "        \"offer_id\": \"34\",\n" +
      "        \"base_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"base_amount\": \"10.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"counter_amount\": \"3.0000000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 3,\n" +
      "          \"d\": 10\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3725961438695425\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3725961438695425-0\",\n" +
      "        \"paging_token\": \"3725961438695425-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T11:09:30Z\",\n" +
      "        \"offer_id\": \"47\",\n" +
      "        \"base_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"base_amount\": \"5.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"counter_amount\": \"1.0000000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": false,\n" +
      "        \"price\": {\n" +
      "          \"n\": 1,\n" +
      "          \"d\": 5\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3748080520269825\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3748080520269825-0\",\n" +
      "        \"paging_token\": \"3748080520269825-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T16:56:09Z\",\n" +
      "        \"offer_id\": \"53\",\n" +
      "        \"base_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"base_amount\": \"10.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"counter_amount\": \"3.0000000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 3,\n" +
      "          \"d\": 10\n" +
      "        }\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"self\": {\n" +
      "            \"href\": \"\"\n" +
      "          },\n" +
      "          \"base\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\"\n" +
      "          },\n" +
      "          \"counter\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/accounts/GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\"\n" +
      "          },\n" +
      "          \"operation\": {\n" +
      "            \"href\": \"https://horizon.stellar.org/operations/3748308153536513\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3748308153536513-0\",\n" +
      "        \"paging_token\": \"3748308153536513-0\",\n" +
      "        \"ledger_close_time\": \"2015-11-18T16:59:37Z\",\n" +
      "        \"offer_id\": \"59\",\n" +
      "        \"base_account\": \"GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G\",\n" +
      "        \"base_amount\": \"30.0000000\",\n" +
      "        \"base_asset_type\": \"native\",\n" +
      "        \"counter_account\": \"GBB4JST32UWKOLGYYSCEYBHBCOFL2TGBHDVOMZP462ET4ZRD4ULA7S2L\",\n" +
      "        \"counter_amount\": \"9.0000000\",\n" +
      "        \"counter_asset_type\": \"credit_alphanum4\",\n" +
      "        \"counter_asset_code\": \"JPY\",\n" +
      "        \"counter_asset_issuer\": \"GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM\",\n" +
      "        \"base_is_seller\": true,\n" +
      "        \"price\": {\n" +
      "          \"n\": 3,\n" +
      "          \"d\": 10\n" +
      "        }\n" +
      "      }\n" +
      "    ]\n" +
      "  }\n" +
      "}";

  Page<TradeResponse> tradesPage =
      Page<TradeResponse>.fromJson(json.decode(jsonData));

  assert(tradesPage.links.next.href ==
      "https://horizon.stellar.org/trades?cursor=3748308153536513-0&limit=10&order=asc");
  assert(tradesPage.links.prev.href ==
      "https://horizon.stellar.org/trades?cursor=3697472920621057-0&limit=10&order=desc");
  assert(tradesPage.links.self.href ==
      "https://horizon.stellar.org/trades?cursor=&limit=10&order=asc");

  assert(tradesPage.records[0].id == "3697472920621057-0");
  assert(tradesPage.records[0].pagingToken == "3697472920621057-0");
  assert(tradesPage.records[0].ledgerCloseTime == "2015-11-18T03:47:47Z");
  assert(tradesPage.records[0].offerId == "9");
  assert(tradesPage.records[0].baseOfferId == "10");
  assert(tradesPage.records[0].counterOfferId == "11");

  assert(tradesPage.records[0].baseAsset == new AssetTypeNative());
  assert(tradesPage.records[0].counterAsset ==
      Asset.createNonNativeAsset(
          "JPY",
          KeyPair.fromAccountId(
              "GBVAOIACNSB7OVUXJYC5UE2D4YK2F7A24T7EE5YOMN4CE6GCHUTOUQXM")));
  assert(tradesPage.records[0].price.numerator == 267);
  assert(tradesPage.records[0].price.denominator == 1000);

  assert(tradesPage.records[1].baseAccount.accountId ==
      "GAVH5JM5OKXGMQDS7YPRJ4MQCPXJUGH26LYQPQJ4SOMOJ4SXY472ZM7G");
}

void testTransactionDeserialize() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"account\": {\n" +
      "      \"href\": \"/accounts/GCUB7JL4APK7LKJ6MZF7Q2JTLHAGNBIUA7XIXD5SQTG52GQ2DAT6XZMK\"\n" +
      "    },\n" +
      "    \"effects\": {\n" +
      "      \"href\": \"/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b/effects{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"ledger\": {\n" +
      "      \"href\": \"/ledgers/915744\"\n" +
      "    },\n" +
      "    \"operations\": {\n" +
      "      \"href\": \"/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b/operations{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"precedes\": {\n" +
      "      \"href\": \"/transactions?cursor=3933090531512320\\u0026order=asc\"\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b\"\n" +
      "    },\n" +
      "    \"succeeds\": {\n" +
      "      \"href\": \"/transactions?cursor=3933090531512320\\u0026order=desc\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"id\": \"5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b\",\n" +
      "  \"paging_token\": \"3933090531512320\",\n" +
      "  \"hash\": \"5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b\",\n" +
      "  \"ledger\": 915744,\n" +
      "  \"created_at\": \"2015-11-20T17:01:28Z\",\n" +
      "  \"source_account\": \"GCUB7JL4APK7LKJ6MZF7Q2JTLHAGNBIUA7XIXD5SQTG52GQ2DAT6XZMK\",\n" +
      "  \"source_account_sequence\": 2373051035426646,\n" +
      "  \"fee_paid\": 100,\n" +
      "  \"operation_count\": 1,\n" +
      "  \"envelope_xdr\": \"AAAAAKgfpXwD1fWpPmZL+GkzWcBmhRQH7ouPsoTN3RoaGCfrAAAAZAAIbkcAAB9WAAAAAAAAAANRBBZE6D1qyGjISUGLY5Ldvp31PwAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAAAAAAAAADA7RnarSzCwj3OT+M2btCMFpVBdqxJS+Sr00qBjtFv7gAAAABLCs/QAAAAAAAAAAEaGCfrAAAAQG/56Cj2J8W/KCZr+oC4sWND1CTGWfaccHNtuibQH8kZIb+qBSDY94g7hiaAXrlIeg9b7oz/XuP3x9MWYw2jtwM=\",\n" +
      "  \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=\",\n" +
      "  \"result_meta_xdr\": \"AAAAAAAAAAEAAAACAAAAAAAN+SAAAAAAAAAAAMDtGdqtLMLCPc5P4zZu0IwWlUF2rElL5KvTSoGO0W/uAAAAAEsKz9AADfkgAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAN+SAAAAAAAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAHp6WMr55YACD1BAAAAHgAAAAoAAAAAAAAAAAAAAAABAAAAAAAACgAAAAARC07BokpLTOF+/vVKBwiAlop7hHGJTNeGGlY4MoPykwAAAAEAAAAAK+Lzfd3yDD+Ov0GbYu1g7SaIBrKZeBUxoCunkLuI7aoAAAABAAAAAERmsKL73CyLV/HvjyQCERDXXpWE70Xhyb6MR5qPO3yQAAAAAQAAAABSORGwAdyuanN3sNOHqNSpACyYdkUM3L8VafUu69EvEgAAAAEAAAAAeCzqJNkMM/jLvyuMIfyFHljBlLCtDyj17RMycPuNtRMAAAABAAAAAIEi4R7juq15ymL00DNlAddunyFT4FyUD4muC4t3bobdAAAAAQAAAACaNpLL5YMfjOTdXVEqrAh99LM12sN6He6pHgCRAa1f1QAAAAEAAAAAqB+lfAPV9ak+Zkv4aTNZwGaFFAfui4+yhM3dGhoYJ+sAAAABAAAAAMNJrEvdMg6M+M+n4BDIdzsVSj/ZI9SvAp7mOOsvAD/WAAAAAQAAAADbHA6xiKB1+G79mVqpsHMOleOqKa5mxDpP5KEp/Xdz9wAAAAEAAAAAAAAAAA==\",\n" +
      "  \"memo_type\": \"hash\",\n" +
      "  \"memo\": \"UQQWROg9ashoyElBi2OS3b6d9T8AAAAAAAAAAAAAAAA=\",\n" +
      "  \"signatures\": [\n" +
      "    \"b/noKPYnxb8oJmv6gLixY0PUJMZZ9pxwc226JtAfyRkhv6oFINj3iDuGJoBeuUh6D1vujP9e4/fH0xZjDaO3Aw==\"\n" +
      "  ]\n" +
      "}";

  TransactionResponse transaction =
      TransactionResponse.fromJson(json.decode(jsonData));
  assert(transaction.hash ==
      "5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b");
  assert(transaction.ledger == 915744);
  assert(transaction.createdAt == "2015-11-20T17:01:28Z");
  assert(transaction.pagingToken == "3933090531512320");
  assert(transaction.sourceAccount.accountId ==
      "GCUB7JL4APK7LKJ6MZF7Q2JTLHAGNBIUA7XIXD5SQTG52GQ2DAT6XZMK");
  assert(transaction.sourceAccountSequence == 2373051035426646);
  assert(transaction.feePaid == 100);
  assert(transaction.operationCount == 1);
  assert(transaction.envelopeXdr ==
      "AAAAAKgfpXwD1fWpPmZL+GkzWcBmhRQH7ouPsoTN3RoaGCfrAAAAZAAIbkcAAB9WAAAAAAAAAANRBBZE6D1qyGjISUGLY5Ldvp31PwAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAAAAAAAAADA7RnarSzCwj3OT+M2btCMFpVBdqxJS+Sr00qBjtFv7gAAAABLCs/QAAAAAAAAAAEaGCfrAAAAQG/56Cj2J8W/KCZr+oC4sWND1CTGWfaccHNtuibQH8kZIb+qBSDY94g7hiaAXrlIeg9b7oz/XuP3x9MWYw2jtwM=");
  assert(
      transaction.resultXdr == "AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=");
  assert(transaction.resultMetaXdr ==
      "AAAAAAAAAAEAAAACAAAAAAAN+SAAAAAAAAAAAMDtGdqtLMLCPc5P4zZu0IwWlUF2rElL5KvTSoGO0W/uAAAAAEsKz9AADfkgAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAN+SAAAAAAAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAHp6WMr55YACD1BAAAAHgAAAAoAAAAAAAAAAAAAAAABAAAAAAAACgAAAAARC07BokpLTOF+/vVKBwiAlop7hHGJTNeGGlY4MoPykwAAAAEAAAAAK+Lzfd3yDD+Ov0GbYu1g7SaIBrKZeBUxoCunkLuI7aoAAAABAAAAAERmsKL73CyLV/HvjyQCERDXXpWE70Xhyb6MR5qPO3yQAAAAAQAAAABSORGwAdyuanN3sNOHqNSpACyYdkUM3L8VafUu69EvEgAAAAEAAAAAeCzqJNkMM/jLvyuMIfyFHljBlLCtDyj17RMycPuNtRMAAAABAAAAAIEi4R7juq15ymL00DNlAddunyFT4FyUD4muC4t3bobdAAAAAQAAAACaNpLL5YMfjOTdXVEqrAh99LM12sN6He6pHgCRAa1f1QAAAAEAAAAAqB+lfAPV9ak+Zkv4aTNZwGaFFAfui4+yhM3dGhoYJ+sAAAABAAAAAMNJrEvdMg6M+M+n4BDIdzsVSj/ZI9SvAp7mOOsvAD/WAAAAAQAAAADbHA6xiKB1+G79mVqpsHMOleOqKa5mxDpP5KEp/Xdz9wAAAAEAAAAAAAAAAA==");

  assert(transaction.memo is MemoHash == true);
  MemoHash memo = transaction.memo as MemoHash;
  assert("51041644e83d6ac868c849418b6392ddbe9df53f000000000000000000000000" ==
      memo.hexValue);

  assert(transaction.links.account.href ==
      "/accounts/GCUB7JL4APK7LKJ6MZF7Q2JTLHAGNBIUA7XIXD5SQTG52GQ2DAT6XZMK");
  assert(transaction.links.effects.href ==
      "/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b/effects{?cursor,limit,order}");
  assert(transaction.links.ledger.href == "/ledgers/915744");
  assert(transaction.links.operations.href ==
      "/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b/operations{?cursor,limit,order}");
  assert(transaction.links.precedes.href ==
      "/transactions?cursor=3933090531512320&order=asc");
  assert(transaction.links.self.href ==
      "/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b");
  assert(transaction.links.succeeds.href ==
      "/transactions?cursor=3933090531512320&order=desc");
}

void testTransactionDeserializeWithoutMemo() {
  String jsonData = "{\n" +
      "  \"_links\": {\n" +
      "    \"account\": {\n" +
      "      \"href\": \"/accounts/GCUB7JL4APK7LKJ6MZF7Q2JTLHAGNBIUA7XIXD5SQTG52GQ2DAT6XZMK\"\n" +
      "    },\n" +
      "    \"effects\": {\n" +
      "      \"href\": \"/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b/effects{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"ledger\": {\n" +
      "      \"href\": \"/ledgers/915744\"\n" +
      "    },\n" +
      "    \"operations\": {\n" +
      "      \"href\": \"/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b/operations{?cursor,limit,order}\",\n" +
      "      \"templated\": true\n" +
      "    },\n" +
      "    \"precedes\": {\n" +
      "      \"href\": \"/transactions?cursor=3933090531512320\\u0026order=asc\"\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/transactions/5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b\"\n" +
      "    },\n" +
      "    \"succeeds\": {\n" +
      "      \"href\": \"/transactions?cursor=3933090531512320\\u0026order=desc\"\n" +
      "    }\n" +
      "  },\n" +
      "  \"id\": \"5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b\",\n" +
      "  \"paging_token\": \"3933090531512320\",\n" +
      "  \"hash\": \"5c2e4dad596941ef944d72741c8f8f1a4282f8f2f141e81d827f44bf365d626b\",\n" +
      "  \"ledger\": 915744,\n" +
      "  \"created_at\": \"2015-11-20T17:01:28Z\",\n" +
      "  \"source_account\": \"GCUB7JL4APK7LKJ6MZF7Q2JTLHAGNBIUA7XIXD5SQTG52GQ2DAT6XZMK\",\n" +
      "  \"source_account_sequence\": 2373051035426646,\n" +
      "  \"fee_paid\": 100,\n" +
      "  \"operation_count\": 1,\n" +
      "  \"envelope_xdr\": \"AAAAAKgfpXwD1fWpPmZL+GkzWcBmhRQH7ouPsoTN3RoaGCfrAAAAZAAIbkcAAB9WAAAAAAAAAANRBBZE6D1qyGjISUGLY5Ldvp31PwAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAAAAAAAAADA7RnarSzCwj3OT+M2btCMFpVBdqxJS+Sr00qBjtFv7gAAAABLCs/QAAAAAAAAAAEaGCfrAAAAQG/56Cj2J8W/KCZr+oC4sWND1CTGWfaccHNtuibQH8kZIb+qBSDY94g7hiaAXrlIeg9b7oz/XuP3x9MWYw2jtwM=\",\n" +
      "  \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAA=\",\n" +
      "  \"result_meta_xdr\": \"AAAAAAAAAAEAAAACAAAAAAAN+SAAAAAAAAAAAMDtGdqtLMLCPc5P4zZu0IwWlUF2rElL5KvTSoGO0W/uAAAAAEsKz9AADfkgAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAN+SAAAAAAAAAAAP1qe44j+i4uIT+arbD4QDQBt8ryEeJd7a0jskQ3nwDeAAHp6WMr55YACD1BAAAAHgAAAAoAAAAAAAAAAAAAAAABAAAAAAAACgAAAAARC07BokpLTOF+/vVKBwiAlop7hHGJTNeGGlY4MoPykwAAAAEAAAAAK+Lzfd3yDD+Ov0GbYu1g7SaIBrKZeBUxoCunkLuI7aoAAAABAAAAAERmsKL73CyLV/HvjyQCERDXXpWE70Xhyb6MR5qPO3yQAAAAAQAAAABSORGwAdyuanN3sNOHqNSpACyYdkUM3L8VafUu69EvEgAAAAEAAAAAeCzqJNkMM/jLvyuMIfyFHljBlLCtDyj17RMycPuNtRMAAAABAAAAAIEi4R7juq15ymL00DNlAddunyFT4FyUD4muC4t3bobdAAAAAQAAAACaNpLL5YMfjOTdXVEqrAh99LM12sN6He6pHgCRAa1f1QAAAAEAAAAAqB+lfAPV9ak+Zkv4aTNZwGaFFAfui4+yhM3dGhoYJ+sAAAABAAAAAMNJrEvdMg6M+M+n4BDIdzsVSj/ZI9SvAp7mOOsvAD/WAAAAAQAAAADbHA6xiKB1+G79mVqpsHMOleOqKa5mxDpP5KEp/Xdz9wAAAAEAAAAAAAAAAA==\",\n" +
      "  \"memo_type\": \"none\",\n" +
      "  \"signatures\": [\n" +
      "    \"b/noKPYnxb8oJmv6gLixY0PUJMZZ9pxwc226JtAfyRkhv6oFINj3iDuGJoBeuUh6D1vujP9e4/fH0xZjDaO3Aw==\"\n" +
      "  ]\n" +
      "}";

  TransactionResponse transaction =
      TransactionResponse.fromJson(json.decode(jsonData));
  assert(transaction.memo is MemoNone == true);
}

void testTransactionPageDeserialize() {
  String jsonData = "{\n" +
      "  \"_embedded\": {\n" +
      "    \"records\": [\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/3\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=12884905984\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=12884905984\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889\",\n" +
      "        \"paging_token\": \"12884905984\",\n" +
      "        \"hash\": \"3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889\",\n" +
      "        \"ledger\": 3,\n" +
      "        \"created_at\": \"2015-09-30T17:15:54Z\",\n" +
      "        \"source_account\": \"GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7\",\n" +
      "        \"source_account_sequence\": 1,\n" +
      "        \"fee_paid\": 300,\n" +
      "        \"operation_count\": 3,\n" +
      "        \"envelope_xdr\": \"AAAAAAGUcmKO5465JxTSLQOQljwk2SfqAJmZSG6JH6wtqpwhAAABLAAAAAAAAAABAAAAAAAAAAEAAAALaGVsbG8gd29ybGQAAAAAAwAAAAAAAAAAAAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAAAvrwgAAAAAAAAAAAQAAAAAW8Qst5i4N4Yk6l+FVBBKetKRTqyTcWDNSbcV08F4WNgAAAAAN4Lazj4x61AAAAAAAAAAFAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABLaqcIQAAAEBKwqWy3TaOxoGnfm9eUjfTRBvPf34dvDA0Nf+B8z4zBob90UXtuCqmQqwMCyH+okOI3c05br3khkH0yP4kCwcE\",\n" +
      "        \"result_xdr\": \"AAAAAAAAASwAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAFAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAMAAAACAAAAAAAAAAMAAAAAAAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAAAvrwgAAAAADAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAMAAAAAAAAAAAGUcmKO5465JxTSLQOQljwk2SfqAJmZSG6JH6wtqpwhDeC2s5t4PNQAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAEAAAADAAAAAAAAAAABlHJijueOuScU0i0DkJY8JNkn6gCZmUhuiR+sLaqcIQAAAAAL68IAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAADAAAAAAAAAAAW8Qst5i4N4Yk6l+FVBBKetKRTqyTcWDNSbcV08F4WNg3gtrObeDzUAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAAABAAAAAwAAAAAAAAAAAZRyYo7njrknFNItA5CWPCTZJ+oAmZlIbokfrC2qnCEAAAAAC+vCAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"memo\": \"hello world\",\n" +
      "        \"signatures\": [\n" +
      "          \"SsKlst02jsaBp35vXlI300Qbz39+HbwwNDX/gfM+MwaG/dFF7bgqpkKsDAsh/qJDiN3NOW695IZB9Mj+JAsHBA==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/2db4b22ca018119c5027a80578813ffcf582cda4aa9e31cd92b43cf1bda4fc5a/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/7841\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/2db4b22ca018119c5027a80578813ffcf582cda4aa9e31cd92b43cf1bda4fc5a/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=33676838572032\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/2db4b22ca018119c5027a80578813ffcf582cda4aa9e31cd92b43cf1bda4fc5a\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=33676838572032\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"2db4b22ca018119c5027a80578813ffcf582cda4aa9e31cd92b43cf1bda4fc5a\",\n" +
      "        \"paging_token\": \"33676838572032\",\n" +
      "        \"hash\": \"2db4b22ca018119c5027a80578813ffcf582cda4aa9e31cd92b43cf1bda4fc5a\",\n" +
      "        \"ledger\": 7841,\n" +
      "        \"created_at\": \"2015-10-01T04:15:01Z\",\n" +
      "        \"source_account\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"source_account_sequence\": 12884901890,\n" +
      "        \"fee_paid\": 300,\n" +
      "        \"operation_count\": 3,\n" +
      "        \"envelope_xdr\": \"AAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAABLAAAAAMAAAACAAAAAAAAAAEAAAATdGVzdHBvb2wsZmF1Y2V0LHNkZgAAAAADAAAAAAAAAAAAAAAAH6Ue1GOPj6Hb/ROPyIFCJpQPMujihEIvJSfK0UfMDIgAAAAAC+vCAAAAAAAAAAAAAAAAALMw4P7yJTyqj6ptNh7BPyXEoT+zVwTcU4JVbGyonvgbAAAAAAvrwgAAAAAAAAAAAAAAAABJlwu05Op/5x1uyrweYsyR6pTTos33hRNZe5IF6blnzwAAAAAL68IAAAAAAAAAAAHwXhY2AAAAQDSBB5eNEKkWIoQbZ1YQabJuE5mW/AKhrHTxw9H3m/sai90YcaZlsAe3ueO9jExjSZF289ZcR4vc0wFw1p/WyAc=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAASwAAAAAAAAAAwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAMAAAACAAAAAAAAHqEAAAAAAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAAAAAvrwgAAAB6hAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAAHqEAAAAAAAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2DeC2s4+MeHwAAAADAAAAAgAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAAAAB6hAAAAAAAAAACzMOD+8iU8qo+qbTYewT8lxKE/s1cE3FOCVWxsqJ74GwAAAAAL68IAAAAeoQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAB6hAAAAAAAAAAAW8Qst5i4N4Yk6l+FVBBKetKRTqyTcWDNSbcV08F4WNg3gtrODoLZ8AAAAAwAAAAIAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAIAAAAAAAAeoQAAAAAAAAAASZcLtOTqf+cdbsq8HmLMkeqU06LN94UTWXuSBem5Z88AAAAAC+vCAAAAHqEAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAABAAAeoQAAAAAAAAAAFvELLeYuDeGJOpfhVQQSnrSkU6sk3FgzUm3FdPBeFjYN4Lazd7T0fAAAAAMAAAACAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAA=\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"memo\": \"testpool,faucet,sdf\",\n" +
      "        \"signatures\": [\n" +
      "          \"NIEHl40QqRYihBtnVhBpsm4TmZb8AqGsdPHD0feb+xqL3RhxpmWwB7e5472MTGNJkXbz1lxHi9zTAXDWn9bIBw==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/3ce2aca2fed36da2faea31352c76c5e412348887a4c119b1e90de8d1b937396a/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/7855\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/3ce2aca2fed36da2faea31352c76c5e412348887a4c119b1e90de8d1b937396a/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=33736968114176\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/3ce2aca2fed36da2faea31352c76c5e412348887a4c119b1e90de8d1b937396a\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=33736968114176\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"3ce2aca2fed36da2faea31352c76c5e412348887a4c119b1e90de8d1b937396a\",\n" +
      "        \"paging_token\": \"33736968114176\",\n" +
      "        \"hash\": \"3ce2aca2fed36da2faea31352c76c5e412348887a4c119b1e90de8d1b937396a\",\n" +
      "        \"ledger\": 7855,\n" +
      "        \"created_at\": \"2015-10-01T04:16:11Z\",\n" +
      "        \"source_account\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"source_account_sequence\": 12884901891,\n" +
      "        \"fee_paid\": 100,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAZAAAAAMAAAADAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAFAAAAAQAAAAAfpR7UY4+Podv9E4/IgUImlA8y6OKEQi8lJ8rRR8wMiAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHwXhY2AAAAQNbDcWsR3s3z8Qzqatcdc/k2L4LXWJMA6eXac8dbXkAdc4ppH25isGC5OwvG06Vwvc3Ce3/r2rYcBP3vxhx18A8=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAABAAAAAQAAHq8AAAAAAAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2DeC2s3e09BgAAAADAAAAAwAAAAAAAAABAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"signatures\": [\n" +
      "          \"1sNxaxHezfPxDOpq1x1z+TYvgtdYkwDp5dpzx1teQB1zimkfbmKwYLk7C8bTpXC9zcJ7f+vathwE/e/GHHXwDw==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/e2126485295ecf645cc6615267a83eb4daf8896289caea91038b4c0e6e1471c8/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/7863\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/e2126485295ecf645cc6615267a83eb4daf8896289caea91038b4c0e6e1471c8/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=33771327852544\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/e2126485295ecf645cc6615267a83eb4daf8896289caea91038b4c0e6e1471c8\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=33771327852544\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"e2126485295ecf645cc6615267a83eb4daf8896289caea91038b4c0e6e1471c8\",\n" +
      "        \"paging_token\": \"33771327852544\",\n" +
      "        \"hash\": \"e2126485295ecf645cc6615267a83eb4daf8896289caea91038b4c0e6e1471c8\",\n" +
      "        \"ledger\": 7863,\n" +
      "        \"created_at\": \"2015-10-01T04:16:50Z\",\n" +
      "        \"source_account\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"source_account_sequence\": 12884901892,\n" +
      "        \"fee_paid\": 100,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAZAAAAAMAAAAEAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAJAAAAAAAAAAHwXhY2AAAAQFEHN8h4ZRAOQ21rfMbvEfRKroxx9rkrx3hK2XX1j6mN7qKANKmzwPMlcRcb5yzskPqoWCsuqX/MkUYLfDZe7QY=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAJAAAAAAAAAAEAAAAAH6Ue1GOPj6Hb/ROPyIFCJpQPMujihEIvJSfK0UfMDIgAAK11sXJ6SgAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAABAAAAAQAAHrcAAAAAAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAACtdb1ePEoAAB6hAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"signatures\": [\n" +
      "          \"UQc3yHhlEA5DbWt8xu8R9EqujHH2uSvHeErZdfWPqY3uooA0qbPA8yVxFxvnLOyQ+qhYKy6pf8yRRgt8Nl7tBg==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/1113f23c225495534b2fd589a037798155ea73ee68a418e74364c1a3be4a20d8/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/7871\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/1113f23c225495534b2fd589a037798155ea73ee68a418e74364c1a3be4a20d8/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=33805687590912\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/1113f23c225495534b2fd589a037798155ea73ee68a418e74364c1a3be4a20d8\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=33805687590912\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"1113f23c225495534b2fd589a037798155ea73ee68a418e74364c1a3be4a20d8\",\n" +
      "        \"paging_token\": \"33805687590912\",\n" +
      "        \"hash\": \"1113f23c225495534b2fd589a037798155ea73ee68a418e74364c1a3be4a20d8\",\n" +
      "        \"ledger\": 7871,\n" +
      "        \"created_at\": \"2015-10-01T04:17:31Z\",\n" +
      "        \"source_account\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"source_account_sequence\": 12884901893,\n" +
      "        \"fee_paid\": 100,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAZAAAAAMAAAAFAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAJAAAAAAAAAAHwXhY2AAAAQGCy99saUm6alXIRyp0NNh2OFSCybp1JGPDN2pb/+Fw07/X7y4lPEp/B6WIV130a+2eY+5T3ujbiKa6TIcUaNwQ=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAJAAAAAAAAAAEAAAAAH6Ue1GOPj6Hb/ROPyIFCJpQPMujihEIvJSfK0UfMDIgAAK11sXTKRwAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAABAAAAAQAAHr8AAAAAAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAFa627TBpEAAB6hAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"signatures\": [\n" +
      "          \"YLL32xpSbpqVchHKnQ02HY4VILJunUkY8M3alv/4XDTv9fvLiU8Sn8HpYhXXfRr7Z5j7lPe6NuIprpMhxRo3BA==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/f0222a5421ccfc4e612f11d9ff95755fbb6300df7c61442d990d498a4cd01c92/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/7874\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/f0222a5421ccfc4e612f11d9ff95755fbb6300df7c61442d990d498a4cd01c92/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=33818572492800\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/f0222a5421ccfc4e612f11d9ff95755fbb6300df7c61442d990d498a4cd01c92\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=33818572492800\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"f0222a5421ccfc4e612f11d9ff95755fbb6300df7c61442d990d498a4cd01c92\",\n" +
      "        \"paging_token\": \"33818572492800\",\n" +
      "        \"hash\": \"f0222a5421ccfc4e612f11d9ff95755fbb6300df7c61442d990d498a4cd01c92\",\n" +
      "        \"ledger\": 7874,\n" +
      "        \"created_at\": \"2015-10-01T04:17:46Z\",\n" +
      "        \"source_account\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"source_account_sequence\": 12884901894,\n" +
      "        \"fee_paid\": 100,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAZAAAAAMAAAAGAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAAJAAAAAAAAAAHwXhY2AAAAQCPAo8QwsZe9FA0sz/deMdhlu6/zrk7SgkBG22ApvtpETBhnGkX4trSFDz8sVlKqvweqGUVgvjUyM0AcHxyXZQw=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAAJAAAAAAAAAAEAAAAAH6Ue1GOPj6Hb/ROPyIFCJpQPMujihEIvJSfK0UfMDIgAAK1+KLf6bgAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAABAAAAAQAAHsIAAAAAAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAIIaZeLAP8AAB6hAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"signatures\": [\n" +
      "          \"I8CjxDCxl70UDSzP914x2GW7r/OuTtKCQEbbYCm+2kRMGGcaRfi2tIUPPyxWUqq/B6oZRWC+NTIzQBwfHJdlDA==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/2ead393e776b5a374b478ada47ad7240d004ac1b52468f4ec58aeeb7a9c369e3/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/7990\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/2ead393e776b5a374b478ada47ad7240d004ac1b52468f4ec58aeeb7a9c369e3/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=34316788699136\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/2ead393e776b5a374b478ada47ad7240d004ac1b52468f4ec58aeeb7a9c369e3\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=34316788699136\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"2ead393e776b5a374b478ada47ad7240d004ac1b52468f4ec58aeeb7a9c369e3\",\n" +
      "        \"paging_token\": \"34316788699136\",\n" +
      "        \"hash\": \"2ead393e776b5a374b478ada47ad7240d004ac1b52468f4ec58aeeb7a9c369e3\",\n" +
      "        \"ledger\": 7990,\n" +
      "        \"created_at\": \"2015-10-01T04:27:26Z\",\n" +
      "        \"source_account\": \"GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB\",\n" +
      "        \"source_account_sequence\": 12884901895,\n" +
      "        \"fee_paid\": 100,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAAZAAAAAMAAAAHAAAAAAAAAAEAAAAAAAAAAQAAAAAAAAABAAAAAEmXC7Tk6n/nHW7KvB5izJHqlNOizfeFE1l7kgXpuWfPAAAAAA3gtq7biOyIAAAAAAAAAAHwXhY2AAAAQDZFfOd/26OprF+/0yi9ZtfuHXuL4Tu36eAouGcAS7iHq6l+aMy2z39Ipd/yRAQUHdR7ackuWTB4b26hEEy1xwA=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAACAAAAAQAAHzYAAAAAAAAAABbxCy3mLg3hiTqX4VUEEp60pFOrJNxYM1JtxXTwXhY2AAAABJwsBgAAAAADAAAABwAAAAAAAAABAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAAHzYAAAAAAAAAAEmXC7Tk6n/nHW7KvB5izJHqlNOizfeFE1l7kgXpuWfPDeC2rud0rogAAB6hAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"signatures\": [\n" +
      "          \"NkV853/bo6msX7/TKL1m1+4de4vhO7fp4Ci4ZwBLuIerqX5ozLbPf0il3/JEBBQd1HtpyS5ZMHhvbqEQTLXHAA==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GAP2KHWUMOHY7IO37UJY7SEBIITJIDZS5DRIIQRPEUT4VUKHZQGIRWS4\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/5068a4acda55fddc9db6a5b3113c4520d22a4158978a33ed6399d39f940d5018/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/8682\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/5068a4acda55fddc9db6a5b3113c4520d22a4158978a33ed6399d39f940d5018/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=37288906067968\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/5068a4acda55fddc9db6a5b3113c4520d22a4158978a33ed6399d39f940d5018\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=37288906067968\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"5068a4acda55fddc9db6a5b3113c4520d22a4158978a33ed6399d39f940d5018\",\n" +
      "        \"paging_token\": \"37288906067968\",\n" +
      "        \"hash\": \"5068a4acda55fddc9db6a5b3113c4520d22a4158978a33ed6399d39f940d5018\",\n" +
      "        \"ledger\": 8682,\n" +
      "        \"created_at\": \"2015-10-01T05:25:06Z\",\n" +
      "        \"source_account\": \"GAP2KHWUMOHY7IO37UJY7SEBIITJIDZS5DRIIQRPEUT4VUKHZQGIRWS4\",\n" +
      "        \"source_account_sequence\": 33676838567937,\n" +
      "        \"fee_paid\": 200,\n" +
      "        \"operation_count\": 2,\n" +
      "        \"envelope_xdr\": \"AAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAAAyAAAHqEAAAABAAAAAAAAAAEAAAAHaGVscHNkZgAAAAACAAAAAAAAAAAAAAAACNQTqwpRdbEoAn+tdRR4PCv8hj0vG/SrFkpQQkbWaYkAAAAAC+vCAAAAAAAAAAABAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAAAAACCGTvczj/AAAAAAAAAAFHzAyIAAAAQM5E3lSZ8mBzppHShs5Vy5B+MsUVCXNg5qaVMC7GyVTJOYBhcAyNlF4X03rnGZddR3i6fUfFLym77Lryh41pAQg=\",\n" +
      "        \"result_xdr\": \"AAAAAAAAAMgAAAAAAAAAAgAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAIAAAACAAAAAAAAIeoAAAAAAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAAAAvrwgAAACHqAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQAAIeoAAAAAAAAAAB+lHtRjj4+h2/0Tj8iBQiaUDzLo4oRCLyUnytFHzAyIAAIIaYufPjcAAB6hAAAAAQAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAEAACHqAAAAAAAAAAAI1BOrClF1sSgCf611FHg8K/yGPS8b9KsWSlBCRtZpiQACCGT7Xvr/AAAh6gAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAACHqAAAAAAAAAAAfpR7UY4+Podv9E4/IgUImlA8y6OKEQi8lJ8rRR8wMiAAAAAScLAU4AAAeoQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==\",\n" +
      "        \"memo_type\": \"text\",\n" +
      "        \"memo\": \"helpsdf\",\n" +
      "        \"signatures\": [\n" +
      "          \"zkTeVJnyYHOmkdKGzlXLkH4yxRUJc2DmppUwLsbJVMk5gGFwDI2UXhfTeucZl11HeLp9R8UvKbvsuvKHjWkBCA==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GBEZOC5U4TVH7ZY5N3FLYHTCZSI6VFGTULG7PBITLF5ZEBPJXFT46YZM\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/388561da0b439741fd27177b924dc4f6a0705bdfd8126a83432be642b2889415/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/18768\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/388561da0b439741fd27177b924dc4f6a0705bdfd8126a83432be642b2889415/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=80607946215424\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/388561da0b439741fd27177b924dc4f6a0705bdfd8126a83432be642b2889415\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=80607946215424\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"388561da0b439741fd27177b924dc4f6a0705bdfd8126a83432be642b2889415\",\n" +
      "        \"paging_token\": \"80607946215424\",\n" +
      "        \"hash\": \"388561da0b439741fd27177b924dc4f6a0705bdfd8126a83432be642b2889415\",\n" +
      "        \"ledger\": 18768,\n" +
      "        \"created_at\": \"2015-10-01T23:07:25Z\",\n" +
      "        \"source_account\": \"GBEZOC5U4TVH7ZY5N3FLYHTCZSI6VFGTULG7PBITLF5ZEBPJXFT46YZM\",\n" +
      "        \"source_account_sequence\": 33676838567937,\n" +
      "        \"fee_paid\": 1000,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAAEmXC7Tk6n/nHW7KvB5izJHqlNOizfeFE1l7kgXpuWfPAAAD6AAAHqEAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAABAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAem5Z88AAABAo/o2gLEdY1kkfAYTOjBsTa24WYtWkv0wCyngS6xQU86fgIwD1zF+SP2Joz9x2njQj9B4yzLzJ5jU82X59w6eBg==\",\n" +
      "        \"result_xdr\": \"AAAAAAAAA+gAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAABAAAAAQAASVAAAAAAAAAAAEmXC7Tk6n/nHW7KvB5izJHqlNOizfeFE1l7kgXpuWfPDeC2rud0qqAAAB6hAAAAAQAAAAAAAAABAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"none\",\n" +
      "        \"signatures\": [\n" +
      "          \"o/o2gLEdY1kkfAYTOjBsTa24WYtWkv0wCyngS6xQU86fgIwD1zF+SP2Joz9x2njQj9B4yzLzJ5jU82X59w6eBg==\"\n" +
      "        ]\n" +
      "      },\n" +
      "      {\n" +
      "        \"_links\": {\n" +
      "          \"account\": {\n" +
      "            \"href\": \"/accounts/GAENIE5LBJIXLMJIAJ7225IUPA6CX7EGHUXRX5FLCZFFAQSG2ZUYSWFK\"\n" +
      "          },\n" +
      "          \"effects\": {\n" +
      "            \"href\": \"/transactions/eff9b8993a0cb705b18aa19af228672e026da65c4063bfd2318640c67302831f/effects{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"ledger\": {\n" +
      "            \"href\": \"/ledgers/18873\"\n" +
      "          },\n" +
      "          \"operations\": {\n" +
      "            \"href\": \"/transactions/eff9b8993a0cb705b18aa19af228672e026da65c4063bfd2318640c67302831f/operations{?cursor,limit,order}\",\n" +
      "            \"templated\": true\n" +
      "          },\n" +
      "          \"precedes\": {\n" +
      "            \"href\": \"/transactions?cursor=81058917781504\\u0026order=asc\"\n" +
      "          },\n" +
      "          \"self\": {\n" +
      "            \"href\": \"/transactions/eff9b8993a0cb705b18aa19af228672e026da65c4063bfd2318640c67302831f\"\n" +
      "          },\n" +
      "          \"succeeds\": {\n" +
      "            \"href\": \"/transactions?cursor=81058917781504\\u0026order=desc\"\n" +
      "          }\n" +
      "        },\n" +
      "        \"id\": \"eff9b8993a0cb705b18aa19af228672e026da65c4063bfd2318640c67302831f\",\n" +
      "        \"paging_token\": \"81058917781504\",\n" +
      "        \"hash\": \"eff9b8993a0cb705b18aa19af228672e026da65c4063bfd2318640c67302831f\",\n" +
      "        \"ledger\": 18873,\n" +
      "        \"created_at\": \"2015-10-01T23:17:09Z\",\n" +
      "        \"source_account\": \"GAENIE5LBJIXLMJIAJ7225IUPA6CX7EGHUXRX5FLCZFFAQSG2ZUYSWFK\",\n" +
      "        \"source_account_sequence\": 37288906063873,\n" +
      "        \"fee_paid\": 1000,\n" +
      "        \"operation_count\": 1,\n" +
      "        \"envelope_xdr\": \"AAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAD6AAAIeoAAAABAAAAAAAAAAAAAAABAAAAAAAAAAUAAAABAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAUbWaYkAAABA5Xa8K46SvYshVBom+lxHh4BdK22z7mce1GViab6ikceRxmKM/2+YHaDLoZ6TxKcnl1+/0hSPFTsR7uUGf12UAw==\",\n" +
      "        \"result_xdr\": \"AAAAAAAAA+gAAAAAAAAAAQAAAAAAAAAFAAAAAAAAAAA=\",\n" +
      "        \"result_meta_xdr\": \"AAAAAAAAAAEAAAABAAAAAQAASbkAAAAAAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAIIZPte9xcAACHqAAAAAQAAAAAAAAABAAAAAAjUE6sKUXWxKAJ/rXUUeDwr/IY9Lxv0qxZKUEJG1mmJAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA\",\n" +
      "        \"memo_type\": \"none\",\n" +
      "        \"signatures\": [\n" +
      "          \"5Xa8K46SvYshVBom+lxHh4BdK22z7mce1GViab6ikceRxmKM/2+YHaDLoZ6TxKcnl1+/0hSPFTsR7uUGf12UAw==\"\n" +
      "        ]\n" +
      "      }\n" +
      "    ]\n" +
      "  },\n" +
      "  \"_links\": {\n" +
      "    \"next\": {\n" +
      "      \"href\": \"/transactions?order=asc\\u0026limit=10\\u0026cursor=81058917781504\"\n" +
      "    },\n" +
      "    \"prev\": {\n" +
      "      \"href\": \"/transactions?order=desc\\u0026limit=10\\u0026cursor=12884905984\"\n" +
      "    },\n" +
      "    \"self\": {\n" +
      "      \"href\": \"/transactions?order=asc\\u0026limit=10\\u0026cursor=\"\n" +
      "    }\n" +
      "  }\n" +
      "}";

  Page<TransactionResponse> transactionsPage =
      Page<TransactionResponse>.fromJson(json.decode(jsonData));

  assert(transactionsPage.records[0].sourceAccount.accountId ==
      "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7");
  assert(transactionsPage.records[0].pagingToken == "12884905984");
  assert(transactionsPage.records[0].memo is MemoText);
  MemoText memoText = transactionsPage.records[0].memo as MemoText;
  assert(memoText.text == "hello world");
  assert(transactionsPage.records[0].links.account.href ==
      "/accounts/GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7");
  assert(transactionsPage.records[9].sourceAccount.accountId ==
      "GAENIE5LBJIXLMJIAJ7225IUPA6CX7EGHUXRX5FLCZFFAQSG2ZUYSWFK");

  // Empty memo_text
  assert(transactionsPage.records[2].memo is MemoText);
  memoText = transactionsPage.records[2].memo as MemoText;
  assert(memoText.text == "");

  assert(transactionsPage.links.next.href ==
      "/transactions?order=asc&limit=10&cursor=81058917781504");
  assert(transactionsPage.links.prev.href ==
      "/transactions?order=desc&limit=10&cursor=12884905984");
  assert(transactionsPage.links.self.href ==
      "/transactions?order=asc&limit=10&cursor=");
}

void main() {
  testAccountDeserialize();
  testAccountDeserializeV9();
  testAccountsPageDeserialize();
  testAssetDeserializeNative();
  testAssetDeserializeCredit();
  testAssetsPageDeserialize();
  testEffectsPageDeserialize();
  testLedgerDeserialize();
  testLedgerPageDeserialize();
  testOfferPageDeserialize();
  testOperationsPageDeserialize();
  testOrderBookDeserialize();
  testPathsPageDeserialize();
  testRootDeserialize();
  testSubmitTransactionResponseDeserializeTransactionFailureResponse();
  testSubmitTransactionResponseDeserializeOperationFailureResponse();
  testSubmitTransactionResponseDeserializeSuccessResponse();
  testSubmitTransactionResponseDeserializeNoOfferID();
  testTradeAggregationsPageDeserialize();
  testTradesPageDeserialize();
  testTransactionDeserialize();
  testTransactionDeserializeWithoutMemo();
  testTransactionPageDeserialize();
}
