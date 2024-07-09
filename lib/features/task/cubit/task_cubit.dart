import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../domain/model/pdf_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());
  static TaskCubit get( context) => BlocProvider.of(context);
  List <PDFModel> pdfList = [
    PDFModel(title: "form internet", url: "https://github.com/espresso3389/flutter_pdf_render/raw/master/example/assets/hello.pdf",date: "2021-09-01"),
    PDFModel(title: "Sayed Cv locale", url: "assets/pdf/CV.pdf", isLocal: true,date: "2024-09-5"),
    PDFModel(title: "Youssef Cv locale", url: "assets/pdf/Youssef.pdf", isLocal: true),

  ];

  bool isGrid = false;
  void changeView(){
    isGrid = !isGrid;
    emit(changeViewState());
  }


}
