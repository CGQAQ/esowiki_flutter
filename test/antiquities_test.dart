import 'package:esomap_mobile/api/antiquity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Get anitiquities should not be empty', () async {
    var result = await getAntiquities();

    assert(result.data.isNotEmpty);
  });
}
