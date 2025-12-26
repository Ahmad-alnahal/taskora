import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import '../../../../core/config/constants/app_sizes.dart';
import '../../../../core/config/widgets/buttons/app_primary_icon_button.dart';
import '../../../core/config/constants/image_path.dart';
import '../../../core/theme/app_text_theme.dart';
import '../bloc/onboarding_bloc.dart';
import '../bloc/onboarding_event.dart';
import '../bloc/onboarding_state.dart';
import '../models/onboarding_item.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  static const items = <OnboardingItem>[
    OnboardingItem(

      imageAsset: ImagePath.onboarding1,
      title: "إدارة مشاريعك بكل سهولة ووضوح",
      description:
      "أنشئ مشاريعك، حدّد تفاصيلها، وتابع تقدّمك خطوة بخطوة من مكان واحد مصمّم خصيصًا للمستقلّين.",
    ),
    OnboardingItem(

      imageAsset:  ImagePath.onboarding2,
      title: "نظّم مهامك وابقَ على المسار الصحيح",
      description:
      "أضف مهام لكل مشروع، حدّد أولوياتها، وتتبع حالة كل مهمة من ToDo حتى Done بسهولة وبساطة.",
    ),
    OnboardingItem(

      imageAsset:  ImagePath.onboarding3,
      title: "اعرف أرباحك الحقيقية فوراً",
      description:
      "يحسب التطبيق ساعات عملك تلقائيًا ويعرض أرباحك لكل مستقل ولكل مهمة أو مشروع بدقة وشفافية.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(total: items.length)..add(const OnboardingStarted()),
      child: const _OnboardingView(),
    );
  }
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listenWhen: (p, c) => p.finished != c.finished,
        listener: (context, state) {
          if (state.finished) {
            // Navigator.pushReplacementNamed(context, '/login');
          }
        },
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            final item = OnboardingPage.items[state.index];

            return Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                SizedBox(

                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(BorderRadiusSize.borderRadiusCircular),
                        bottomRight: Radius.circular(BorderRadiusSize.borderRadiusCircular)
                    ),
                    child:Stack(
                      children: [


                         AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Image.asset(
                              item.imageAsset,
                              key: ValueKey(item.imageAsset),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 14,
                          child: _Dots(
                            count: state.total,
                            activeIndex: state.index,
                            onTap: (i) => context.read<OnboardingBloc>().add(OnboardingDotTapped(i)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),  
                const SizedBox(height:SizedBoxSizes.sizedBoxXLargeHeight),
                Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: AppPadding.paddingHorizontal),
                  child: Column(children: [

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        item.title,
                        key: ValueKey(item.title),
                        textAlign: TextAlign.center,
                        style: OnboardingTextTheme.title,
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        item.description,
                        key: ValueKey(item.description),
                        textAlign: TextAlign.center,
                        style: OnboardingTextTheme.description,
                      ),
                    ),

                    const SizedBox(height:SizedBoxSizes.sizedBoxMediumHeight),

                    if (state.isLast)
                      AppPrimaryIconButton(
                        text: "تسجيل الدخول",
                        onPressed: () => context.read<OnboardingBloc>().add(const OnboardingFinishPressed()),
                      )
                    else
                      AppPrimaryIconButton(
                        text: "التالي",
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: () => context.read<OnboardingBloc>().add(const OnboardingNextPressed()),
                      ),

                    const SizedBox(height: 14),

                  ],
                  ),
                )

              ],
            );
          },
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    required this.count,
    required this.activeIndex,
    required this.onTap,
  });

  final int count;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return GestureDetector(
          onTap: () => onTap(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: active ? 18 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: active
                  ? Theme.of(context).colorScheme.secondary
                  : Theme.of(context).dividerColor.withOpacity(0.6),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        );
      }),
    );
  }
}
