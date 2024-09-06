import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:client/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AudioWaves extends StatefulWidget {
  const AudioWaves({super.key, required this.audioPath});
  final String audioPath;

  @override
  State<AudioWaves> createState() => _AudioWavesState();
}

class _AudioWavesState extends State<AudioWaves> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initAudioPlayer();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  void initAudioPlayer() async {
    await playerController.preparePlayer(path: widget.audioPath);
  }

  Future<void> playAndPause() async {
    if (!playerController.playerState.isPlaying) {
      await playerController.startPlayer(finishMode: FinishMode.stop);
    } else if (!playerController.playerState.isPaused) {
      await playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            playerController.playerState.isPlaying
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            size: const Size(double.infinity, 100),
            playerController: playerController,
            playerWaveStyle: const PlayerWaveStyle(
              fixedWaveColor: AppColors.borderColor,
              liveWaveColor: AppColors.gradient2,
              spacing: 6,
              showSeekLine: false,
            ),
          ),
        ),
      ],
    );
  }
}
