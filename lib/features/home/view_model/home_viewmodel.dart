import 'dart:developer';
import 'dart:io';

import 'package:client/core/helpers/functions.dart';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:client/features/home/repositories/home_local_repository.dart';
import 'package:client/features/home/repositories/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async {
  final response = await ref
      .watch(homeRepositoryProvider)
      .getAllSongs(token: ref.watch(currentUserNotifierProvider)!.token);

  return switch (response) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;
  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);

    return null;
  }

  Future<void> uploadSong(
      {required File selectedAudio,
      required File selectedThumbnail,
      required String songName,
      required String artist,
      required Color selectedColor}) async {
    state = const AsyncValue.loading();
    final response = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: rgpToHex(selectedColor),
      token: ref.read(currentUserNotifierProvider)!.token,
    );
    final val = switch (response) {
      Left(value: final l) => state = AsyncValue.error(l, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
    log("the response from home viewModel is==> $val");
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepository.loadSong();
  }
}
