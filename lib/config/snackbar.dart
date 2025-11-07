import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'snackbar.g.dart';

/// SnackBar type enum
enum SnackBarType {
  info,
  success,
  warning,
  error,
}

/// SnackBar service class
class SnackBarService {
  /// Show a SnackBar with customizable type, duration and action
  void show(
    BuildContext context, {
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final color = _getColorForType(type);
    final icon = _getIconForType(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: color,
        duration: duration,
        action: action,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Show info message
  void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      duration: duration,
    );
  }

  /// Show success message
  void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
    );
  }

  /// Show warning message
  void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
    );
  }

  /// Show error message
  void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
    );
  }

  Color _getColorForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return Colors.blue;
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.warning:
        return Colors.orange;
      case SnackBarType.error:
        return Colors.red;
    }
  }

  IconData _getIconForType(SnackBarType type) {
    switch (type) {
      case SnackBarType.info:
        return Icons.info_outline;
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      case SnackBarType.error:
        return Icons.error_outline;
    }
  }
}

/// SnackBarService provider
@riverpod
SnackBarService snackBarService(Ref ref) {
  return SnackBarService();
}
