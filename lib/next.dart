import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'const.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class Next extends StatefulWidget {
  const Next(
      {Key? key, required this.lan, required this.isDark, required this.name})
      : super(key: key);
  final bool isDark;
  final String name;
  final String lan;
  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<Next> with WidgetsBindingObserver {
  final _player = AudioPlayer();
  var duration;
  BorderRadiusGeometry radius = const BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );
  Color drColor = Color.fromARGB(255, 60, 71, 71);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(AudioSource.uri(Uri.parse(
          "https://firebasestorage.googleapis.com/v0/b/tele-gid.appspot.com/o/${widget.name}%2F${widget.lan}.mp3?alt=media&token=201d14c1-bc72-4078-9fe4-5981f4740dab")));
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDark ? drColor : Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          color: widget.isDark ? Colors.white : Colors.grey[900],
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: widget.isDark ? drColor : Colors.transparent,
        elevation: 0,
        title: Text(
          names[widget.lan][widget.name],
          textAlign: TextAlign.start,
          style: TextStyle(
              color: widget.isDark ? Colors.white : Colors.grey[900],
              fontSize: 25),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: widget.isDark
                            ? Colors.white
                            : Color.fromARGB(255, 143, 159, 196),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          locs[widget.lan][widget.name],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: widget.isDark
                                  ? Colors.white
                                  : Color.fromARGB(255, 143, 159, 196),
                              fontSize: 19),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 9, left: 9, right: 9, bottom: 3),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: widget.isDark ? drColor : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey[200]!, blurRadius: 5)
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.isDark
                          ? "https://firebasestorage.googleapis.com/v0/b/tele-guide.appspot.com/o/${widget.name}-wide-night.jpg?alt=media"
                          : "https://firebasestorage.googleapis.com/v0/b/tele-guide.appspot.com/o/${widget.name}-wide-day.jpg?alt=media",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: SizedBox(
                                  height: 39,
                                  width: 39,
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    color: widget.isDark
                                        ? Colors.white
                                        : Color.fromARGB(255, 143, 159, 196),
                                  ))),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      infos[widget.lan][widget.name],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: widget.isDark
                              ? Colors.white
                              : Color.fromARGB(255, 143, 159, 196),
                          fontSize: 19),
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlidingUpPanel(
              boxShadow: [],
              minHeight: 70,
              maxHeight: 190,
              color: Colors.transparent,
              panel: Center(
                child: InkWell(
                  onTap: () async {},
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 70),
                          height: 95,
                          width: 95,
                          child: Center(
                            child: StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                      customWidths: CustomSliderWidths(
                                          progressBarWidth: 7)),
                                  innerWidget: (v) {
                                    return const SizedBox();
                                  },
                                  max: positionData?.duration.inSeconds
                                          .toDouble() ??
                                      1,
                                  initialValue: positionData?.position.inSeconds
                                          .toDouble() ??
                                      1,
                                  onChangeEnd: (v) {
                                    _player.seek(Duration(seconds: v.toInt()));
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          width: 70,
                          margin: const EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: widget.isDark
                                        ? Colors.white
                                        : Color.fromARGB(255, 139, 147, 170),
                                    blurRadius: 19)
                              ],
                              shape: BoxShape.circle,
                              color: widget.isDark
                                  ? Colors.white
                                  : Color.fromARGB(255, 143, 159, 196)),
                          child: Center(
                            child: StreamBuilder<PlayerState>(
                              stream: _player.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final processingState =
                                    playerState?.processingState;
                                final playing = playerState?.playing;
                                if (processingState ==
                                        ProcessingState.loading ||
                                    processingState ==
                                        ProcessingState.buffering) {
                                  return Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: 39.0,
                                    height: 39.0,
                                    child: CircularProgressIndicator(
                                      color: widget.isDark
                                          ? drColor
                                          : Colors.white,
                                    ),
                                  );
                                } else if (playing != true) {
                                  return IconButton(
                                    icon: Icon(Icons.play_arrow),
                                    color:
                                        widget.isDark ? drColor : Colors.white,
                                    iconSize: 39.0,
                                    onPressed: _player.play,
                                  );
                                } else if (processingState !=
                                    ProcessingState.completed) {
                                  return IconButton(
                                    icon: Icon(Icons.pause),
                                    color:
                                        widget.isDark ? drColor : Colors.white,
                                    iconSize: 39.0,
                                    onPressed: _player.pause,
                                  );
                                } else {
                                  return IconButton(
                                    icon: Icon(Icons.replay),
                                    color:
                                        widget.isDark ? drColor : Colors.white,
                                    iconSize: 39.0,
                                    onPressed: () =>
                                        _player.seek(Duration.zero),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              collapsed: Center(
                child: Container(
                  height: 12,
                  width: 80,
                  decoration: BoxDecoration(
                      color: widget.isDark
                          ? Colors.white
                          : Color.fromARGB(255, 143, 159, 196),
                      boxShadow: [
                        BoxShadow(
                            color: widget.isDark
                                ? Colors.white
                                : Color.fromARGB(255, 139, 147, 170),
                            blurRadius: 19)
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(9))),
                ),
              ),
              borderRadius: radius,
            ),
          ),
        ],
      ),
    );
  }
}
