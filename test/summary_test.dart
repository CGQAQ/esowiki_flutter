import 'package:esomap_mobile/api/summaries.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get summaries should not be empty', () async {
    var result = await getSummaries();

    assert(result.data.isNotEmpty);
  });
}
