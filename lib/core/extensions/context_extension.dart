import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension ContextExtension<T> on BuildContext {
  void go(
    String route, {
    Object? extra,
  }) {
    return GoRouter.of(this).go(route, extra: extra);
  }

  Future<T?> push(
    String route, {
    Object? extra,
  }) {
    return GoRouter.of(this).push(route, extra: extra);
  }

  Future<Object?> replace(
    String route, {
    Object? extra,
  }) {
    return GoRouter.of(this).replace(route, extra: extra);
  }

  void pop([Object? result]) {
    return GoRouter.of(this).pop(result);
  }

  Future<Object?> pushReplacement(
    String location, {
    Object? extra,
  }) {
    return GoRouter.of(this).pushReplacement(location, extra: extra);
  }
}
