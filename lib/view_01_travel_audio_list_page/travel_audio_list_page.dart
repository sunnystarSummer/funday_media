import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../main_mobile.dart';
import '../repository/data/travel_audio_list.dart';

import '../ui/dialog_view.dart';
import '../ui/loading_view.dart';
import 'component/travel_audio_list.dart';
import 'component/travel_audio_list_mobile.dart' as mobile;
import 'notifier/travel_audio_notifier.dart';

class TravelAudioListPage extends ConsumerStatefulWidget {
  const TravelAudioListPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<TravelAudioListPage> createState() =>
      _TravelAudioListPageState();
}

//FIXME: RangeError (index)
class _TravelAudioListPageState extends ConsumerState<TravelAudioListPage> {
  TravelAudioNotifier get _travelAudioNotifier =>
      ref.read(travelAudioProvider.notifier);

  // AsyncValue<TravelAudioList> get _travelAudioState =>
  //     ref.watch(travelAudioProvider);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _fetchTravelAudioOfMediaWhenInitial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _listViewBuilderWithScrollNotification,
    );
  }

  Widget get _body => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[_listViewBuilderWithScrollNotification],
  );

  Future<void> _fetchTravelAudioOfMediaWhenInitial() async {
    await _travelAudioNotifier.fetchTravelAudioOfMedia(
      error: (code, message) =>
          DialogView.showError(context, code: code, message: message),
    );
  }

  Future<void> _fetchTravelAudioOfMediaWhenScroll() async {
    await _travelAudioNotifier.fetchTravelAudioOfMediaWhenScroll(
      error: (code, message) =>
          DialogView.showError(context, code: code, message: message),
    );
  }

  Widget get _listViewBuilderWithScrollNotification =>
      NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels >=
              scrollInfo.metrics.maxScrollExtent - 100) {
            _fetchTravelAudioOfMediaWhenScroll();
            return false; // 不要阻擋
          }
          return false;
        },
        child: _listView,
      );

  Widget get _listView => Consumer(
    builder: (context, ref, _) {
      final state = ref.watch(travelAudioProvider);

      return state.when(
        data: (value) {
          LoadingView.dismiss();
          return _listViewBuilder(value);
        },
        loading: () {
          if ((state.value?.list.isEmpty ?? true)) {
            LoadingView.show();
          }
          return _listViewBuilder(state.value);
        },
        error: (error, _) {
          LoadingView.dismiss();
          return _listViewBuilder(state.value);
        },
      );
    },
  );

  Widget _listViewBuilder(TravelAudioList? travelAudioList) {
    if (travelAudioList == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final isEnd = travelAudioList.list.length == travelAudioList.total;

    return ListView.builder(
      key: PageStorageKey("TravelAudioList"),
      itemCount: travelAudioList.list.isNotEmpty
          ? travelAudioList.list.length + 1
          : 0,
      itemBuilder: (context, index) {
        // ✅ Handle the extra footer slot first
        if (index == travelAudioList.list.length) {
          if (isEnd) {
            return const SizedBox(
              height: 60,
              child: Center(child: Text('沒有更多資料了')),
            );
          } else {
            return Column(
              children: [
                // Text("Index= $index"),
                // Text("Page= ${_travelAudioNotifier.page}"),
                // Text("Total= ${travelAudioList.total}"),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            );
          }
        }

        // Safe: index < list.length
        final value = travelAudioList.list[index];

        //FIXME: 刷新畫面，導致Item位置偏移
        return FutureBuilder<TravelAudio>(
          future: value,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox(
                height: 60,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final audio = snapshot.data!;
            final key = ValueKey("${audio.id}_${audio.title}");

            return isMobile
                ? mobile.TravelAudioItemView(
                    key: key,
                    audio: audio,
                    downloadMP3: () async =>
                        await _travelAudioNotifier.downloadedMp3(
                          index,
                          onReceiveProgress: (received, total) =>
                              LoadingView.showProgress(received, total),
                        ),
                    onTap: () async => intoAudioPlayerPage(ref, audio),
                  )
                : TravelAudioItemView(
                    key: key,
                    audio: audio,
                    onTap: () async => intoAudioPlayerPage(ref, audio),
                  );
          },
        );
      },
    );
  }
}
