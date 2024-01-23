import 'dart:developer';

import 'package:features_demo_file_picker/NOTIFICATION_LOCAL_SERVICE.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'filepicker_event.dart';
part 'filepicker_state.dart';

class FilePickerBloc extends Bloc<FilePickerEvent, FilePickerState> {
  FilePickerBloc() : super(FilePickerInitial()) {
    on<FilePickerEvent>((event, emit) {});
    on<FilePickerPickingEvent>((event, emit) {
      loadFilesFromFiles(event: event);
    });
    on<FilePickerLoadedEvent>((event, emit) {
      showLoadedFilesFromFilePicker(event: event);
    });
  }

  void loadFilesFromFiles({required FilePickerEvent event}) async {
    if (event is FilePickerPickingEvent) {
      emit(FilePickerLoadingState());
      try {
        event.result = await FilePicker.platform.pickFiles(
              allowMultiple: true,
              type: FileType.custom,
              allowedExtensions: <String>["pdf", "jpg", "jpeg", "png"],
            ) ??
            const FilePickerResult(<PlatformFile>[]);

        if ((event.result?.files ?? []).isNotEmpty) {
          try {
            for (var i = 0; i < (event.result?.files.length ?? 0); i++) {
              NotificationService notificationService = NotificationService();
              notificationService.createNotification(
                  100,
                  ((10 / 10) * 100).toInt(),
                  i,
                  event.result?.files[i].name ?? "");

              print(event.result?.files[i].name);
            }
            // NotificationService notificationService = NotificationService();
            // notificationService.createNotification(
            //     100,
            //     ((10 / 10) * 100).toInt(),
            //     1,
            //     event.result?.files.first.name ?? "");
          } catch (e) {
            print(e);
          }
          add(FilePickerLoadedEvent(result: event.result));

          ///* single file size
          // final File selected =
          //     File((event.result?.files ?? []).single.path ?? "");
          // final String ext = selected.path.split(".").last.toLowerCase();
          // if (ext == "pdf" || ext == "jpg" || ext == "jpeg" || ext == "png") {
          //   final int size = await selected.length();
          //   print("size: $size");
          //   print("loading");
          //
          // } else {
          //   log("Invalid File Type");
          // }
          // /
        } else {
          add(FilePickerLoadedEvent(result: event.result));
          //add your code for changing UI here
          log("Nothing Picked From File Picker");
        }
      } catch (e) {
        print("exception : $e");
      }
    }
  }

  void showLoadedFilesFromFilePicker({required FilePickerEvent event}) async {
    if (event is FilePickerLoadedEvent) {
      emit(FilePickerLoadedState(result: event.result));
    }
  }
}
