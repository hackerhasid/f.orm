global with sharing class EqualsOperator implements IOperator {
  global String toString(String field, String value) {
    return field + ' = ' + value;
  }
}
