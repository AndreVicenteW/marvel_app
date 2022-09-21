import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/presenter/components/comic_list_tile.dart';

import '../../../tester_helper.dart';

void main() {
  final _comic = ComicEntity(
    1,
    'title',
    'description',
    ThumbnailEntity('', ''),
    true,
  );

  group('[Comic List Tile Test]', () {
    testWidgets('Should see all widgets', (WidgetTester tester) async {
      await tester.pumpWidget(TesterHelper.buildTestableWidget(
          ComicListTile(comic: _comic, origin: 'test')));

      expect(find.byType(ComicListTile), findsOneWidget);
      expect(find.byType(FadeInImage), findsOneWidget);
      expect(find.byType(ThemeText), findsOneWidget);
      expect(find.text(_comic.title), findsOneWidget);
    });
  });
}
