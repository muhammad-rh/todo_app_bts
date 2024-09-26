import 'dart:async';

Timer? _debounce;

class Debounce {
  run({required Function() onRun}) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), onRun);
  }
}
