global with sharing class LikeOperator implements IOperator{
  global String toString(String field, String value) {
    return field + ' LIKE ' + value;
  }
}