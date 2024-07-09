import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';
import 'package:zoco/app/utils/app_constants.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../helpers/router.dart';
import '../../../utils/enums.dart';
import '../widgets/library_listview_container.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FlicksController>().getFlicksLibraryFn();
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
                    'Saved',
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
              builder: (context, provider, child) => Expanded(
                child: provider.getFlicksLibraryModel.flicks?.isEmpty == true
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
                    : provider.getFlicksLibraryStatus ==
                            GetFlicksLibraryStatus.loading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : provider.getFlicksLibraryStatus ==
                                GetFlicksLibraryStatus.loaded
                            ? ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(10),
                                physics: const ScrollPhysics(),
                                separatorBuilder: (context, index) =>
                                    const SizeBoxH(5),
                                itemCount: provider
                                        .getFlicksLibraryModel.flicks?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  var libraryData = provider
                                      .getFlicksLibraryModel.flicks?[index];

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
                                      isFromSaved: true,
                                    ),
                                  );
                                },
                              )
                            : const Text("Something went wrong"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FlicksContainer extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final bool isSelected;

  const FlicksContainer({
    Key? key,
    required this.onTap,
    required this.text,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: Responsive.height * 4,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? AppConstants.appPrimaryColor : AppConstants.white,
          border: Border.all(
            color:
                isSelected ? AppConstants.white : AppConstants.appPrimaryColor,
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isSelected
                    ? AppConstants.white
                    : AppConstants.appPrimaryColor,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
                letterSpacing: 0.25,
              ),
        ),
      ),
    );
  }
}
