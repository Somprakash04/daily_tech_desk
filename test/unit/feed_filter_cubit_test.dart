import 'package:bloc_test/bloc_test.dart';
import 'package:daily_tech_desk/features/home/presentation/cubit/feed_filter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeedFilterCubit (Category Filtering Tests)', () {
    test('initial state is null (representing "All" articles)', () {
      final cubit = FeedFilterCubit();
      expect(cubit.state, isNull);
      cubit.close();
    });

    blocTest<FeedFilterCubit, String?>(
      'emits selected category when select(category) is called',
      build: () => FeedFilterCubit(),
      act: (cubit) => cubit.select('ai-ml'),
      expect: () => ['ai-ml'],
    );

    blocTest<FeedFilterCubit, String?>(
      'emits null when selecting All filter (null)',
      build: () => FeedFilterCubit(),
      seed: () => 'ai-ml',
      act: (cubit) => cubit.select(null),
      expect: () => [null],
    );
  });
}
