global with sharing class LessThanOrEqualsOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' <= ' + value;
  }
}