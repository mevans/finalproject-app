import 'package:tracker/shared/models/response.dart';

class ChoiceResponse extends Response<int> {
  ChoiceResponse(int variable, int response) : super(variable, response);
}
