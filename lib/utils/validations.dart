// ignore_for_file: prefer_interpolation_to_compose_strings

class Validator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, complete el campo';
    }

    if (!RegExp(r'^[a-zA-Z]{3,}$').hasMatch(value)) {
      return 'El nombre debe tener al menos 3 caracteres y contener solo letras';
    }

    return null;
  }

static String? validateNumber(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'Por favor, complete el campo';
    }

    if (value.contains(' ')) {
      return 'El número no puede contener espacios en blanco';
    }

    final phoneNumber = value.replaceAll(RegExp(r'\D'), '');

    if (!RegExp(r'^\d{' + minLength.toString() + ',12}').hasMatch(phoneNumber)) {
      return 'Debe tener entre $minLength y 12 dígitos y contener solo números';
    }

    return null;
  }
  
  static String? validateOthers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, complete el campo';
    }

    if (!RegExp(r'^[a-zA-Z0-9\s.]{3,}$').hasMatch(value)) {
      return 'El nombre debe tener al menos 3 caracteres y contener letras, números y espacios';
    }
    return null;
  }
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, complete el campo';
  }

  if (value.length < 6) {
    return 'La contraseña debe tener al menos 6 caracteres';
  }

  if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'La contraseña debe contener al menos una letra mayúscula';
  }

  if (!value.contains(RegExp(r'[0-9]'))) {
    return 'La contraseña debe contener al menos un número';
  }

  return null;
}
