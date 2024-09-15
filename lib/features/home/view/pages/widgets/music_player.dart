import 'package:client/core/helpers/functions.dart';
import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/utils/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSongs = ref.watch(currentSongNotifierProvider);
    final songNotifier = ref.read(currentSongNotifierProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            hexToColor(currentSongs!.hex_code),
            const Color(0xFF121212),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Transform.translate(
            offset: const Offset(-15, 0),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Image.asset('assets/images/pull-down-arrow.png'),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Hero(
                  tag: 'music-player',
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          currentSongs.thumbnail_url,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            currentSongs.song_name,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            currentSongs.artist,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border),
                        color: AppColors.whiteColor,
                      )
                    ],
                  )
                ],
              ),
            ),
            StreamBuilder(
                stream: songNotifier.audioPlayer!.positionStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SizedBox();
                  }
                  final position = snapshot.data;
                  final duration = songNotifier.audioPlayer!.duration;
                  double sliderValue = 0.0;
                  if (position != null && duration != null) {
                    sliderValue =
                        position.inMilliseconds / duration.inMilliseconds;
                  }
                  return Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppColors.whiteColor,
                          inactiveTrackColor:
                              AppColors.whiteColor.withOpacity(.117),
                          thumbColor: AppColors.whiteColor,
                          trackHeight: 4,
                          overlayShape: SliderComponentShape.noOverlay,
                        ),
                        child: Slider(
                          value: sliderValue,
                          min: 0,
                          max: 1,
                          onChanged: (value) {
                            sliderValue = value;
                          },
                          onChangeEnd: songNotifier.seek,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${position?.inMinutes ?? '0'}:${position?.inSeconds}',
                            style: const TextStyle(
                              color: AppColors.subtitleText,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            '${duration?.inMinutes ?? '0'}:${duration?.inSeconds}',
                            style: const TextStyle(
                              color: AppColors.subtitleText,
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/shuffle.png'),
                  color: AppColors.whiteColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/previus-song.png'),
                  color: AppColors.whiteColor,
                ),
                IconButton(
                  onPressed: songNotifier.playPause,
                  icon: Icon(
                    songNotifier.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 80,
                  ),
                  color: AppColors.whiteColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/next-song.png'),
                  color: AppColors.whiteColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/repeat.png'),
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/connect-device.png'),
                  color: AppColors.whiteColor,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/images/playlist.png'),
                  color: AppColors.whiteColor,
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
