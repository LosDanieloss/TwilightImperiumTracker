import 'package:flutter/material.dart';
import 'package:twilight_imperium_tracker/Translations.dart';
import 'package:twilight_imperium_tracker/feature/game/Game.dart';

extension RaceExtension on Race {
  String getUserFriendlyRaceName(Translations translations) {
    switch (this) {
      case Race.ARBOREC:
        return translations.text('arborec');
      case Race.EMBERS_OF_MUAAT:
        return translations.text('embers_of_muaat');
      case Race.GHOSTS_OF_CREUSS:
        return translations.text('ghosts_of_creuss');
      case Race.NAALU_COLLECTIVE:
        return translations.text('naalu_collective');
      case Race.UNIVERSITIES_OF_JOL_NAR:
        return translations.text('universities_of_jol_nar');
      case Race.YIN_BROTHERHOOD:
        return translations.text('yin_brotherhood');
      case Race.BARONY_OF_LETNEV:
        return translations.text('barony_of_letnev');
      case Race.EMIRATES_OF_HACAN:
        return translations.text('emirates_of_hacan');
      case Race.L1Z1X_MINDNET:
        return translations.text('l1z1x_mindnet');
      case Race.NEKRO_VIRUS:
        return translations.text('nekro_virus');
      case Race.WINNU:
        return translations.text('winnu');
      case Race.YSSARIL_TRIBES:
        return translations.text('yssaril_tribes');
      case Race.CLAN_OF_SAAR:
        return translations.text('clan_of_saar');
      case Race.FEDERATION_OF_SOL:
        return translations.text('federation_of_sol');
      case Race.Mentak_Coalition:
        return translations.text('mentak_coalition');
      case Race.SARDAKK_N_ORR:
        return translations.text('sardakk_n_orr');
      case Race.XXCHA_KINGDOM:
        return translations.text('xxcha_kingdom');
    }
    throw Exception("Not supported Race");
  }

  Image getRaceImageBanner() {
    switch(this) {
      case Race.ARBOREC:
        return Image.asset("assets/images/arborec.PNG");
      case Race.EMBERS_OF_MUAAT:
        return Image.asset("assets/images/embers_of_muaat.PNG");
      case Race.GHOSTS_OF_CREUSS:
        return Image.asset("assets/images/ghosts_of_creuss.PNG");
      case Race.NAALU_COLLECTIVE:
        return Image.asset("assets/images/naalu_collective.PNG");
      case Race.UNIVERSITIES_OF_JOL_NAR:
        return Image.asset("assets/images/universities_of_jol_nar.PNG");
      case Race.YIN_BROTHERHOOD:
        return Image.asset("assets/images/yin_brotherhood.PNG");
      case Race.BARONY_OF_LETNEV:
        return Image.asset("assets/images/barony_of_letnev.PNG");
      case Race.EMIRATES_OF_HACAN:
        return Image.asset("assets/images/emirates_of_hacan.PNG");
      case Race.L1Z1X_MINDNET:
        return Image.asset("assets/images/l1z1x_mindnet.PNG");
      case Race.NEKRO_VIRUS:
        return Image.asset("assets/images/nekro_virus.PNG");
      case Race.WINNU:
        return Image.asset("assets/images/winnu.PNG");
      case Race.YSSARIL_TRIBES:
        return Image.asset("assets/images/yssaril_tribes.PNG");
      case Race.CLAN_OF_SAAR:
        return Image.asset("assets/images/clan_of_saar.PNG");
      case Race.FEDERATION_OF_SOL:
        return Image.asset("assets/images/federation_of_sol.PNG");
      case Race.Mentak_Coalition:
        return Image.asset("assets/images/mentak_coalition.PNG");
      case Race.SARDAKK_N_ORR:
        return Image.asset("assets/images/sardakk_n_orr.PNG");
      case Race.XXCHA_KINGDOM:
        return Image.asset("assets/images/xxcha_kingdom.PNG");
    }
    throw Exception("Not supported Race");
  }
}