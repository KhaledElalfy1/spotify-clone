import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:client/core/failure/failure.dart';
import 'package:client/core/helpers/server_constant.dart';
import 'package:client/features/home/model/song_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailure, String>> uploadSong(
      {required File selectedAudio,
      required File selectedThumbnail,
      required String songName,
      required String artist,
      required String hexCode,
      required String token}) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${ServerConstant.baseUrl}/song/upload'));

      request
        ..files.addAll(
          [
            await http.MultipartFile.fromPath('song', selectedAudio.path),
            await http.MultipartFile.fromPath(
                'thumbnail', selectedThumbnail.path),
          ],
        )
        ..fields.addAll(
          {
            'artist': artist,
            'song_name': songName,
            'hex_code': hexCode,
          },
        )
        ..headers.addAll(
          {
            'x-auth-token': token,
          },
        );

      final response = await request.send();

      log(response.statusCode.toString());
      if (response.statusCode != 201) {
        return left(AppFailure(message: await response.stream.bytesToString()));
      }
      log(await response.stream.bytesToString());
      return right(await response.stream.bytesToString());
    } catch (e) {
      return left(AppFailure(message: e.toString()));
    }
  }

  Future<Either<AppFailure, List<SongModel>>> getAllSongs(
      {required String token}) async {
    try {
      final response = await http
          .get(Uri.parse('${ServerConstant.baseUrl}/song/list'), headers: {
        'Content-Type': 'application/json',
        'x-auth-token': token,
      });
      var responseBody = jsonDecode(response.body);
      log(response.statusCode.toString());
      if (response.statusCode != 200) {
        responseBody = responseBody as Map<String, dynamic>;
        return Left(AppFailure(message: responseBody['detail']));
      }
      responseBody = responseBody as List<dynamic>;
      List<SongModel> songs = [];
      for (var map in responseBody) {
        songs.add(SongModel.fromMap(map));
      }
      return Right(songs);
    } catch (e) {
      return Left(AppFailure(message: e.toString()));
    }
  }
}
