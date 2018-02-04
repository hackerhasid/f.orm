global with sharing class NotEqualsOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' != ' + value;
  }
}