
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamRepositoryProvider = Provider<StreamRepository>((ref) => StreamRepository());

class StreamRepository {
  Stream<int> getStream() {
    return Stream.periodic(const Duration(seconds: 1), (i) => i).take(30);
  }
}