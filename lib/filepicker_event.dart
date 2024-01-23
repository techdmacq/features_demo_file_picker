part of 'filepicker_bloc.dart';

@immutable
abstract class FilePickerEvent {}

class FilePickerPickingEvent extends FilePickerEvent {
  FilePickerResult? result;

  FilePickerPickingEvent({required this.result});
}

class FilePickerLoadedEvent extends FilePickerEvent {
  final FilePickerResult? result;

  FilePickerLoadedEvent({required this.result});
}
