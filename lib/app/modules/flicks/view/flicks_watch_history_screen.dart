import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';

import '../../../helpers/router.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/enums.dart';
import '../../../utils/extentions.dart';
import '../view_model/flicks_controller.dart';
import '../widgets/delete_dialogue.dart';
import '../widgets/library_listview_container.dart';

class FlicksWatchHistoryScreen extends StatefulWidget {
  const FlicksWatchHistoryScreen({super.key});

  @override
  State<FlicksWatchHistoryScreen> createState() =>
      _FlicksWatchHistoryScreenState();
}

class _FlicksWatchHistoryScreenState extends State<FlicksWatchHistoryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FlicksController>().getFlicksWatchHistoryFn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizeBoxH(Responsive.height * 2),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: SizedBox(
                width: Responsive.width * 100,
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
                      'Watch History',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    const Spacer(),
                    CommonInkwell(
                      onTap: () {
                        showDeleteFileDialog(
                          context: context,
                          title:
                              "Are you sure you want to clear the watchlist?",
                          isFromSaved: false,
                          onTap: () {
                            context
                                .read<FlicksController>()
                                .clearHistory(context: context);
                          },
                        );
                      },
                      child: Consumer<FlicksController>(
                        builder: (context, provider, child) {
                          return provider.getFlicksWatchHistoryModel.flicks
                                      ?.isEmpty ==
                                  true
                              ? const SizedBox.shrink()
                              : Column(
                                  children: [
                                    Text(
                                      'Clear all',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xff000088),
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                      width: 50,
                                      child: Divider(
                                        color: Color(0xff000088),
                                        thickness: 3,
                                      ),
                                    ),
                                  ],
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizeBoxH(Responsive.width * 2),
            Consumer<FlicksController>(
              builder: (context, provider, child) {
                return provider.getFlicksWatchHistoryModel.flicks?.isEmpty ==
                        true
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
                    : provider.getFlicksWatchHistoryStatus ==
                            GetFlicksWatchHistoryStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.getFlicksWatchHistoryStatus ==
                                GetFlicksWatchHistoryStatus.loaded
                            ? ListView.separated(
                                reverse: true,
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                physics: const NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizeBoxH(5),
                                itemCount: provider.getFlicksWatchHistoryModel
                                        .flicks?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  var libraryData = provider
                                      .getFlicksWatchHistoryModel
                                      .flicks?[(provider
                                              .getFlicksWatchHistoryModel
                                              .flicks
                                              ?.length ??
                                          0) -
                                      1 -
                                      index];
                                  return CommonInkwell(
                                    onTap: () {
                                      provider.selectedSeasonIndex = 0;
                                      context.pushNamed(AppRouter.videoScreen,
                                          queryParameters: {
                                            "productLink":
                                                libraryData?.link ?? "",
                                          });
                                    },
                                    child: LibraryListContainer(
                                      singleData: libraryData,
                                      isFromWatchHistory: true,
                                      isFromDownloads: false,
                                      isFromSaved: false,
                                    ),
                                  );
                                },
                              )
                            : const Text("Something went wrong");
              },
            )
          ],
        ),
      ),
    );
  }
}
