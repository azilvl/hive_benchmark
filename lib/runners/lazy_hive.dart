import 'package:hive/hive.dart';

import 'hive.dart';
import 'runner.dart';

class LazyHiveRunner extends HiveRunner implements BenchmarkRunner {
  @override
  String get name => 'Hive (lazy)';

  @override
  Future<void> setUp() async {
    return;
  }

  @override
  Future<void> tearDown() async {
    return;
  }

  @override
  Future<int> batchReadInt(List<String> keys) async {
    final box = await Hive.openLazyBox('box');
    final s = Stopwatch()..start();
    for (var key in keys) {
      box.get(key);
    }
    s.stop();
    await box.close();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchWriteString(Map<String, dynamic> entries) async {
    final box = await Hive.openLazyBox('box');
    var s = Stopwatch()..start();
    for (var key in entries.keys) {
      await box.put(key, entries[key]);
    }
    s.stop();
    await box.close();
    return s.elapsedMilliseconds;
  }

  @override
  Future<int> batchDeleteInt(List<String> keys) async {
    final box = await Hive.openLazyBox('box');
    var s = Stopwatch()..start();
    for (var key in keys) {
      await box.delete(key);
    }
    s.stop();
    await box.close();
    return s.elapsedMilliseconds;
  }
}
