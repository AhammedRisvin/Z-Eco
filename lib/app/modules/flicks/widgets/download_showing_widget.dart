import 'package:flutter/material.dart';
import 'package:zoco/app/modules/flicks/model/downloads_model.dart';

import '../../../helpers/common_widgets.dart';
import '../../../helpers/sized_box.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/extentions.dart';

class DownloadShowingWidget extends StatelessWidget {
  final DownloadModel singleData;

  const DownloadShowingWidget({
    super.key,
    required this.singleData,
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
                imageUrl: singleData.image,
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
                  singleData.name,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontFamily: 'Plus Jakarta Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.15,
                      ),
                ),
                Text(
                  singleData.duration,
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
                Container(
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
                      singleData.fileSize,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppConstants.black,
                            fontSize: 11,
                            fontFamily: 'Plus Jakarta Sans',
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
