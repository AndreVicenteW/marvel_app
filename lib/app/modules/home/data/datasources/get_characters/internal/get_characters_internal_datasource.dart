import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_characters/get_characters_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/character_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/character_entity.dart';

class GetCharactersInternalDataSourceImp extends GetCharactersDataSource {
  final AssetBundle rootBundle;

  GetCharactersInternalDataSourceImp(this.rootBundle);

  @override
  Future<DataResult<List<CharacterEntity>>> call(String search,
      {bool pagination = false}) async {

    try {
      final response = await rootBundle.loadString('assets/json/heroes.json');
      final result = jsonDecode(response);

      var _list = (result['data']['results'] as List).map((obj) {
        return CharacterDto.fromJson(obj);
      }).toList();

      return DataResult.success(_list);
    } catch (error) {
      return DataResult.failure(
          APIFailure('GetCharactersDataSourceImp Error: $error'));
    }
  }
}
