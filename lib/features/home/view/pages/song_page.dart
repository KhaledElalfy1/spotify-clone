import 'package:client/core/helpers/functions.dart';
import 'package:client/core/providers/current_song_notifier.dart';
import 'package:client/core/utils/app_colors.dart';
import 'package:client/features/home/view_model/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SongPage extends ConsumerWidget {
  const SongPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyPlayedSongs =
        ref.watch(homeViewModelProvider.notifier).getRecentlyPlayedSongs();
    final currentPlayedSong = ref.watch(currentSongNotifierProvider);
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          decoration: currentPlayedSong == null
              ? null
              : BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      hexToColor(currentPlayedSong.hex_code),
                      AppColors.transparentColor
                    ],
                    stops: const [
                      0.0,
                      0.3,
                    ],
                  ),
                ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  bottom: 36,
                ),
                child: SizedBox(
                  height: 280,
                  child: GridView.builder(
                    itemCount: recentlyPlayedSongs.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                    itemBuilder: (context, index) {
                      final song = recentlyPlayedSongs[index];
                      return GestureDetector(
                        onTap: () {
                          ref
                              .read(currentSongNotifierProvider.notifier)
                              .updateSong(song);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.borderColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 56,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(song.thumbnail_url),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  song.song_name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Text(
                "Latest to play",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              ref.watch(getAllSongsProvider).when(
                    data: (songs) {
                      return SizedBox(
                        height: 260,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(currentSongNotifierProvider.notifier)
                                    .updateSong(songs[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 180,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            songs[index].thumbnail_url,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        songs[index].song_name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        songs[index].artist,
                                        style: const TextStyle(
                                          color: AppColors.subtitleText,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    error: (error, stackTrace) {
                      return Center(child: Text("Error: $error"));
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
