import 'dart:math';

String randomString([int length = 8, String letters]) {
  if (letters == null) {
    letters = String.fromCharCodes(
        List.generate(10, (i) => '0'.codeUnitAt(0) + i) +
            List.generate(26, (i) => 'A'.codeUnitAt(0) + i) +
            List.generate(26, (i) => 'a'.codeUnitAt(0) + i));
  }

  final random = Random();
  return List.generate(length, (i) => letters[random.nextInt(letters.length)])
      .join();
}

int compareVersion(String version1, String version2, [int length = 3]) {
  final v1 = version1.split('.')
    ..remove('')
    ..addAll(List.filled(length, '0'))
    ..sublist(0, length);
  final v2 = version2.split('.')
    ..remove('')
    ..addAll(List.filled(length, '0'))
    ..sublist(0, length);

  for (final i in List.generate(length, (i) => i)) {
    final v11 = int.parse(v1[i]);
    final v22 = int.parse(v2[i]);
    if (v11 > v22) {
      return 1;
    } else if (v11 < v22) {
      return -1;
    }
  }
  return 0;
}
