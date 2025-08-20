import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvsaviation/resources/constants.dart';

part 'manual_event.dart';
part 'manual_state.dart';

class ManualBloc extends Bloc<ManualEvent, ManualState> {
  ManualBloc() : super(const ManualLoading()) {
    on<ManualInitialEvent>(initialFunction);
    on<ManualChangingEvent>(changingFunction);
  }

  FutureOr<void> initialFunction(ManualInitialEvent event, Emitter<ManualState> emit) async {
    emit(const ManualLoading());
    mainVariables.manualVariables.filePath = "";

    try {
      if (await Permission.storage.request().isGranted) {
        Directory? downloadsDir = await mainFunctions.getDownloadsDirectory();
        if (downloadsDir != null) {
          String savePath = "${downloadsDir.path}/pdf_downloaded_file.pdf";
          await mainVariables.repoImpl.filePdfDownload().onError((error, stackTrace) {
            emit(ManualFailure(errorMessage: error.toString()));
            emit(const ManualLoaded());
          }).then((value) async {
            if (value != null) {
              if (await File(savePath).exists()) {
                await File(savePath).delete();
              }
              File file = File(savePath);
              await file.writeAsBytes(value);
              mainVariables.manualVariables.filePath = file.path;
              emit(const ManualDummy());
              emit(const ManualLoaded());
            }
          });
        } else {
          emit(const ManualFailure(errorMessage: 'Failed to get downloads directory'));
          emit(const ManualLoaded());
        }
      } else {
        emit(const ManualFailure(errorMessage: 'Permission denied to access storage'));
        emit(const ManualLoaded());
      }
    } catch (e) {
      emit(ManualFailure(errorMessage: 'Error downloading file: $e'));
      emit(const ManualLoaded());
    }
  }

  FutureOr<void> changingFunction(ManualChangingEvent event, Emitter<ManualState> emit) async {
    String newPath = await mainFunctions.pickFiles(isPdf: true, context: event.context);
    if (newPath.isNotEmpty) {
      emit(const ManualLoading());
      await mainVariables.repoImpl.filePdfUpload(files: {"pdfFile": File(newPath)}).onError((error, stackTrace) {
        emit(ManualFailure(errorMessage: error.toString()));
        emit(const ManualLoaded());
      }).then((value) async {
        if (value != null) {
          if (value["status"]) {
            Directory? downloadsDir = await mainFunctions.getDownloadsDirectory();
            if (downloadsDir != null) {
              String savePath = "${downloadsDir.path}/pdf_downloaded_file.pdf";
              await mainVariables.repoImpl.filePdfDownload().onError((error, stackTrace) {
                emit(ManualFailure(errorMessage: error.toString()));
                emit(const ManualLoaded());
              }).then((value) async {
                if (value != null) {
                  if (await File(savePath).exists()) {
                    await File(savePath).delete();
                  }
                  File file = File(savePath);
                  await file.writeAsBytes(value);
                  mainVariables.manualVariables.filePath = file.path;
                  emit(const ManualDummy());
                  emit(const ManualLoaded());
                }
              });
            } else {
              emit(const ManualFailure(errorMessage: 'Failed to get downloads directory'));
              emit(const ManualLoaded());
            }
          }
        }
      });
    } else {
      emit(const ManualDummy());
      emit(const ManualLoaded());
    }
  }
}
