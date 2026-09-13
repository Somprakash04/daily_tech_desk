import 'package:flutter_bloc/flutter_bloc.dart';

/// `null` represents the All feed. Filtering stays entirely local in Phase 1.
class FeedFilterCubit extends Cubit<String?> {
  FeedFilterCubit() : super(null);

  void select(String? category) => emit(category);
}
