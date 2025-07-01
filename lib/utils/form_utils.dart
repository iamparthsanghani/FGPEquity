import 'package:flutter/material.dart';

class FormUtils {
  /// Safely clears form fields by unfocusing first and then clearing after a delay
  static void safeClearFormFields(
      List<TextEditingController> controllers, List<FocusNode> focusNodes) {
    // Unfocus all fields first
    for (final focusNode in focusNodes) {
      focusNode.unfocus();
    }

    // Clear controllers after a short delay to avoid focus issues
    Future.delayed(const Duration(milliseconds: 100), () {
      for (final controller in controllers) {
        controller.clear();
      }
    });
  }

  /// Safely clears a single form field
  static void safeClearField(
      TextEditingController controller, FocusNode focusNode) {
    focusNode.unfocus();
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.clear();
    });
  }

  /// Validates if the form is mounted before performing operations
  static bool isFormMounted(BuildContext context) {
    return context.mounted;
  }
}
