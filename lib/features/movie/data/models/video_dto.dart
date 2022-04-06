import 'package:freezed_annotation/freezed_annotation.dart';
part 'video_dto.freezed.dart';
part 'video_dto.g.dart';

@freezed
class VideoDto with _$VideoDto {
  const factory VideoDto({
    required List<VideoResultDto>? results,
  }) = _VideoDto;

  factory VideoDto.fromJson(Map<String, dynamic> json) =>
      _$VideoDtoFromJson(json);
}

@freezed
class VideoResultDto with _$VideoResultDto {
  const factory VideoResultDto({
    required String? name,
    required String? key,
    required String? site,
    required String? type,
    @JsonKey(name: 'official') required bool? isOfficial,
  }) = _VideoResultDto;

  factory VideoResultDto.fromJson(Map<String, dynamic> json) =>
      _$VideoResultDtoFromJson(json);
}
