import 'package:json_annotation/json_annotation.dart';

part 'pagination_dto.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationDto<T> {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<T> results;

  PaginationDto(
    this.offset,
    this.limit,
    this.total,
    this.count,
    this.results,
  );

  int getNextOffset() {
    return offset + count;
  }

  factory PaginationDto.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PaginationDtoFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginationDtoToJson(this, toJsonT);
}
