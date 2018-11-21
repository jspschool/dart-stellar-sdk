import 'account_test.dart' as account_test;
import 'assets_test.dart' as assets_test;
import 'key_pair_test.dart' as key_pair_test;
import 'memo_test.dart' as memo_test;
import 'network_test.dart' as network_test;
import 'operation_test.dart' as operation_test;
import 'price_test.dart' as price_test;
import 'request_test.dart' as request_test;
import 'response_effects_test.dart' as response_effects_test;
import 'response_operations_test.dart' as response_operations_test;
import 'response_test.dart' as response_test;
import 'str_key_test.dart' as str_key_test;
import 'transaction_test.dart' as transaction_test;
import 'xdr_test.dart' as xdr_test;

void main() {
  account_test.main();
  assets_test.main();
  key_pair_test.main();
  memo_test.main();
  network_test.main();
  operation_test.main();
  price_test.main();
  request_test.main();
  response_effects_test.main();
  response_operations_test.main();
  response_test.main();
  str_key_test.main();
  transaction_test.main();
  xdr_test.main();
}