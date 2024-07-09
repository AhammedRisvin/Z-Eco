import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoco/app/modules/flicks/view_model/flicks_controller.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';
import '../model/get_slicks_library_model.dart';
import 'delete_dialogue.dart';

class LibraryListContainer extends StatelessWidget {
  final Flick? singleData;
  final bool isFromWatchHistory;
  final bool isFromDownloads;
  final bool isFromSearch;
  final bool isFromSaved;
  const LibraryListContainer({
    super.key,
    this.singleData,
    this.isFromDownloads = false,
    this.isFromWatchHistory = false,
    required this.isFromSaved,
    this.isFromSearch = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: Responsive.width * 100,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: CachedImageWidget(
                imageUrl: singleData?.banner ?? '',
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeBoxH(Responsive.height * 1),
                Text(
                  singleData?.name ?? '',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.15,
                      ),
                ),
                Text(
                  singleData?.duration ?? "0",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: const Color(0xFF8390A1),
                        fontSize: 14,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1,
                      ),
                ),
                SizeBoxH(Responsive.height * 1.5),
                isFromDownloads
                    ? Container(
                        alignment: Alignment.center,
                        width: 50,
                        height: 20,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFDCE4F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            singleData?.fileSize ?? '',
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: AppConstants.black,
                                  fontSize: 11,
                                  fontFamily: 'Plus Jakarta Sans',
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                showDeleteFileDialog(
                  context: context,
                  title: isFromSaved
                      ? 'Are you sure you want to delete this file?'
                      : isFromWatchHistory
                          ? "Are you sure you want to delete this?"
                          : "",
                  isFromSaved: isFromSaved,
                  onTap: () {
                    isFromSaved
                        ? context
                            .read<FlicksController>()
                            .deleteFlicksFromLibrary(
                              context: context,
                              id: singleData?.id ?? "",
                            )
                        : isFromWatchHistory
                            ? context
                                .read<FlicksController>()
                                .deleteFlicksWatchHistoryFn(
                                    context: context,
                                    ids: [singleData?.id ?? ""])
                            : isFromDownloads
                                ? null
                                : null;
                  },
                );
              },
              child: Text(
                isFromSaved
                    ? isFromSearch
                        ? ""
                        : "Remove"
                    : 'Delete',
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFFDB3022),
                      fontSize: 13,
                      fontFamily: 'Plus Jakarta Sans',
                      fontWeight: FontWeight.w600,
                    ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
