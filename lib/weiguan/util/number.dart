import 'dart:math';

String formatNumber(num n) {
  if (n >= pow(10, 6)) {
    return '${(n / pow(10, 6)).round().toString()}百万';
  } else if (n >= pow(10, 4)) {
    return '${(n / pow(10, 4)).round().toString()}万';
  } else {
    return n.round().toString();
  }
}
