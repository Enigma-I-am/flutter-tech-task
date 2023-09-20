

import 'package:tech_task/core/viewmodels/viewmodels.dart';

class LoaderVM extends DisposableChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;

    if (mounted == false) {
      return;
    }
    notifyListeners();
  }

  double? _loadingPercentage;
  double? get loadingPercentage => _loadingPercentage;
  set loadingPercentage(double? val) {
    _loadingPercentage = val;
    notifyListeners();
  }

  /// Run Task and show loading
  void simulate(
    Function() callback, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    /// Start Loading
    isLoading = true;

    /// Run delayed Task
    await Future.delayed(duration);

    /// End Loading
    isLoading = false;

    callback.call();
  }

  /// Run Task and show loading
  Future<void> runTask(Future Function()? task) async {
    if (mounted == false) {
      return;
    }

    /// Load
    isLoading = true;

    /// Run async Task
    if (task != null) await task.call();

    /// Stop Loading
    isLoading = false;
  }

  /// Run Task and show loading
  Future<void> runTaskWithLoader(
    Future Function()? task, {
    bool shouldStartLoadingIf = false,
    bool shouldStopLoadingIf = true,
  }) async {
    if (mounted == false) {
      return;
    }

    /// Load
    if (shouldStartLoadingIf) {
      isLoading = true;
    }

    /// Run async Task
    if (task != null) await task.call();

    /// Stop Loading
    if (shouldStopLoadingIf) {
      isLoading = false;
    }
  }
}
