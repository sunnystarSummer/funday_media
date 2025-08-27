import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main_mobile.dart';
import '../view_02_audio_player/notifier/media_player_notifier.dart';
import 'media/media_player_value.dart';

class AudioPlayerPage extends ConsumerStatefulWidget {
  const AudioPlayerPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends ConsumerState<AudioPlayerPage> {
  MediaPlayerNotifier get _mediaPlayerNotifier =>
      ref.read(mediaPlayerProvider.notifier);

  AsyncValue<MediaPlayerValue> get _mediaPlayerStateWithAsync =>
      ref.watch(mediaPlayerProvider);

  MediaPlayerValue? _mediaPlayerValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _bodyByAsyncNotifier,
    );
  }

  Widget get _bodyByAsyncNotifier => _mediaPlayerStateWithAsync.when(
    data: (value) {
      _mediaPlayerValue = value;
      return _body;
    },
    loading: () => _body,
    error: (error, _) => _body,
  );

  Widget get _body => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[_filePathText, _button],
    ),
  );

  String? get _title => isMobile
      ? _mediaPlayerValue?.travelAudio?.filePath
      : _mediaPlayerValue?.travelAudio?.url;

  Widget get _filePathText =>
      Text(_title ?? 'NoFile', textAlign: TextAlign.center);

  Widget get _button => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      if (_mediaPlayerValue?.isPlaying == false)
        IconButton(
          onPressed: () async => await _mediaPlayerNotifier.play(),
          iconSize: 48.0,
          icon: const Icon(Icons.play_arrow),
        ),
      if (_mediaPlayerValue?.isPlaying == true)
        IconButton(
          onPressed: () async => await _mediaPlayerNotifier.pause(),
          iconSize: 48.0,
          icon: const Icon(Icons.pause),
        ),
    ],
  );
}
