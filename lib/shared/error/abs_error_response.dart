enum ErrorType { supabase, validation, network, unexpected }

abstract class AbsError {
  final String message;
  final ErrorType type;

  AbsError({required this.type, required this.message});

  @override
  String toString() {
    return '[$type error]$message';
  }
}
