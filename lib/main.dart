import 'package:features_demo_file_picker/filepicker_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File picker demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<FilePickerBloc>(
          create: (context) => FilePickerBloc(),
          child: const FilePickerDemo(title: 'File picker demo')),
    );
  }
}

class FilePickerDemo extends StatefulWidget {
  const FilePickerDemo({super.key, required this.title});

  final String title;

  @override
  State<FilePickerDemo> createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  FilePickerBloc? filePickerBloc;
  FilePickerResult? result;

  @override
  void initState() {
    filePickerBloc = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text("Multiple File picker Bloc demo"),
            ),
            body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: BlocBuilder<FilePickerBloc, FilePickerState>(
                    builder: (context, state) {
                  if (state is FilePickerLoadingState) {
                    return const CircularProgressIndicator();
                  } else if (state is FilePickerLoadedState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Selected file:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                itemCount: state.result?.files.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Text(
                                      state.result?.files[index].name ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              filePickerBloc
                                  ?.add(FilePickerPickingEvent(result: result));
                            },
                            child: const Text("File Picker"),
                          ),
                        ),
                      ],
                    );
                  } else {
                    ("result : $result");
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Selected file: ${((result?.files ?? []).isEmpty ? "no files selected" : "")}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                itemCount: result?.files.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Text(result?.files[index].name ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold));
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 5,
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              filePickerBloc
                                  ?.add(FilePickerPickingEvent(result: result));
                              // _showProgressNotification();
                              // _updateProgress();
                              if (result == null) {
                                ("No file selected");
                              } else {
                                for (var element in result!.files) {
                                  (element.name);
                                  (element.path);
                                }
                              }
                            },
                            child: const Text("File Picker"),
                          ),
                        ),
                      ],
                    );
                  }
                }))));
  }
}
