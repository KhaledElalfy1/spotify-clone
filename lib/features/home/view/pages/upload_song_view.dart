import 'dart:io';

import 'package:client/core/utils/app_colors.dart';
import 'package:client/core/utils/app_fonts.dart';
import 'package:client/core/widgets/custom_text_form_filed.dart';
import 'package:client/features/home/view/pages/widgets/audio_waves.dart';
import 'package:client/features/home/view_model/home_viewmodel.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/functions.dart';

class UploadSongView extends ConsumerStatefulWidget {
  const UploadSongView({super.key});

  @override
  ConsumerState<UploadSongView> createState() => _UploadSongViewState();
}

class _UploadSongViewState extends ConsumerState<UploadSongView> {
  final TextEditingController artistController = TextEditingController();
  final TextEditingController songNameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Color selectedColor = AppColors.cardColor;
  File? selectedThumbnail;
  File? selectedAudio;

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedThumbnail = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    artistController.dispose();
    songNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(homeViewModelProvider.select((val) => val?.isLoading == true));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Song'),
        actions: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : IconButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate() &&
                        selectedAudio != null &&
                        selectedThumbnail != null) {
                      ref.read(homeViewModelProvider.notifier).uploadSong(
                            selectedAudio: selectedAudio!,
                            selectedThumbnail: selectedThumbnail!,
                            songName: songNameController.text,
                            artist: artistController.text,
                            selectedColor: selectedColor,
                          );
                    } else {
                      showSnackBar(context, 'Please fill all the fields');
                    }
                  },
                  icon: const Icon(Icons.check),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Row(),
                InkWell(
                  onTap: selectImage,
                  child: selectedThumbnail != null
                      ? Image.file(
                          selectedThumbnail!,
                          fit: BoxFit.fill,
                        )
                      : DottedBorder(
                          color: AppColors.borderColor,
                          dashPattern: const [10, 4],
                          radius: const Radius.circular(12),
                          strokeCap: StrokeCap.square,
                          borderType: BorderType.RRect,
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                Text(
                                  'Select the thumbnail for your song',
                                  style: AppFonts.regular16White,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: 40),
                selectedAudio != null
                    ? AudioWaves(
                        audioPath: selectedAudio!.path,
                      )
                    : CustomTextFormFiled(
                        onTap: selectAudio,
                        hintText: 'Pick Song',
                        controller: null,
                        readOnly: true,
                      ),
                const SizedBox(height: 20),
                CustomTextFormFiled(
                  hintText: 'Artist',
                  controller: artistController,
                ),
                const SizedBox(height: 20),
                CustomTextFormFiled(
                  hintText: 'Song name',
                  controller: songNameController,
                ),
                const SizedBox(height: 20),
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.wheel: true,
                  },
                  onColorChanged: (Color color) {
                    selectedColor = color;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
