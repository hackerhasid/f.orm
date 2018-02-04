global with sharing class InOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' IN (' + value + ')';
  }
}
