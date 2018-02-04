global with sharing class GreaterThanOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' > ' + value;
  }
}
