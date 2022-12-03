import 'package:esomap_mobile/api/summaries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () async {
    var result = await getSummaries();

    assert(result.data.isNotEmpty);
  });
}
