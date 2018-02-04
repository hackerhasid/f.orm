global with sharing class GreaterThanOrEqualsOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' >= ' + value;
  }
}
