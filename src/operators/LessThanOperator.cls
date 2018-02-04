global with sharing class LessThanOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' < ' + value;
  }
}