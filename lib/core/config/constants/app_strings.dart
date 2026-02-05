class AppStrings {
  AppStrings._();

  // App Name
  static const String appName = 'Taskora';

}
class AuthStrings{
  static const String email = 'البريد الإلكتروني';
  static const String enterEmail = 'أدخل بريدك الإلكتروني';
  static const String password = 'كلمة المرور';
  static const String enterPassword = 'أدخل كلمة المرور';
  static const String invalidEmail = '👎 البريد الإلكتروني غير صحيح';
  static const String invalidPassword = '👎 كلمة المرور غير صحيحة';
}
class LoginStrings{
  LoginStrings._();
  static const String loginApp = "تسجيل دخول للتطبيق";
  static const String login= "تسجيل الدخول";
  static const String welcomeToLoginApp = "يسعدنا رؤيتك من جديد، سجل الدخول للبدء الآن";
  static const String forgetPassword = 'هل نسيت كلمة المرور؟';
  static const String doNotHaveAccount = 'لا يوجد لديك حساب؟';
  static const String createAccount = 'قم بانشاء حساب';
}
class SignupStrings {
  SignupStrings._();
  static const name = 'اسم المستخدم';
  static const enterName = 'ادخل اسمك بالكامل';
  static const invalidName = 'اسم غير صالح';
  static const invalidEmail = 'بريد غير صالح';
  static const invalidPassword = 'كلمة المرور غير صالحة';
  static const confirmPassword = 'تأكيد كلمة المرور';
  static const enterConfirmPassword = 'ادخل كلمة المرور';
  static const invalidConfirmPassword = 'تأكيد كلمة المرور غير صالح';
  static const passwordNotMatch = 'كلمتا المرور غير متطابقتين';
  static const hourRate = 'سعر الساعة';
  static const enterHourRate = 'ادخل سعر الساعة';
  static const invalidHourRate = 'سعر الساعة غير صالح';
  static const hourRateNote ='سيتم حفظ هذا السعر في ملفك الشخصي واستخدامه كقيمة افتراضية عند إنشاء المشاريع';
  static const createAccount = 'إنشاء الحساب';
  static const haveAccount = 'هل يوجد لديك حساب؟ ';
  static const login = 'قم بتسجيل الدخول';
  static const termsNote1 = ' بإنشاء حساب، فإنك توافق على';
  static const termsNote2 = ' شروط الخدمة و سياسة الخصوصية';
  static const signupApp = 'إنشاء حساب';
  static const welcomeToSignupApp ='قم بتعبئة بياناتك كي تتمكن من انشاء حساب داخل التطبيق ووتتمع بجميع المميزات بعد انشاء الحساب';
}

class OnboardingStrings{
  OnboardingStrings._();
  static const String onboardingTitle1 = "إدارة مشاريعك بكل سهولة ووضوح";
  static const String onboardingTitle2 = "نظّم مهامك وابقَ على المسار الصحيح";
  static const String onboardingTitle3 = "اعرف أرباحك الحقيقية فوراً";
  static const String onboardingSubTitle1 = "أنشئ مشاريعك، حدّد تفاصيلها، وتابع تقدمك خطوة بخطوة في مكان واحد مصمّم خصيصاً للمستقلين.ً";
  static const String onboardingSubTitle2 = "أضف مهام لكل مشروع، حدّد أولوياتها، وتتبع حالة كل مهمة من ToDo حتى Done بسهولة وبساطة.ً";
  static const String onboardingSubTitle3 = "يحسب التطبيق ساعات عملك تلقائياً ويعرض لك أرباحك المكتسبة لكل مهمة أو مشروع، بدقة وشفافية.ً";
}

class StatusBadgeStrings{
  StatusBadgeStrings._();
  static const String inProgress = 'قيد التنفيذ';
  static const String toDo = 'للعمل';
  static const String high ='مرتفعة';
  static const String medium ='متوسطة';
  static const String low ='منخفضة';
}

class BottomNavBarStrings{
  BottomNavBarStrings._();
  static const String home = 'الرئيسية';
  static const String projects = 'المشاريع';
  static const String profile = 'الملف الشخصي';
}

class AlertDialogStrings{
  AlertDialogStrings._();
  static const String confirmText = 'نعم';
  static const String cancelText = 'لا';
}
class AppBottomSheetStrings{
  AppBottomSheetStrings._();
  static const String congratulationsAccountCreated = 'مبـــروك. تم إنشـــاء حســابك بنجاح !.';

  static const String retry = 'إعادة المحاولة';
  static const String back = 'العودة';
  static const String startURFirstStep = 'ابدأ أول خطوة الك';

  /// Don't worry… the first step is always the easiest!
  static const String DWFSIAE = 'ما تقلق… أول خطوة دايمًا الأسهل!';
  static const String unexpectedError =  'حدث خطأ غير متوقع';
  static const String uncompletedProcessTryAgain =  'لم نتمكن من إكمال العملية، يرجى المحاولة مرة أخرى.';
  static const String emptyStateMessage =  "ولا شي هون لسه!\n واضح إنك ما عملت أي إجراء لحد الآن. خلينا نبدأ الرحلة سوا.\n هاي الصفحة فاضية لأنك ما ضفت ولا عنصر.";

}
class ForgotPasswordStrings{
  static const String plzEnterEmail = 'يرجى إدخال بريدك الإلكتروني لإرسال الكود';
  static const String send = 'أرسل';
}
class  VerifyPasswordStrings{
  static const String activationCode = 'كود التفعيل';
  static const String codeSended = 'تم إرسال رمز تفعيل للحساب على الايميل المرفق أدناه';
  static const String followUp = 'المتابعة';
  static const String didNotReceiveCode = 'لم تستلم رمز التفعيل؟ ';
  static const String resend = 'إعادة الإرسال';
  static const String codeExpireIn = 'ستنتهي صلاحية الرمز بعد';
  static const String conNotBeSendWait = 'لا يمكن إعادة الإرسال الآن، انتظر ';

}