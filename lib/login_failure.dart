class LogInFailure
{
  final String message;
  const LogInFailure([this.message="An Unknown error occured"]);
  factory LogInFailure.code(String code)
  {
    switch(code)
    {
      case 'invalid-email':
        return const LogInFailure('Not a valid email');
      case 'user-not-found':
        return const LogInFailure('User not found');
      case 'wrong-password':
        return const LogInFailure('Incorrect Password');
      case 'user-disabled':
        return const LogInFailure('This user is disabled');
      default:
        return const LogInFailure();

    }
  }

}