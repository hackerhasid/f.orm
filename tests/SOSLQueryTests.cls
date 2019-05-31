@isTest
public class SOSLQueryTests {
  @isTest static void SimpleReturningTest() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(ReturningClause.newInstance(Account.getSObjectType()));

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} RETURNING Account', strQuery);
  }

  @isTest static void SimpleFirstTest() {
    Account a1 = new Account(Name = 'B');
    insert a1; 

    Test.setFixedSearchResults(new List<Id>{a1.Id});

    Test.startTest();

    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(ReturningClause.newInstance(Account.getSObjectType()));

    Account act = (Account) query.First(); // noop because we can't do soql tests

    Test.stopTest();
  }

  @isTest static void SimpleLimitTest() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(ReturningClause.newInstance(Account.getSObjectType()))
      .SetLimit(1);

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} RETURNING Account LIMIT 1', strQuery);
  }

  @isTest static void SearchGroup_AllFields() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Name')
        )
        .SetSearchGroup(SOSLQuery.SearchGroup.ALL_FIELDS);

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} IN ALL FIELDS RETURNING Account(Name)', strQuery);
  }
  @isTest static void SearchGroup_NameFields() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Name')
        )
        .SetSearchGroup(SOSLQuery.SearchGroup.NAME_FIELDS);

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} IN NAME FIELDS RETURNING Account(Name)', strQuery);
  }
  @isTest static void SearchGroup_EmailFields() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Name')
        )
        .SetSearchGroup(SOSLQuery.SearchGroup.EMAIL_FIELDS);

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} IN EMAIL FIELDS RETURNING Account(Name)', strQuery);
  }

  @isTest static void SearchGroup_PhoneFields() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Name')
        )
        .SetSearchGroup(SOSLQuery.SearchGroup.PHONE_FIELDS);

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} IN PHONE FIELDS RETURNING Account(Name)', strQuery);
  }
    @isTest static void SearchGroup_SidebarFields() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Name')
        )
        .SetSearchGroup(SOSLQuery.SearchGroup.SIDEBAR_FIELDS);

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} IN SIDEBAR FIELDS RETURNING Account(Name)', strQuery);
  }
  @isTest static void ReturningWithStringFieldTest() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Name')
        );

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} RETURNING Account(Name)', strQuery);
  }

  @isTest static void ReturningWithFieldAndPredicateTest() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(
        ReturningClause.newInstance(Account.getSObjectType())
          .SelectField('Id')
          .Predicate(EqualsPredicate.newInstance('Name', '123'))
        );

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} RETURNING Account(Id WHERE Name = \'123\')', strQuery);
  }
}
