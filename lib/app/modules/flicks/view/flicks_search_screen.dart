import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zoco/app/helpers/sized_box.dart';
import 'package:zoco/app/utils/enums.dart';
import 'package:zoco/app/utils/extentions.dart';

import '../../../utils/app_constants.dart';
import '../view_model/flicks_controller.dart';
import '../widgets/library_listview_container.dart';
import '../widgets/search_flick_shimmer.dart';

class FlicksSearchScreen extends StatefulWidget {
  const FlicksSearchScreen({
    super.key,
  });

  @override
  State<FlicksSearchScreen> createState() => _FlicksSearchScreenState();
}

class _FlicksSearchScreenState extends State<FlicksSearchScreen> {
  @override
  void initState() {
    super.initState();
  }

  final debouncer = Debouncer(milliseconds: 500);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context
                .read<FlicksController>()
                .flicksSearchEditingController
                .clear();
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Container(
            width: Responsive.width * 90,
            height: Responsive.height * 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
              controller: context
                  .read<FlicksController>()
                  .flicksSearchEditingController,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.done,
              style: const TextStyle(
                color: AppConstants.black,
                fontSize: 12,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: AppConstants.white,
                    width: 5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                fillColor: AppConstants.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                hintText: "search here....",
                hintStyle: const TextStyle(
                  color: AppConstants.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              onChanged: (query) {
                debouncer.run(
                  () {
                    context
                        .read<FlicksController>()
                        .getSerchProductFnc(query: query);
                  },
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<FlicksController>(
          builder: (context, provider, child) => SizedBox(
            width: Responsive.width * 100,
            height: Responsive.height * 100,
            child: provider.searchFlicksList?.isEmpty == true &&
                    provider.query.isNotEmpty
                ? const Text("No data found ..")
                : provider.searchFlicksList?.isEmpty == true
                    ? const Text("Search for flicks ...")
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: provider.searchFlicksList?.length ?? 0,
                        separatorBuilder: (context, index) =>
                            const SizeBoxH(10),
                        itemBuilder: (context, index) {
                          final flicksSearchData =
                              provider.searchFlicksList?[index];
                          return provider.flicksSearchStatus ==
                                  FlicksSearchStatus.loading
                              ? const LibraryListContainerShimmer(
                                  isFromSaved: true,
                                )
                              : provider.flicksSearchStatus ==
                                      FlicksSearchStatus.loaded
                                  ? LibraryListContainer(
                                      isFromSaved: true,
                                      singleData: flicksSearchData,
                                      isFromSearch: true,
                                    )
                                  : const Text("data");
                        },
                      ),
          ),
        ),
      ),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 10 / 13,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
      ),
      itemCount: 10, // Assuming a fixed count for demo
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ));
      },
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
