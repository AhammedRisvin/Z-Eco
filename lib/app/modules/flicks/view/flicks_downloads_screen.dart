import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/router.dart';

import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../model/downloads_model.dart';
import '../view_model/flicks_controller.dart';
import '../widgets/download_showing_widget.dart';

class FlicksDownloadsScreen extends StatefulWidget {
  const FlicksDownloadsScreen({super.key});

  @override
  State<FlicksDownloadsScreen> createState() => _FlicksDownloadsScreenState();
}

class _FlicksDownloadsScreenState extends State<FlicksDownloadsScreen> {
  Future<void>? _createListFuture;
  @override
  void initState() {
    super.initState();
    _createListFuture = context.read<FlicksController>().createList();
  }

  init() async {
    Box<DownloadModel> obj = await Hive.openBox<DownloadModel>("abc");
    await obj.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 2),
            SizedBox(
              width: Responsive.width * 100,
              height: Responsive.height * 6,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 20,
                    ),
                  ),
                  SizeBoxV(Responsive.width * 2),
                  Text(
                    'Downloads',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            SizeBoxH(Responsive.width * 2),
            Consumer<FlicksController>(
              builder: (context, provider, child) {
                return FutureBuilder(
                  future: _createListFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text('An error occurred!');
                    } else {
                      return provider.downloadList.isEmpty
                          ? SizedBox(
                              height: Responsive.height * 70,
                              width: Responsive.width * 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Image.asset(
                                      "assets/images/vibesNoDataImage.png",
                                      width: Responsive.width * 100,
                                      height: Responsive.height * 30,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                physics: const ScrollPhysics(),
                                separatorBuilder: (context, index) {
                                  return const SizeBoxH(5);
                                },
                                itemCount: provider.downloadList.length,
                                itemBuilder: (context, index) {
                                  final data = provider.downloadList[index];

                                  return CommonInkwell(
                                      onTap: () {
                                        context.pushNamed(
                                            AppRouter.videoPlayerScreen,
                                            queryParameters: {
                                              'videoUrl': data.path,
                                              'flickId': data.videoId,
                                              "fromWhere": "downloads"
                                            });
                                      },
                                      child: DownloadShowingWidget(
                                        singleData: data,
                                      ));
                                },
                              ),
                            );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
