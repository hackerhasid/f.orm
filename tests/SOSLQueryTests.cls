@isTest
public class SOSLQueryTests {
  @isTest static void SimpleReturningTest() {
    SOSLQuery query = SOSLQuery.newInstance('Microsoft')
      .AndReturning(ReturningClause.newInstance(Account.getSObjectType()));

    String strQuery = query.BuildQuery();
    System.assertEquals('FIND {Microsoft} RETURNING Account', strQuery);
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
