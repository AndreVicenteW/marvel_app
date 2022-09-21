import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marvel_app/app/core/presenter/theme/theme.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';
import 'package:marvel_app/app/modules/home/domain/entities/thumbnail_entity.dart';
import 'package:marvel_app/app/modules/home/presenter/components/character_list_tile.dart';

import '../../../tester_helper.dart';

void main() {
  final _character = CharacterEntity(
    123,
    'test name',
    'test description',
    ThumbnailEntity(
      'test',
      'png',
    ),
    2,
  );

  group('[Character List Tile test]', () {
    testWidgets('Should see all widgets', (WidgetTester tester) async {

      await tester.pumpWidget(
        TesterHelper.buildTestableWidget(
            CharacterListTile(character: _character)),
      );

      expect(find.byType(CharacterListTile), findsOneWidget);
      expect(find.byType(FadeInImage), findsOneWidget);
      expect(find.byType(ThemeText), findsNWidgets(2));
      expect(find.text(_character.name), findsOneWidget);
      expect(find.text(_character.getDescription()), findsOneWidget);
    });
  });
}
