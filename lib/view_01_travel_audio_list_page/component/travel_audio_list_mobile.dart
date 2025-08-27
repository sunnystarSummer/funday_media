import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../repository/data/travel_audio_list.dart';
import '../../view_02_audio_player/media/media_player_value.dart';
import '../../view_02_audio_player/notifier/media_player_notifier.dart';

class TravelAudioItemView extends ConsumerWidget {
  const TravelAudioItemView({
    super.key,
    required this.audio,
    required this.downloadMP3,
    required this.onTap,
  });

  final TravelAudio audio;
  final Function() downloadMP3;
  final Function() onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<MediaPlayerValue> mediaPlayerValueByAsync = ref.watch(
      mediaPlayerProvider,
    );
    final MediaPlayerValue? mediaPlayerValue = mediaPlayerValueByAsync.value;

    final playingAudio = mediaPlayerValue?.travelAudio;
    final playingAudioId = playingAudio?.id;
    final isPlaying = mediaPlayerValue?.isPlaying;

    final item = audio;

    final id = item.id;
    final title = item.title ?? '';
    final isModified = item.isModified;
    final modifiedDateTime = DateTime.tryParse(item.modified ?? '');
    final updatedTime = modifiedDateTime != null
        ? DateFormat('MM/dd HH:mm').format(modifiedDateTime)
        : '';

    final filePath = item.filePath ?? '';
    final file = File(filePath);

    bool enabledDownload = isModified || !file.existsSync();
    bool enabledPlayMp3 = file.existsSync();

    Widget button = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (enabledDownload)
          TextButton.icon(
            icon: Icon(Icons.download),
            onPressed: () async => await downloadMP3(),
            label: Text('下載'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // 移除額外 padding
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        if (enabledPlayMp3)
          TextButton.icon(
            icon: Icon(Icons.play_arrow),
            onPressed: () => onTap(),
            label: Text('播放'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero, // 移除額外 padding
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
      ],
    );

    if (id == playingAudioId && playingAudio != null) {
      button = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPlaying == true)
            TextButton.icon(
              icon: Icon(Icons.pause),
              onPressed: () async => await audioPlayerAction(ref, playingAudio),
              label: Text('暫停'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // 移除額外 padding
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          if (isPlaying == false)
            TextButton.icon(
              icon: Icon(Icons.play_arrow),
              onPressed: () async => await audioPlayerAction(ref, playingAudio),
              label: Text('播放'),
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero, // 移除額外 padding
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
        ],
      );
    }

    return Column(
      children: [
        ListTile(
          enabled: enabledPlayMp3,
          title: Text(title),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            // Column 只佔自身高度
            mainAxisAlignment: MainAxisAlignment.center,
            // 垂直置中
            crossAxisAlignment: CrossAxisAlignment.end,
            // 靠右對齊
            children: [
              button,
              Text(
                updatedTime,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
          //onTap: widget.onTap,
        ),
        const Divider(),
      ],
    );
  }
}
