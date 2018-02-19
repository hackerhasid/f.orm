public with sharing class SchemaHelper {
  public static Map<String, Schema.SObjectField> getAllFieldsForObject(SObjectType t) {
    Schema.DescribeSObjectResult describe = t.getDescribe();
    return describe.fields.getMap();
  }

  public static Set<String> getAllFieldNamesForObject(SObjectType t) {
    Map<String, Schema.SObjectField> fieldMap = getAllFieldsForObject(t);
    Set<String> fieldNames = new Set<String>();

    for (Schema.SObjectField field : fieldMap.values()) {
      fieldNames.add(field.getDescribe().getName());
    }
    return fieldNames;
  }
}
