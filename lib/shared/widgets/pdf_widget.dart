import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

class PdfViewerWidget extends StatelessWidget {
  final String url;
  bool? isLocal;
  final String title;

  PdfViewerWidget(
      {super.key,
      required this.url,
      required this.title,
      this.isLocal = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: isLocal == true
          ? PdfViewer.openAsset(
              url,
              viewerController: PdfViewerController(),

              onError: (error) {
                Center(
                  child: Text(
                    "there is an error ${error}",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 26,
                    ),
                  ),
                );
              },
            )
          : FutureBuilder<File>(
              future: DefaultCacheManager().getSingleFile(url),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return PdfViewer.openFile(
                    snapshot.data?.path ??
                        "https://github.com/espresso3389/flutter_pdf_render/raw/master/example/assets/hello.pdf",
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text(
                      "there is an error ${snapshot.error}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 26,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "there is an error ${snapshot.error}",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 26,
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}
