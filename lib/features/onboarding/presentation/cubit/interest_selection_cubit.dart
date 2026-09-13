import 'package:daily_tech_desk/core/dummy_data/dummy_categories.dart';
import 'package:daily_tech_desk/features/onboarding/presentation/cubit/interest_selection_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Holds selection only for this running session. Persistence is intentionally
/// deferred until the profile backend is introduced.
class InterestSelectionCubit extends Cubit<InterestSelectionState> {
  InterestSelectionCubit() : super(const InterestSelectionState());

  void toggle(String topicId) {
    final List<String> selected = List<String>.of(state.selectedIds);

    if (topicId == DummyCategories.allTechnologyId) {
      emit(
        InterestSelectionState(
          selectedIds: state.contains(topicId)
              ? const <String>[]
              : <String>[topicId],
        ),
      );
      return;
    }

    selected.remove(DummyCategories.allTechnologyId);
    if (selected.contains(topicId)) {
      selected.remove(topicId);
    } else {
      selected.add(topicId);
    }
    emit(
      InterestSelectionState(selectedIds: List<String>.unmodifiable(selected)),
    );
  }
}
