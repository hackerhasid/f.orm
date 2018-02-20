# F.ORM

The Salesforce ORM. Documentation still very much a work in progress. Not a ton of code yet though so should be pretty easy to follow.

# Getting Started

Still pretty early but take a look at `SimpleSOQLQuery` and `SimpleSOSLQuery` classes.

Also take a look at `tests/SimpleSOQLQueryTests.cls` and `tests/SimpleSOSLQueryTests.cls` for some usage examples.

# Usage Examples

You should really look at the tests since those will be kept up to date more than this document. But for the lazy:

## SOQL Query

```apex
Account act = SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .Include('Account')
  .First();
```

```apex
Account[] acts = SimpleSOQLQuery.newInstance(Opportunity.SObjectType)
  .Include('Account')
  .Limit(100)
  .Offset(100)
  .OrderBy(OrderBy.SingleOrdering('Name', OrderDirection.DESCENDING))
  .Execute();
```

## SOSL Query

```apex
Account[] acts = SOSLQuery.newInstance('Microsoft')
  .AndReturning(
    ReturningClause.newInstance(Account.getSObjectType())
      .SelectField('Id')
      .Predicate(EqualsPredicate.newInstance('Name', '123'))
    )
  .Execute();
```

# Design

F.ORM is meant as a natural Apex API to output SOQL and SOSL. All consumer-intended classes are instantiated via a _static_ `newInstance` method. All consumer-intended methods return the same type to allow chaining.

## Quries

There are 2 qury types:

* `SimpleSOQLQuery` representing a "simple" (non-aggregate) SOQL query
* `SOSLQuery` representing a SOSL query

I anticipate writing another one - `AggregateSOQLQuery` - to handle aggregate queries but have not gotten there yet.

## Predicates

Every predicate supported by SOQL/SOSL is implemented:

both "simple" predicates:

* `EqualsPredicate` representing `=`
* `ExcludesPredicate` representing the `EXCLUDES` keyword
* `GreaterThanPredicate` representing `>`
* `GreaterThanOrEqualsPredicate` representing `>=`
* `IncludesPredicate` representing the `INCLUDES` keyword
* `InPredicate` representing the `IN` keyword
* `LessThanPredicate` representing `<`
* `LessThanOrEqualsPredicate` representing `<=`
* `LikePredicxate` representing the `LIKE` keyword
* `NotEqualsPredicate` representing `<>`
* `NotInPredicagte` representing the `NOT IN` keyword
* `NotPredicate` representing the `NOT` keyword

and "complex" predicates:

* `AndPredicate` representing the `AND` keyword
* `OrPredicate` representing the `OR` keyword

## Ordering

The `OrderBy` class is used for building ordering clauses.

## Searching

The  `ReturnClause` class is used to represent the `RETURNING...` phrase in a SOSL query.

# References

https://developer.salesforce.com/docs/atlas.en-us.soql_sosl.meta/soql_sosl/sforce_api_calls_sosl_syntax.htm