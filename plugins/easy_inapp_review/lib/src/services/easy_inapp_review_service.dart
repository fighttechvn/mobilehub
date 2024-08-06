import 'package:in_app_review/in_app_review.dart';

enum Availability { loading, available, unavailable }

class EasyInAppReviewService {
  final InAppReview _inAppReview = InAppReview.instance;

  Future<Availability> checkAvailability() async {
    try {
      final isAvailable = await _inAppReview.isAvailable();
      return isAvailable ? Availability.available : Availability.unavailable;
    } catch (_) {
      return Availability.unavailable;
    }
  }

  Future<void> openStoreListing(String appStoreId) =>
      _inAppReview.openStoreListing(appStoreId: appStoreId);

  Future<void> requestReview() => _inAppReview.requestReview();

  Future<bool> openFeedback() async {
    final availability = await checkAvailability();

    if (availability == Availability.available) {
      await requestReview();
      return true;
    } else {
      return false;
    }
  }
}
