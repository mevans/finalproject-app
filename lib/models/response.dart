import 'package:equatable/equatable.dart';

class Response<T> extends Equatable {
  final int variable;
  final T response;

  Response(this.variable, this.response);

  List<Object> get props => [variable, response];

  Map<String, dynamic> toJson() {
    return {
      'variable': this.variable,
      'response': this.response,
    };
  }
}
