import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

class CommonSnackBar {
  static getSuccessSnackBar({BuildContext? context, String title = ''}) {
    AnimatedSnackBar.rectangle(
      'Successfully',
      '$title',
      duration: Duration(seconds: 2),
      type: AnimatedSnackBarType.success,
      brightness: Brightness.dark,
    ).show(
      context!,
    );
  }

  static getFailedSnackBar({BuildContext? context, String title = ''}) {
    AnimatedSnackBar.rectangle(
      'Failed',
      '$title',
      duration: Duration(seconds: 2),
      type: AnimatedSnackBarType.error,
      brightness: Brightness.dark,
    ).show(
      context!,
    );
  }

  static getWarningSnackBar({BuildContext? context, String title = ''}) {
    AnimatedSnackBar.rectangle(
      'warning',
      '$title',
      duration: Duration(seconds: 2),
      type: AnimatedSnackBarType.warning,
      brightness: Brightness.dark,
    ).show(
      context!,
    );
  }
}
