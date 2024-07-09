// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zoco/app/helpers/common_widgets.dart';
import 'package:zoco/app/helpers/loading_overlay.dart';

import '../../../backend/server_client_services.dart';
import '../../../backend/urls.dart';
import '../../../helpers/router.dart';
import '../model/get_review_model.dart';
import '../widgets/review_add_sauccess.dart';

class ReviewProvider extends ChangeNotifier {
  int getReviewStatus = 0;
  GetReviewsModel getReviewsModel = GetReviewsModel();

  Future<void> getReviewFun({required String productId}) async {
    try {
      getReviewStatus = 0;
      notifyListeners();
      List response = await ServerClient.get(
        "${Urls.getReviews}?productId=$productId",
      );
      if (response.first >= 200 && response.first < 300) {
        getReviewsModel = GetReviewsModel.fromJson(response.last);

        notifyListeners();
      } else {
        getReviewsModel = GetReviewsModel();
      }
    } catch (e) {
      getReviewsModel = GetReviewsModel();
    } finally {
      getReviewStatus++;
    }
    notifyListeners();
  }

  double reviewProgressBar(int value) {
    var data = value / 100;

    return data < 1 ? data : .8;
  }

  ///Write Rating

  int selectedRate = 1;

  void updateRate(int value) {
    selectedRate = value;
    notifyListeners();
  }

  TextEditingController reviewController = TextEditingController();

  List<String> addedImageList = [];
  int item = 0;
  File? thumbnailImage;
  Future addImage(bool isGallery, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: isGallery ? ImageSource.gallery : ImageSource.camera,
      );

      if (image == null) return;
      final imageTemporary = File(image.path);
      thumbnailImage = imageTemporary;
      notifyListeners();

      if (thumbnailImage != null) {
        uploadImage(context: context);
      }
    } finally {
      notifyListeners();
    }
  }

//**Image Upload Fun */
  String imageUrlForUpload = '';
  // Function to upload image to the API
  String? imageTitlee;
  Future<void> uploadImage({required BuildContext context}) async {
    LoadingOverlay.of(context).show();

    final fileType = getMimeType(thumbnailImage?.path ?? '');
    const url = 'https://api.dev.test.image.theowpc.com/upload';
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image_mushthak',
        thumbnailImage?.path ?? '',
        contentType: MediaType.parse(fileType),
      ),
    );
    request.headers['Content-Type'] = fileType;
    LoadingOverlay.of(context).hide();
    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var data = json.decode(responseBody);

        imageUrlForUpload = data['images'][0]["imageUrl"];
        addImageToList(imageUrlForUpload);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error occurred during upload: $e ');
    } finally {
      notifyListeners();
    }
  }

  String getMimeType(String filePath) {
    final file = File(filePath);
    final fileType = file.path.split('.').last.toLowerCase();
    switch (fileType) {
      case 'jpg':
        return 'image/jpg';
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'webp':
        return 'image/webp';
      case 'mp4':
        return 'video/mp4';
      case 'webm':
        return 'video/webm';
      case 'mov':
        return 'video/quicktime';
      case 'pdf':
        return 'application/pdf';
      case 'doc':
        return 'application/msword';
      case 'docx':
        return 'application/vnd.openxmlformats-officedocument.wordprocessingml.document';
      case 'xls':
        return 'application/vnd.ms-excel';
      case 'xlsx':
        return 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
      case 'mkv':
        return 'video/x-matroska';
      case 'avi':
        return 'video/x-msvideo';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'flac':
        return 'audio/flac';
      default:
        return 'application/octet-stream';
    }
  }

  void addImageToList(String value) {
    addedImageList.add(value);
    item++;

    notifyListeners();
  }

  Future<void> postReviewFn(
      {required String productId, required BuildContext context}) async {
    if (reviewController.text.isEmpty) {
      toast(context,
          title: "Add your review", backgroundColor: Colors.red, duration: 1);
    } else {
      try {
        LoadingOverlay.of(context).show();
        var params = {
          "productId": productId,
          "review": reviewController.text,
          "rating": selectedRate,
          "images": addedImageList
        };

        List response =
            await ServerClient.post(Urls.addReview, data: params, post: true);

        if (response.first >= 200 && response.first < 300) {
          reviewAddedSuccessSheetFn(context, productId);
          reviewController.clear();
          selectedRate = 0;
          addedImageList.clear();

          LoadingOverlay.of(context).hide();
          context.goNamed(AppRouter.tab);
        } else if (response.first == 400) {
          LoadingOverlay.of(context).hide();
          toast(context,
              title: response.last.toString(), backgroundColor: Colors.red);
        }
      } catch (e) {
        debugPrint('Error occurred during upload: $e ');
      } finally {
        LoadingOverlay.of(context).hide();
        notifyListeners();
      }
    }
  }

  void clear() {
    addedImageList.clear();
    item = 0;
    notifyListeners();
  }
}
