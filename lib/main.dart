import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:funday_media/main_mobile.dart';
import 'package:funday_media/repository/data/travel_audio_list.dart';
import 'package:funday_media/repository/main_repository.dart';
import 'package:funday_media/ui/loading_view.dart';
import 'package:funday_media/view_01_travel_audio_list_page/travel_audio_list_page.dart';
import 'package:funday_media/view_02_audio_player/audio_player_page.dart';
import 'package:funday_media/view_02_audio_player/media/media_player_value.dart';
import 'package:funday_media/view_02_audio_player/notifier/media_player_notifier.dart';
import 'package:go_router/go_router.dart';

const appName = 'Travel Audio App';

Future<void> main() async {
  if (isMobile) {
    mainOfMobile();
  } else {
    mainOfMobile();
  }

  //MUST
  LoadingView.config();
}

AbsMainRepository repository = mainOfRepository;

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => TravelAudioListPage(title: appName),
      ),
      GoRoute(
        path: '/audio_player',
        builder: (_, __) => AudioPlayerPage(title: appName),
      ),
    ],
  );
});

Future<void> intoAudioPlayerPage(WidgetRef ref, TravelAudio audio) async {
  final notifier = ref.read(mediaPlayerProvider.notifier);

  AsyncValue<MediaPlayerValue> valueByAsync = ref.watch(mediaPlayerProvider);
  final MediaPlayerValue value = valueByAsync.requireValue;

  print('MediaPlayerValue: $value');

  print('travelAudioId: ${value.travelAudio?.id}');
  print('audioId: ${audio.id}');

  if (value.travelAudio?.id != audio.id) {
    await notifier.setTravelAudioMedia(audio);

    // 使用 routerProvider 來做導航
    final router = ref.read(routerProvider);
    router.push('/audio_player');
  }
}
