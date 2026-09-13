import 'package:equatable/equatable.dart';

class InterestSelectionState extends Equatable {
  const InterestSelectionState({this.selectedIds = const <String>[]});

  final List<String> selectedIds;

  bool contains(String topicId) => selectedIds.contains(topicId);
  bool get hasSelection => selectedIds.isNotEmpty;

  @override
  List<Object> get props => <Object>[selectedIds];
}
