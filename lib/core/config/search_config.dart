import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/field_config.dart';

final searchConfigProvider = Provider<Map<String, FieldConfig>>((ref) {
  return searchConfig;
});

final searchConfig = {
  'firstName': FieldConfig(
    type: 'text',
    label: 'First Name',
    placeholder: 'Enter first name',
    renderOrder: 1,
  ),
  'lastName': FieldConfig(
    type: 'text',
    label: 'Last Name',
    placeholder: 'Enter last name',
    renderOrder: 2,
  ),
  'dateOfBirth': FieldConfig(
    type: 'date',
    label: 'Date of Birth',
    renderOrder: 3,
  ),
  /*  'maritalStatus': FieldConfig(
    type: 'text',
    label: 'Marital Status',
    placeholder: 'Enter marital status',
    renderOrder: 4,
  ),
  'addresses.city': FieldConfig(
    type: 'text',
    label: 'City',
    placeholder: 'City',
    renderOrder: 5,
  ),*/
};
