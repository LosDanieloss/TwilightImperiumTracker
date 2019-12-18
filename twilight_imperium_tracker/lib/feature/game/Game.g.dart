// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) {
  return Game(
      raceUsed: _$enumDecodeNullable(_$RaceEnumMap, json['raceUsed']),
      points: json['points'] as int,
      goal: json['goal'] as int,
      result: _$enumDecodeNullable(_$GameResultEnumMap, json['result']),
      opponents: (json['opponents'] as List)
          ?.map((e) => _$enumDecodeNullable(_$RaceEnumMap, e))
          ?.toList())
    ..key = json['key'] as String;
}

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'key': instance.key,
      'raceUsed': _$RaceEnumMap[instance.raceUsed],
      'points': instance.points,
      'goal': instance.goal,
      'result': _$GameResultEnumMap[instance.result],
      'opponents': instance.opponents?.map((e) => _$RaceEnumMap[e])?.toList()
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$RaceEnumMap = <Race, dynamic>{
  Race.ARBOREC: 'ARBOREC',
  Race.EMBERS_OF_MUAAT: 'EMBERS_OF_MUAAT',
  Race.GHOSTS_OF_CREUSS: 'GHOSTS_OF_CREUSS',
  Race.NAALU_COLLECTIVE: 'NAALU_COLLECTIVE',
  Race.UNIVERSITIES_OF_JOL_NAR: 'UNIVERSITIES_OF_JOL_NAR',
  Race.YIN_BROTHERHOOD: 'YIN_BROTHERHOOD',
  Race.BARONY_OF_LETNEV: 'BARONY_OF_LETNEV',
  Race.EMIRATES_OF_HACAN: 'EMIRATES_OF_HACAN',
  Race.L1Z1X_MINDNET: 'L1Z1X_MINDNET',
  Race.NEKRO_VIRUS: 'NEKRO_VIRUS',
  Race.WINNU: 'WINNU',
  Race.YSSARIL_TRIBES: 'YSSARIL_TRIBES',
  Race.CLAN_OF_SAAR: 'CLAN_OF_SAAR',
  Race.FEDERATION_OF_SOL: 'FEDERATION_OF_SOL',
  Race.Mentak_Coalition: 'Mentak_Coalition',
  Race.SARDAKK_N_ORR: 'SARDAKK_N_ORR',
  Race.XXCHA_KINGDOM: 'XXCHA_KINGDOM'
};

const _$GameResultEnumMap = <GameResult, dynamic>{
  GameResult.WIN: 'WIN',
  GameResult.LOSE: 'LOSE',
  GameResult.DRAW: 'DRAW'
};
