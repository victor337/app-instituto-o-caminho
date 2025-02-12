import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

abstract class LoggerRepository {
  Future<void> logInfo(Object e, StackTrace s, String reason);
}

class LoggerRepositoryImpl implements LoggerRepository {
  @override
  Future<void> logInfo(Object e, StackTrace s, String reason) async {
    log('$reason: $e', stackTrace: s);
    await FirebaseCrashlytics.instance.recordFlutterFatalError(
      FlutterErrorDetails(
        exception: e,
        stack: s,
        library: reason,
      ),
    );
  }
}
