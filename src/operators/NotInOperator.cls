global with sharing class NotInOperator implements IOperator{
  global String toString(String field, String value) {
      String inPredicate = (new InOperator()).ToString(field, value);
      return 'NOT (' + inPredicate + ')';
  }
}