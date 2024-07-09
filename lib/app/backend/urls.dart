import '../env.dart';

class Urls {
  static String baseUrl = Environments.baseUrl;

  static String emailSignup = "${baseUrl}user/signup";
  static String verifyOtp = "${baseUrl}user/verifyOtp";
  static String googleAuth = "${baseUrl}user/googleAuth";
  static String addDetails = "${baseUrl}user/addDetails";
  static String login = "${baseUrl}user/login";
  static String forgotPssword = "${baseUrl}user/forgotPssword";
  static String createNewPassword = "${baseUrl}user/createNewPassword";
  static String changePassword = "${baseUrl}user/changePassword";
  static String updateProfile = "${baseUrl}user/updateProfile";

  static String sectionUrls = "${baseUrl}user/sections";
  // static String productDetailsUrl = "${baseUrl}user/product/";
  static String categoryUrls = "${baseUrl}user/category?section=";

  static String createStripe = "${baseUrl}user/walletStripe";
  static String walletStripeValidation =
      "${baseUrl}user/walletStripeValidation";
  static String getWalletHistory = "${baseUrl}user/getWalletHistory";
  static String walletPaypal = "${baseUrl}user/walletPaypal";
  static String walletPaypalValidation =
      "${baseUrl}user/walletPaypalValidation";
  static String getRecommendedProducts =
      "${baseUrl}user/getRecommendedProducts";

  static String getFashionCatagories = "${baseUrl}user/category?section=";
  static String getFashionProducts =
      "${baseUrl}user/product?"; // "${baseUrl}user/product?category=" //"${baseUrl}user/product?subCategory="
  static String resentOtp = "${baseUrl}user/resentOtp";
  static String getTopSwellings = "${baseUrl}user/getTopSellings";

  static String getAddressUrl = '${baseUrl}user/shippingAddress';
  static String postAddressUrl = '${baseUrl}user/shippingAddress';
  static String editAddressUrl = '${baseUrl}user/shippingAddress/';
  static String deleteAddressUrl = '${baseUrl}user/shippingAddress/';
  static String getNotificationUrl = '${baseUrl}user/getNotification';
  static String searchUrl = '${baseUrl}user/product?';
  static String getCouponsUrl = '${baseUrl}user/coupon?cartId=';
  static String getWishlistUrl = '${baseUrl}user/wishlist';
  static String addOrRemoveFromWishlistUrl = '${baseUrl}user/wishlist';
  static String getVibesUrl = '${baseUrl}user/getVibes';
  static String getVibesUrlWithCatId = '${baseUrl}user/getVibes?category=';
  static String getVibesDetailsUrl = '${baseUrl}user/getVibesDetais?vibesId=';
  static String getFlicksSubscriptionUrl = '${baseUrl}flicks/membership';
  static String getFlicksLibraryUrl = '${baseUrl}flicks/library';
  static String getFlicksWatchHistoryUrl = '${baseUrl}flicks/watchHistory';
  static String getFlicksActivesSubUrl = '${baseUrl}flicks/activePlan';
  static String getProductDetails = '${baseUrl}user/productDetails'; //?link=
  static String getAllOrdersUrl = '${baseUrl}user/getOrders?status=';

  static String getCartUrl = '${baseUrl}user/getCart';
  static String postAddToCartUrl = '${baseUrl}user/addToCart';
  static String cartIncrementUrl = '${baseUrl}user/incrementCartCount';
  static String cartDecrementUrl = '${baseUrl}user/decrementCartCount';
  static String cartRemoveUrl = '${baseUrl}user/removeCart';
  static String cancelOrderUrl = '${baseUrl}user/cancelOrder?';
  static String orderProdcutDetailsUrl = '${baseUrl}user/orderDetails';
  static String cartCheckoutUrl = '${baseUrl}user/checkout';
  static String cartPaypalUrl = '${baseUrl}user/proceedPaypalPay?wallet=';
  static String cartStripeUrl = '${baseUrl}user/proceedStripePay?wallet=';
  static String cartPaypalValidation =
      "${baseUrl}user/proceedPaypalPayValidation";
  static String cartStripeValidation = "${baseUrl}user/proceedStripeValidation";
  static String getReviews = '${baseUrl}user/getReviews';
  static String walletPayUrl = '${baseUrl}user/walletPay';
  static String addReview = '${baseUrl}user/addReview';
  static String getFlicksHomeScreenUrl = '${baseUrl}flicks';
  static String getFlicksCatagoryScreenUrl =
      '${baseUrl}flicks/category?category=';
  static String handleFlicksLibraryUrl = '${baseUrl}flicks/library';
  static String getFlicksDetailedViewUrl = '${baseUrl}flicks/details?link=';
  static String productFilterUrl = '${baseUrl}user/product?category=';
  static String filterDetails = '${baseUrl}user/filterDetails?category=';
  static String deals = '${baseUrl}user/deals';
  static String returnProductUrl = '${baseUrl}user/returnOrder';

  static String flicksWalletPayUrl = '${baseUrl}flicks/membership/walletPay';
  static String flicksPaypalUrl =
      '${baseUrl}flicks/membership/paypalPayment?wallet=';
  static String flicksStripeUrl =
      '${baseUrl}flicks/membership/stripePayment?wallet=';
  static String flicksStripeValidation =
      "${baseUrl}flicks/membership/stripeValidation";
  static String flicksPaypalValidation =
      "${baseUrl}flicks/membership/paypalValidation";
  static String flicksDeleteFromWatchHistoryUrl =
      "${baseUrl}flicks/watchHistory";
  static String flicksDeleteFromLibraryUrl = "${baseUrl}flicks/library";
  static String isWatchHistoryClickedUrl = "${baseUrl}flicks/watchHistory";
  static String trendyOffer = '${baseUrl}user/product?trendyOffer=';

  static String flicksSearchUrl = '${baseUrl}flicks/search?keyword=';
  static String applyCouponUrl = '${baseUrl}user/coupon';
  static String profile = '${baseUrl}user/profile';

  static String removeNotificationUrl = '${baseUrl}user/readNotification';
  static String deleteAccountUrl = '${baseUrl}user/deleteAccount';
}
