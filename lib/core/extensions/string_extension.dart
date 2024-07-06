
extension StringExtension on String {
  String get onlyNumbers => replaceAll(RegExp('[^0-9]'), '');
}
