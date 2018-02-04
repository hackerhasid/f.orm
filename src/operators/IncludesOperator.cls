global with sharing class IncludesOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' INCLUDES ' + value;
  }
}
