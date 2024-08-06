import 'services/easy_inapp_review_service.dart';

Future<void> appStoreRating() async {
  await EasyInAppReviewService().openFeedback();
}

Future<void> appStoreReview(String appstoreId) async {
  return EasyInAppReviewService().openStoreListing(appstoreId);
}
