

/// Base application exception
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  AppException(
    this.message, {
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message';
}

/// Authentication specific exceptions
class AuthException extends AppException {
  AuthException(String message, {String? code, dynamic originalError})
      : super(message, code: code ?? 'AUTH_ERROR', originalError: originalError);
}

/// Database specific exceptions
class DatabaseException extends AppException {
  DatabaseException(String message, {String? code, dynamic originalError})
      : super(message, code: code ?? 'DATABASE_ERROR', originalError: originalError);
}

/// Network specific exceptions
class NetworkException extends AppException {
  NetworkException(String message, {String? code, dynamic originalError})
      : super(message, code: code ?? 'NETWORK_ERROR', originalError: originalError);
}

/// Error handler utility class
class ErrorHandler {
  
  
  /// Handle network errors
  static AppException handleNetworkError(dynamic error) {
    final message = error.toString().toLowerCase();
    
    if (message.contains('timeout')) {
      return NetworkException('Bağlantı zaman aşımına uğradı');
    }
    
    if (message.contains('no internet') || message.contains('network')) {
      return NetworkException('İnternet bağlantısı yok');
    }
    
    return NetworkException('Ağ hatası: ${error.toString()}');
  }
  
  /// Generic error handler - returns string message
  static String handleError(dynamic error) {
    if (error is AppException) {
      return error.message;
    }
    
    if (error is AuthException) {
      return error.message;
    }
    
    if (error is DatabaseException) {
      return error.message;
    }
    
    // Check for network-related errors
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('timeout') || 
        errorString.contains('network') || 
        errorString.contains('connection')) {
      return NetworkException('Ağ hatası: ${error.toString()}').message;
    }
    
    return 'Bilinmeyen hata: ${error.toString()}';
  }
  
  /// Generic error handler - returns AppException
  static AppException handleErrorException(dynamic error) {
    if (error is AppException) {
      return error;
    }
    
    if (error is AuthException) {
      return error;
    }
    
    if (error is DatabaseException) {
      return error;
    }
    
    // Check for network-related errors
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('timeout') || 
        errorString.contains('network') || 
        errorString.contains('connection')) {
      return NetworkException('Ağ hatası: ${error.toString()}');
    }
    
    return AppException('Bilinmeyen hata: ${error.toString()}');
  }
  
  /// Log error for debugging
  static void logError(dynamic error, [StackTrace? stackTrace]) {
    print('🔥 Error: $error');
    if (stackTrace != null) {
      print('Stack trace: $stackTrace');
    }
  }
} 