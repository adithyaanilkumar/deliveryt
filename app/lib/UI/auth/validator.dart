abstract class StringValidator{
  bool isValid(String value);
}

class NonEmptyStringValidator extends StringValidator
{
  @override
  bool isValid(String value)
  {
    value.isNotEmpty;
  }
}

class EmailAndPasswordValidator
{
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passValidator = NonEmptyStringValidator();
  final String Invalidemailerrortext = 'Email can\'t be empty';
  final String Invalidpasserrortext = 'Password can\'t be empty';
}