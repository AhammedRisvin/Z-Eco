import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../helpers/sized_box.dart';
import '../../../utils/extentions.dart';
import '../model/get_slicks_library_model.dart';

class LibraryListContainerShimmer extends StatelessWidget {
  final Flick? singleData;
  final bool isFromWatchHistory;
  final bool isFromDownloads;
  final bool isFromSaved;
  const LibraryListContainerShimmer({
    Key? key,
    this.singleData,
    this.isFromDownloads = false,
    this.isFromWatchHistory = false,
    required this.isFromSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: Responsive.width * 100,
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            children: [
              Container(
                width: 80,
                height: 85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey, // Shimmer color
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizeBoxH(Responsive.height * 1),
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.grey, // Shimmer color
                  ),
                  SizeBoxH(Responsive.height * 1),
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.grey, // Shimmer color
                  ),
                  SizeBoxH(Responsive.height * 1),
                  Container(
                    width: double.infinity,
                    height: 14,
                    color: Colors.grey, // Shimmer color
                  ),
                  SizeBoxH(Responsive.height * 1.5),
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.grey, // Shimmer color
                    ),
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 11,
                        color: Colors.grey, // Shimmer color
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                width: 50,
                height: 20,
                color: Colors.grey, // Shimmer color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
