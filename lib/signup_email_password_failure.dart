class SignUpWithEmailAndPasswordFailure
{
  final String message;
  const SignUpWithEmailAndPasswordFailure([this.message="An Unknown error occured"]);
  factory SignUpWithEmailAndPasswordFailure.code(String code)
  {
    switch(code)
        {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure('Plesae enter a stronger password');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Not a valid email');
        case 'email-already-in-use':
      return const SignUpWithEmailAndPasswordFailure('Email Already exists');
      case 'operation-not-allowed':
      return const SignUpWithEmailAndPasswordFailure('Invalid operation');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure('This user is disabled');
      default:
        return const SignUpWithEmailAndPasswordFailure();

    }
  }

}