import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/presenter/components/comic_list_tile.dart';
import 'package:marvel_app/app/modules/home/presenter/components/list_comics_component.dart';

import '../../../tester_helper.dart';

void main() {
  final _comics = [
    ComicEntity(
      1,
      'title',
      'description',
      ThumbnailEntity('', ''),
      true,
    )
  ];

  group('[List Comics Component Test]', () {
    testWidgets('Should see all widgets with a comic list', (WidgetTester tester) async {
      await tester.pumpWidget(TesterHelper.buildTestableWidget(
          ListComicsComponent(comics: _comics)));

      expect(find.byType(ListComicsComponent), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ComicListTile), findsNWidgets(_comics.length));
    });

    testWidgets('Should see all widgets with a empty list', (WidgetTester tester) async {
      await tester.pumpWidget(TesterHelper.buildTestableWidget(
          ListComicsComponent(comics: const [])));

      expect(find.byType(ListComicsComponent), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ComicListTile), findsNothing);
    });
  });
}
