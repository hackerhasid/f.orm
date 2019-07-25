global with sharing class SOSLQuery implements IQuery {
  // https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_sosl_syntax.htm

  global Enum SearchGroup { ALL_FIELDS, NAME_FIELDS, EMAIL_FIELDS, PHONE_FIELDS, SIDEBAR_FIELDS }

  private String queryString = null;
  private SOSLQuery.SearchGroup querySearchGroup = null;
  public List<ReturningClause> queryReturningClause { get; private set; }
  private Integer queryLimit = null;

  global static SOSLQuery NewInstance(String query) {
    return new SOSLQuery(query);
  }

  private SOSLQuery(String query) {
    this.queryString = query;
    queryReturningClause = new List<ReturningClause>();
  }

  global SOSLQuery SetLimit(Integer l) {
    this.queryLimit = l;
    return this;
  }

  global SOSLQuery AndReturning(ReturningClause c) {
    queryReturningClause.add(c);
    return this;
  }

  global SOSLQuery OnlyReturning(ReturningClause c) {
    queryReturningClause.clear();
    queryReturningClause.add(c);
    return this;
  }

  global SObject First() {
    Integer oldLimit = this.queryLimit;
    this.queryLimit = 1;
    String query = buildQuery();
    List<List<SObject>> res = Search.Query(query);
    SObject obj = res[0][0];
    this.queryLimit = oldLimit;
    return obj;
  }

  global List<List<SObject>> Execute() {
    String query = buildQuery();
    return Search.Query(query);
  }

  public String BuildQuery() {
    String query = 'FIND {' + queryString + '}';

    if (querySearchGroup != null) {
      query += ' IN ';
      if (querySearchGroup == SOSLQuery.SearchGroup.ALL_FIELDS) {
        query += 'ALL FIELDS';
      } else if (querySearchGroup == SOSLQuery.SearchGroup.NAME_FIELDS) {
        query += 'NAME FIELDS';
      } else if (querySearchGroup == SOSLQuery.SearchGroup.EMAIL_FIELDS) {
        query += 'EMAIL FIELDS';
      } else if (querySearchGroup == SOSLQuery.SearchGroup.PHONE_FIELDS) {
        query += 'PHONE FIELDS';
      } else if (querySearchGroup == SOSLQuery.SearchGroup.SIDEBAR_FIELDS) {
        query += 'SIDEBAR FIELDS';
      }
    }

    if (queryReturningClause.size() > 0) {
      query += ' RETURNING ';
      Boolean isFirstClause = true;
      for (ReturningClause c : queryReturningClause) {
        if (!isFirstClause) {
          query += ',';
        }
        query += String.valueOf(c);
        isFirstClause = false;
      }
    }

    if (this.queryLimit != null) {
      query += ' LIMIT ' + this.queryLimit;
    }

    return query;
  }
}
