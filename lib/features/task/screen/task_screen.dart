import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_task_app/core/extensions/all_extensions.dart';
import 'package:pdf_task_app/core/utils/extentions.dart';
import 'package:pdf_task_app/features/task/screen/home_screen.dart';
import 'package:pdf_task_app/shared/widgets/edit_text_widget.dart';

import '../../../shared/widgets/pdf_widget.dart';
import '../cubit/task_cubit.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  SampleItem? selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: BlocConsumer<TaskCubit, TaskState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          final cubit = TaskCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.grey.shade700,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(90),
                        ),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://img.freepik.com/free-photo/painting-mountain-lake-with-mountain-background_188544-9126.jpg",
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeIn,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(36.0),
                        child: Icon(Icons.menu, color: Colors.white, size: 50),
                      ),
                    ],
                  ),
                  16.ph,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                    ),
                    child: Text(
                      "Parent/Student\n Handbook",
                      style: context.bodyLarge?.copyWith(
                          color: Colors.green,
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  16.ph,
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60)),
                        color: Colors.white,
                      ),
                      child: ListView(
                        children: [
                          16.ph,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TaskHomeScreen()));
                                    },
                                    icon: const Icon(
                                      Icons.home,
                                      color: Colors.indigo,
                                    )),
                                Expanded(
                                    child: TextFormFieldWidget(
                                  hintText: "Search For Files",
                                  suffixIcon: const Icon(Icons.search),
                                  activeBorderColor: const Color(0xff6B7280),
                                )),
                                PopupMenuButton<SampleItem>(
                                  initialValue: selectedItem,
                                  onSelected: (SampleItem item) {
                                    setState(() {
                                      selectedItem = item;
                                    });
                                  },
                                  itemBuilder: (BuildContext context) =>
                                      <PopupMenuEntry<SampleItem>>[
                                    const PopupMenuItem<SampleItem>(
                                      value: SampleItem.itemOne,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_upward),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Ascending'),
                                              Text('Descending'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const PopupMenuItem<SampleItem>(
                                      value: SampleItem.itemTwo,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.arrow_upward),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Name'),
                                              Text('Modified'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  icon: Icon(
                                    Icons.filter_alt,
                                    color: selectedItem == null
                                        ? Colors.indigo
                                        : Colors.green,
                                  ),
                                  position: PopupMenuPosition.under,
                                ),
                                IconButton(
                                    onPressed: () {
                                      cubit.changeView();
                                    },
                                    icon: Icon(
                                      cubit.isGrid == false
                                          ? Icons.menu
                                          : Icons.grid_view,
                                      color: Colors.indigo,
                                    )),
                              ],
                            ),
                          ),
                          16.ph,
                          cubit.isGrid == false
                              ? ListView.builder(
                                  itemBuilder: (context, index) {
                                    final item = cubit.pdfList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PdfViewerWidget(
                                                        url: item.url,
                                                        isLocal: item.isLocal,
                                                        title: item.title)));
                                      },
                                      child: Card(
                                        elevation: 0.1,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        color: const Color(0xffFAFAFA),
                                        child: ListTile(
                                          leading: const Icon(Icons.file_copy),
                                          title: Text(item.title),
                                          trailing: const Icon(
                                            Icons.download_rounded,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: cubit.pdfList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                )
                              : ListView.builder(
                                  itemBuilder: (context, index) {
                                    final item = cubit.pdfList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PdfViewerWidget(
                                                        url: item.url,
                                                        isLocal: item.isLocal,
                                                        title: item.title)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // width: double.infinity,
                                              // margin: EdgeInsets.symmetric(
                                              //   horizontal: 30,
                                              // ),
                                              decoration: BoxDecoration(
                                                  color: Colors.indigo,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              height: 100,
                                            ),
                                            8.ph,
                                            Text(
                                              item.title,
                                              style: context.bodyLarge
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700),
                                            ),
                                            16.ph,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    (item.date?.isNotEmpty ??
                                                            false)
                                                        ? Row(
                                                            children: [
                                                              const Icon(
                                                                  Icons
                                                                      .date_range_outlined,
                                                                  color: Colors
                                                                      .grey),
                                                              8.pw,
                                                              Text(
                                                                item.date ?? "",
                                                                style: context
                                                                    .bodyLarge
                                                                    ?.copyWith(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                              16.pw,
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    const Icon(
                                                      Icons.file_copy,
                                                      color: Colors.grey,
                                                    ),
                                                    8.pw,
                                                    Text("2MB",
                                                        style: context.bodyLarge
                                                            ?.copyWith(
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500))
                                                  ],
                                                ),
                                                const Icon(
                                                  Icons.download_rounded,
                                                  color: Colors.indigo,
                                                ),
                                              ],
                                            ),
                                            16.ph,
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: cubit.pdfList.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                ),
                          16.ph,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
