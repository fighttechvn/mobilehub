import 'package:flutter/material.dart';

import 'checkbox_widget.dart';
import 'group_check_box_widget.dart';

class CheckboxFormField<T> extends FormField<T> {
  CheckboxFormField({
    super.key,
    required Set<T> values,
    super.initialValue,
    int? numberOfRow,
    super.validator,
    ValueChanged<T?>? onSelected,
    double spacing = 8.0,
    WrapAlignment? wrapAlignment,
    bool isRadioType = false,
    bool autovalidate = false,
    CheckboxBuilder<T>? checkBoxbuilder,
    AutovalidateMode super.autovalidateMode =
        AutovalidateMode.onUserInteraction,
    GroupCheckBoxBuilder<T>? groupCheckBoxBuilder,
  }) : super(
          builder: (FormFieldState<T> state) {
            return GroupCheckBoxWidget<T>(
              defaultValue: initialValue,
              values: values.toList(),
              numberOfRow: numberOfRow,
              isRadioType: isRadioType,
              checkBoxbuilder: checkBoxbuilder,
              groupCheckBoxBuilder: groupCheckBoxBuilder,
              onSelected: (T? value) {
                onSelected?.call(value);
                // ignore: invalid_use_of_protected_member
                state.setValue(value);
                state.validate();
              },
              spacing: spacing,
              wrapAlignment: wrapAlignment,
              error: state.hasError && (state.errorText?.isNotEmpty ?? false)
                  ? Builder(
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  : null,
            );
          },
        );

  CheckboxFormField.custom({
    super.key,
    required List<T> values,
    super.initialValue,
    int? numberOfRow,
    super.validator,
    ValueChanged<T?>? onSelected,
    double spacing = 8.0,
    WrapAlignment? wrapAlignment,
    bool isRadioType = false,
    bool autovalidate = false,
    CheckboxBuilder<T>? checkBoxbuilder,
    AutovalidateMode super.autovalidateMode =
        AutovalidateMode.onUserInteraction,
    GroupCheckBoxBuilder<T>? groupCheckBoxBuilder,
    required Widget Function(T data, bool isSelected)? builderTitle,
  }) : super(
          builder: (FormFieldState<T> state) {
            return GroupCheckBoxWidget<T>.custom(
              builderTitle: builderTitle,
              defaultValue: initialValue,
              values: values,
              numberOfRow: numberOfRow,
              isRadioType: isRadioType,
              checkBoxbuilder: checkBoxbuilder,
              groupCheckBoxBuilder: groupCheckBoxBuilder,
              onSelected: (T? value) {
                onSelected?.call(value);
                // ignore: invalid_use_of_protected_member
                state.setValue(value);
                state.validate();
              },
              spacing: spacing,
              wrapAlignment: wrapAlignment,
              error: state.hasError && (state.errorText?.isNotEmpty ?? false)
                  ? Builder(
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          state.errorText!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                  : null,
            );
          },
        );
}
