part of 'filepicker_bloc.dart';

@immutable
abstract class FilePickerState {}

class FilePickerInitial extends FilePickerState {}

class FilePickerLoadingState extends FilePickerState {}

class FilePickerLoadedState extends FilePickerState {
  final FilePickerResult? result;

  FilePickerLoadedState({required this.result});
}
