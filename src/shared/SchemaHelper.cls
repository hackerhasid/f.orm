public with sharing class SchemaHelper {
  public static Map<String, Schema.SObjectField> getAllFieldsForObject(SObjectType t) {
    Schema.DescribeSObjectResult describe = t.getDescribe();
    return describe.fields.getMap();
  }

  public static Set<String> getAllFieldNamesForObject(SObjectType t) {
    Map<String, Schema.SObjectField> fieldMap = getAllFieldsForObject(t);
    Map<String, String> fieldNames = new Map<String, String>();

    //Due to an issue where SOQL complains that litify_pm__Some_Field__c and Some_Field__c are the same,
    //we have to week out fields that have duplicate api names minus the namespace prefix
    //We prioritize the client's custom fields over litify fields. 
    for (Schema.SObjectField field : fieldMap.values()) {
      String fieldName = field.getDescribe().getName();
      String fieldNameNoPrefix = fieldName.toLowerCase().replace('litify_pm__', '');
      if (!fieldName.toLowerCase().contains('litify_pm__') || !fieldNames.containsKey(fieldNameNoPrefix)){
        fieldNames.put(fieldNameNoPrefix, fieldName);
      }
    }
    return new Set<String>(fieldNames.values());
  }
}
