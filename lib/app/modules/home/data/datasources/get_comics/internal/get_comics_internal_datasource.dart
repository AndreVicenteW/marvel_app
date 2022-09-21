import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marvel_app/app/core/data_result/data_result.dart';
import 'package:marvel_app/app/modules/home/data/datasources/get_comics/get_comics_datasource.dart';
import 'package:marvel_app/app/modules/home/data/dto/comic_dto.dart';
import 'package:marvel_app/app/modules/home/domain/entities/comic_entity.dart';

class GetComicsInternalDataSourceImp extends GetComicsDataSource {
  final AssetBundle rootBundle;

  GetComicsInternalDataSourceImp(this.rootBundle);

  @override
  Future<DataResult<List<ComicEntity>>> call(
    String search, {
    int? characterId,
    bool pagination = false
  }) async {
    try {
      final response = await rootBundle.loadString('assets/json/comics.json');
      final result = jsonDecode(response);

      var _list = (result['data']['results'] as List).map((obj) {
        return ComicDto.fromJson(obj);
      }).toList();

      return DataResult.success(_list);
    } catch (error) {
      return DataResult.failure(
          APIFailure('GetComicsInternalDataSourceImp Error: $error'));
    }
  }
}
