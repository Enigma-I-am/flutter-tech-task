
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tech_task/core/core.dart';
import 'package:tech_task/core/service/navigation_service.dart';

typedef Reader<T> = T Function(ProviderListenable<T> provider);

abstract class DisposableViewModel extends DisposableChangeNotifier {
  ChangeNotifierProviderRef ref;

  LoaderVM get loader => ref.refresh(loaderVmProvider);

  DisposableViewModel(this.ref) {
    if (_mounted == false) {
      log('$this is not mounted');
    }
  }
}

abstract class DisposableChangeNotifier extends ChangeNotifier {
  bool _mounted = true;
  bool get mounted => _mounted && navigator.state?.mounted == true;

  @override
  void notifyListeners() {
    if (mounted) super.notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
