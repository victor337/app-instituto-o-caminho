import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:instituto_o_caminho/core/theme/app_colors.dart';

class AppInputTextField extends StatefulWidget {
  const AppInputTextField({
    required this.title,
    required this.hint,
    required this.onChanged,
    this.isEnabled = true,
    this.errorText,
    this.initialValue,
    this.textCapitalization,
    this.textEditingController,
    this.showRemoveTextOption = false,
    this.maxLines,
    this.keyboardType,
    this.inputFormatters,
    super.key,
  });

  final String title;
  final String? errorText;
  final bool isEnabled;
  final String hint;
  final Function(String) onChanged;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final TextEditingController? textEditingController;
  final bool showRemoveTextOption;
  final int? maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppInputTextField> createState() => _AppInputTextFieldState();
}

class _AppInputTextFieldState extends State<AppInputTextField> {
  bool hasFocus = false;
  late TextEditingController textEditingController;

  @override
  void initState() {
    textEditingController =
        widget.textEditingController ?? TextEditingController();
    textEditingController.text = widget.initialValue ?? '';
    super.initState();
  }

  final Theme theme = Theme();

  @override
  Widget build(BuildContext context) {
    TextStyle getContentStyle() {
      if (widget.isEnabled) {
        return const TextStyle(
          color: constLight,
        );
      }
      return const TextStyle(
        color: sectionColor,
      );
    }

    TextStyle getTitleStyle() {
      return const TextStyle(
        fontSize: 16,
        color: lightMedium,
      );
    }

    Color? getColor() {
      if (widget.isEnabled) {
        return modalBackground;
      }
      return theme.tokens.neutralColorHighDark;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: getTitleStyle(),
        ),
        SizedBox(
          height: theme.tokens.spacingQuarck,
        ),
        Focus(
          onFocusChange: (value) {
            setState(() {
              hasFocus = value;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: theme.tokens.borderRadiusXs,
              color: getColor(),
            ),
            child: TextField(
              maxLines: widget.maxLines,
              controller: textEditingController,
              inputFormatters: widget.inputFormatters,
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.sentences,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: const TextStyle(
                  color: greyText,
                ),
                border: InputBorder.none,
                suffixIcon: widget.showRemoveTextOption &&
                        textEditingController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            textEditingController.text = '';
                            widget.onChanged('');
                          });
                        },
                        child: Icon(
                          Icons.close_rounded,
                          color: theme.tokens.feedbackColorErrorPure,
                          size: 20,
                        ),
                      )
                    : null,
                contentPadding: EdgeInsets.all(
                  theme.tokens.spacingMicro,
                ),
              ),
              onChanged: widget.onChanged,
              style: getContentStyle(),
            ),
          ),
        ),
      ],
    );
  }
}

class Theme {
  final Tokens tokens = Tokens();
  Typo get typography => Typo(tokens: tokens);
}

class Tokens {
  Color get brandColorPrimaryPure => const Color(0xffA100FF);
  Color get brandColorPrimaryLight => const Color(0xffDCAFFF);
  Color get brandColorPrimaryMedium => const Color(0xff7500C0);
  Color get brandColorPrimaryDark => const Color(0xff460073);
  Color get brandColorSecondaryPure => const Color(0xff0041F0);
  Color get brandColorSecondaryLight => const Color(0xff86A7FF);
  Color get brandColorSecondaryMedium => const Color(0xff3068FD);
  Color get brandColorSecondaryDark => const Color(0xff324288);

  Color get brandColorHighlightPure => const Color(0xffB455AA);
  Color get brandColorHighlightLight => const Color(0xffE6DCFF);
  Color get brandColorHighlightMedium => const Color(0xffBE82FF);
  Color get brandColorHighlightDark => const Color(0xffA055F5);

  Color get neutralColorLowPure => const Color(0xff000000);
  Color get neutralColorLowLight => const Color(0xffB3B2B5);
  Color get neutralColorLowMedium => const Color(0xff4F4B53);
  Color get neutralColorLowDark => const Color(0xff1D1823);
  Color get neutralColorHighPure => const Color(0xffFFFFFF);
  Color get neutralColorHighLight => const Color(0xffFAFAFA);
  Color get neutralColorHighMedium => const Color(0xffE5E5E5);
  Color get neutralColorHighDark => const Color(0xffCCCBCE);

  Color get feedbackColorSuccessPure => const Color(0xff48CB48);
  Color get feedbackColorSuccessLight => const Color(0xff64FF50);
  Color get feedbackColorSuccessMedium => const Color(0xff58BA3B);
  Color get feedbackColorSuccessDark => const Color(0xff3E8629);
  Color get feedbackColorWarningPure => const Color(0xffF19B4C);
  Color get feedbackColorWarningLight => const Color(0xffFFEB32);
  Color get feedbackColorWarningMedium => const Color(0xffFF7800);
  Color get feedbackColorWarningDark => const Color(0xffAD5F00);
  Color get feedbackColorErrorPure => const Color(0xffEB5757);
  Color get feedbackColorErrorLight => const Color(0xffFF3246);
  Color get feedbackColorErrorMedium => const Color(0xffD72C3C);
  Color get feedbackColorErrorDark => const Color(0xffB10B02);
  Color get feedbackColorInfoPure => const Color(0xff009DFF);
  Color get feedbackColorInfoLight => const Color(0xff76BBE3);
  Color get feedbackColorInfoMedium => const Color(0xff0041F0);
  Color get feedbackColorInfoDark => const Color(0xff00558A);

  /// FontSizes
  double get fontSizeXxxs => 8;
  double get fontSizeXxs => 12;
  double get fontSizeXs => 16;
  double get fontSizeSm => 20;
  double get fontSizeMd => 24;
  double get fontSizeLg => 32;
  double get fontSizeXl => 40;
  double get fontSizeXxl => 48;
  double get fontSizeXxxl => 64;
  double get fontSizeDisplay => 80;
  double get fontSizeGiant => 96;

  /// LineHeights
  double get lineHeightXxxs => 12;
  double get lineHeightXxs => 20;
  double get lineHeightXs => 24;
  double get lineHeightSm => 32;
  double get lineHeightMd => 36;
  double get lineHeightLg => 48;
  double get lineHeightXl => 60;
  double get lineHeightXxl => 72;
  double get lineHeightXxxl => 96;
  double get lineHeightDisplay => 120;
  double get lineHeightGiant => 144;

  /// BorderRadius
  BorderRadius get borderRadiusNone => BorderRadius.circular(0);
  BorderRadius get borderRadiusXs => BorderRadius.circular(4);
  BorderRadius get borderRadiusSm => BorderRadius.circular(8);
  BorderRadius get borderRadiusMd => BorderRadius.circular(16);
  BorderRadius get borderRadiusLg => BorderRadius.circular(24);
  BorderRadius get borderRadiusPill => BorderRadius.circular(500);
  BorderRadius get borderRadiusCircular => BorderRadius.circular(100);

  /// BorderWidth
  double get borderWidthNone => 0;
  double get borderWidthHairLine => 1;
  double get borderWidthThin => 2;
  double get borderWidthThick => 4;
  double get borderWidthHeavy => 8;

  /// OpacityLevel
  double get opacityLevelTransparent => 0;
  double get opacityLevelSemiTransparent => 0.08;
  double get opacityLevelLight => 0.16;
  double get opacityLevelMedium => 0.32;
  double get opacityLevelIntense => 0.64;
  double get opacityLevelSemiOpaque => 0.72;
  double get opacityLevelOpaque => 1;

  /// ShadowLevel
  BoxShadow get shadowLevel1 => const BoxShadow(
        offset: Offset(0, 4),
        blurRadius: 8,
        spreadRadius: 0,
      );

  BoxShadow get shadowLevel2 => const BoxShadow(
        offset: Offset(0, 8),
        blurRadius: 24,
        spreadRadius: 0,
      );

  BoxShadow get shadowLevel3 => const BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 32,
        spreadRadius: 0,
      );

  BoxShadow get shadowLevel4 => const BoxShadow(
        offset: Offset(0, 16),
        blurRadius: 48,
        spreadRadius: 0,
      );

  /// Spacing
  double get spacingQuarck => 4;
  double get spacingNano => 8;
  double get spacingMicro => 12;
  double get spacingXxxs => 16;
  double get spacingXxs => 24;
  double get spacingXs => 32;
  double get spacingSm => 40;
  double get spacingMd => 48;
  double get spacingLg => 56;
  double get spacingXl => 64;
  double get spacingXxl => 80;
  double get spacingXxxl => 120;
  double get spacingHuge => 160;
  double get spacingGiant => 200;

  /// Spacing Inset
  EdgeInsets get spacingInsetXxxs => const EdgeInsets.all(4);
  EdgeInsets get spacingInsetXxs => const EdgeInsets.all(8);
  EdgeInsets get spacingInsetXs => const EdgeInsets.all(16);
  EdgeInsets get spacingInsetSm => const EdgeInsets.all(24);
  EdgeInsets get spacingInsetMd => const EdgeInsets.all(32);
  EdgeInsets get spacingInsetLg => const EdgeInsets.all(40);

  /// Divisor
  Size get divisorXxs => const Size(2, double.maxFinite);

  /// FontFamily
  String get fontFamilyHighlight => 'Sectra';
  //String get fontFamilyBase => 'Graphik';

  String get fontFamilyBase => 'Montserrat';

  /// Font Weights
  FontWeight get fontWeightBold => FontWeight.w700;
  FontWeight get fontWeightSemiBold => FontWeight.w600;
  FontWeight get fontWeightMedium => FontWeight.w500;
  FontWeight get fontWeightRegular => FontWeight.w400;
}

class Typo {
  Typo({required this.tokens});
  final Tokens tokens;

  /// Head

  // Primary
  TextStyle get headPrimaryXxxlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightBold,
        fontSize: tokens.fontSizeXxxl,
        //height: tokens.lineHeightXxxl,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get headPrimaryXxlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxl,
        //height: tokens.lineHeightXl,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get headPrimaryXlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXl,
        //height: tokens.lineHeightXl,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get headPrimaryLgStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightMedium,
        fontSize: tokens.fontSizeLg,
        //height: tokens.lineHeightLg,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get headPrimaryMdStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightMedium,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightSm,
        color: tokens.brandColorPrimaryPure,
      );

  // Low
  TextStyle get headLowXxxlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightBold,
        fontSize: tokens.fontSizeXxxl,
        //height: tokens.lineHeightXxxl,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get headLowXxlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxl,
        //height: tokens.lineHeightXl,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get headLowXlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXl,
        //height: tokens.lineHeightXl,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get headLowLgStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightMedium,
        fontSize: tokens.fontSizeLg,
        //height: tokens.lineHeightLg,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get headLowLgSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeLg,
        //height: tokens.lineHeightLg,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get headLowMdStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightMedium,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightMd,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get headLowMdSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightMd,
        color: tokens.neutralColorLowPure,
      );

  // High
  TextStyle get headHighXxxlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightBold,
        fontSize: tokens.fontSizeXxxl,
        //height: tokens.lineHeightXxxl,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get headHighXxlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxl,
        //height: tokens.lineHeightXl,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get headHighXlStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXl,
        //height: tokens.lineHeightXl,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get headHighLgStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightMedium,
        fontSize: tokens.fontSizeLg,
        //height: tokens.lineHeightLg,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get headHighMdStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightMedium,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightSm,
        color: tokens.neutralColorHighPure,
      );

  /// Body

  // Primary
  TextStyle get bodyPrimaryMdStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightSm,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get bodyPrimarySmStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeSm,
        //height: tokens.lineHeightSm,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get bodyPrimaryXsStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get bodyPrimaryXxsStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.brandColorPrimaryPure,
      );

  // Low
  TextStyle get bodyLowMdStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightSm,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get bodyLowSmStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeSm,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get bodyLowXsStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get bodyLowXxsStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorLowPure,
      );

  // High
  TextStyle get bodyHighXxsStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightSm,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get bodyHighMdStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeMd,
        //height: tokens.lineHeightSm,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get bodyHighSmStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeSm,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get bodyHighXsStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorHighPure,
      );

  /// Label

  // Primary
  TextStyle get labelPrimaryXsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get labelPrimaryXsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get labelPrimaryXxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get labelPrimaryXxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get labelPrimaryXxxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.brandColorPrimaryPure,
      );

  TextStyle get labelPrimaryXxxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.brandColorPrimaryPure,
      );

  // Variant
  TextStyle get labelVariantXsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.brandColorPrimaryMedium,
      );

  TextStyle get labelVariantXsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.brandColorPrimaryMedium,
      );

  TextStyle get labelVariantXxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.brandColorPrimaryMedium,
      );

  TextStyle get labelVariantXxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.brandColorPrimaryMedium,
      );

  TextStyle get labelVariantXxxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.brandColorPrimaryMedium,
      );

  TextStyle get labelVariantXxxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.brandColorPrimaryMedium,
      );

  // Disabled

  TextStyle get labelDisableXsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorLowLight,
      );

  TextStyle get labelDisableXsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorLowLight,
      );

  TextStyle get labelDisableXxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorLowLight,
      );

  TextStyle get labelDisableXxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorLowLight,
      );

  TextStyle get labelDisableXxxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.neutralColorLowLight,
      );

  TextStyle get labelDisableXxxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.neutralColorLowLight,
      );

  // Low
  TextStyle get labelLowXsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get labelLowXsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get labelLowXxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get labelLowXxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get labelLowXxxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.neutralColorLowPure,
      );

  TextStyle get labelLowXxxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.neutralColorLowPure,
      );

  // Negative
  TextStyle get labelNegativeXsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.feedbackColorErrorPure,
      );

  TextStyle get labelNegativeXsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.feedbackColorErrorPure,
      );

  TextStyle get labelNegativeXxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.feedbackColorErrorPure,
      );

  TextStyle get labelNegativeXxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.feedbackColorErrorPure,
      );

  TextStyle get labelNegativeXxxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.feedbackColorErrorPure,
      );

  TextStyle get labelNegativeXxxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.feedbackColorErrorPure,
      );

  // High
  TextStyle get labelHighXsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get labelHighXsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXs,
        //height: tokens.lineHeightXs,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get labelHighXxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get labelHighXxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxs,
        //height: tokens.lineHeightXxs,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get labelHighXxxsRegularStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightRegular,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.neutralColorHighPure,
      );

  TextStyle get labelHighXxxsSemiBoldStyle => TextStyle(
        fontFamily: tokens.fontFamilyBase,
        fontWeight: tokens.fontWeightSemiBold,
        fontSize: tokens.fontSizeXxxs,
        //height: tokens.lineHeightXxxs,
        color: tokens.neutralColorHighPure,
      );
}
