global with sharing class SimpleSOQLQuery implements IQuery {
  private Set<String> queryFields = new Set<String>();
  private IPredicate predicate = null;
  protected Integer queryLimit = null;
  private Integer queryOffset = null;
  private OrderBy queryOrdering = null;
  private SObjectType queryObject = null;
  private String queryFor = null;

  global static SimpleSOQLQuery NewInstance(SObjectType typeToQuery) {
    return new SimpleSOQLQuery(typeToQuery);
  }

  global static SimpleSOQLQuery NewInstance(String typeToQuery) {
    return new SimpleSOQLQuery(Schema.getGlobalDescribe().get(typeToQuery));
  }

  private SimpleSOQLQuery(SObjectType typeToQuery) {
    this.queryObject = typeToQuery;
  }


  global SimpleSOQLQuery SelectField(String f) {
    queryFields.add(f);
    return this;
  }

  global SimpleSOQLQuery SelectFields(String[] fs) {
    queryFields.addAll(fs);
    return this;
  }

  /**
   * Example usage:
   * Include('Case__c')
   * Include('Case__r')
   * Include('Case__c.Id')
   * Include('Case__r.Id')
   * Include('Case__r.Account')
   * Include('Case__r.Account.Name')
   **/
  global SimpleSOQLQuery Include(String assoc) {
    List<String> fieldsToTraverse = assoc.split('\\.');
    Map<String, Schema.SObjectField> objectFields = SchemaHelper.getAllFieldsForObject(queryObject);
    IncludeRecursive(fieldsToTraverse.remove(0), fieldsToTraverse, objectFields, '');
    return this;
  }

  private void IncludeRecursive(String head, List<String> tail, Map<String, Schema.SObjectField> objectFields, String relationshipName) {
    // SF has a few different ways of naming relationships
    // we'll loop through and try to find

    Schema.SObjectField relationshipField = objectFields.get(head);

    if (relationshipField == null) {
      // some fields end in id (e.g. accountid on opportunity)
      if (!head.endsWith('id')) {
        String relName = head + 'id';
        relationshipField = objectFields.get(relName);
      }
    }

    if (relationshipField == null) {
      // end users may use __r for their custom relationship not realizing
      // we expect __c since that's the actual field on the DescribeFieldResult
      // let's fix that for them
      if (head.endsWith('__r')) {
        String relName = head.left(head.length() - 1) + 'c';
        relationshipField = objectFields.get(relName);
      }
    }

    if (relationshipField == null) {
      InvalidParameterValueException ex = new InvalidParameterValueException('Include', String.valueOf(head));
      ex.setMessage(head + ' is not a valid reference');
      throw ex; 
    }

    System.debug('head: ' + head);
    for (string f : objectFields.keySet()){
      System.debug(f);
    }
    
    Schema.DescribeFieldResult describeField = relationshipField.getDescribe();

    if (describeField.getType() == Schema.DisplayType.REFERENCE) {
      if (!String.IsBlank(relationshipName)) {
        relationshipName += '.';
      }
      relationshipName += describeField.getRelationshipName();
      List<Schema.sObjectType> referenceObjectTypes = describeField.getReferenceTo();
      // TODO how do we handle multiple reference types?!
      Schema.sObjectType firstObjectType = referenceObjectTypes.get(0);
      objectFields = firstObjectType.getDescribe().fields.getMap();

      if (tail == null || tail.size() == 0) {
        // include all children from this reference
        for (String fieldName : objectFields.keySet()) {
          SelectField(relationshipName + '.' + fieldName);
        }
        return;
      }
      
      IncludeRecursive(tail.remove(0), tail, objectFields, relationshipName);
      return;
    } else {
      // include this relationship with this field
      SelectField(relationshipName + '.' + describeField.getLocalName());
      return;
    }
  }

  global SimpleSOQLQuery Predicate(IPredicate p) {
    predicate = p;
    return this;
  }

  global SimpleSOQLQuery OrderBy(OrderBy o) {
    this.queryOrdering = o;
    return this;
  }

  global SimpleSOQLQuery SetOffset(Integer o) {
    this.queryOffset = o;
    return this;
  }

  global SimpleSOQLQuery ForView() {
    this.queryFor = 'VIEW';
    return this;
  }

  global SimpleSOQLQuery ForReference() {
    this.queryFor = 'REFERENCE';
    return this;
  }

  global SimpleSOQLQuery ForUpdate() {
    this.queryFor = 'UPDATE';
    return this;
  }

  global SimpleSOQLQuery SetLimit(Integer l) {
    this.queryLimit = l;
    return this;
  }

  global SObject First() {
    Integer oldLimit = this.queryLimit;
    this.queryLimit = 1;
    String query = buildQuery();
    SObject obj = Database.Query(query);
    this.queryLimit = oldLimit;
    return obj;
  }

  global SObject[] Execute() {
    String query = buildQuery();
    return Database.Query(query);
  }
  
  public String BuildQuery() {
    List<String> fields = new List<String>(this.queryFields);
    if (queryFields.size() == 0) {
      fields = new List<String>(SchemaHelper.getAllFieldNamesForObject(queryObject));
    }

    String query = 'SELECT ' + String.join(new List<String>(fields), ',');

    query += ' FROM ' + queryObject.getDescribe().getName();

    if (this.predicate != null) {
      query += ' WHERE ' + String.valueOf(this.predicate);
    }

    if (this.queryOrdering != null) {
      query += ' ORDER BY ' + String.valueOf(this.queryOrdering);
    }
    if (this.queryLimit != null) {
      query += ' LIMIT ' + this.queryLimit;
    }

    if (this.queryOffset != null) {
      query += ' OFFSET ' + this.queryOffset;
    }

    if (this.queryFor != null) {
      query += ' FOR ' + this.queryFor;
    }

    System.debug('Query: ' + query);

    return query;
  }
}