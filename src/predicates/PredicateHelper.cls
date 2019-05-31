public with sharing class PredicateHelper {
  public static String ToSoqlQueryString(String s) {
    return '\'' + String.escapeSingleQuotes(s) + '\'';
  }
  public static String ToSoqlQueryString(Date d) {
    return DateTime.newInstance(d.year(), d.month(), d.day()).format('yyyy-MM-dd');
  }
  public static String ToSoqlQueryString(List<Date> ds) {
    List<String> s = new List<String>();
    for (Date d : ds) {
      s.Add(PredicateHelper.ToSoqlQueryString(d));
    }

    return String.join(s, ',');
  }
  public static String ToSoqlQueryString(DateTime d) {
    return d.formatGMT('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ');
  }
  public static String ToSoqlQueryString(List<DateTime> ds) {
    List<String> s = new List<String>();
    for (DateTime d : ds) {
      s.Add(PredicateHelper.ToSoqlQueryString(d));
    }

    return String.join(s, ',');
  }
  public static String ToSoqlQueryString(Integer i) {
    return String.valueOf(i);
  }
  public static String ToSoqlQueryString(List<Integer> ints) {
    List<String> s = new List<String>();
    for (Integer i : ints) {
      s.Add(PredicateHelper.ToSoqlQueryString(i));
    }

    return String.join(s, ',');
  }
  public static String ToSoqlQueryString(Long l) {
    return String.valueOf(l);
  }
  public static String ToSoqlQueryString(List<Long> ls) {
    List<String> s = new List<String>();
    for (Long l : ls) {
      s.Add(PredicateHelper.ToSoqlQueryString(l));
    }

    return String.join(s, ',');
  }
  public static String ToSoqlQueryString(Decimal d) {
    return String.valueOf(d);
  }
  public static String ToSoqlQueryString(List<Decimal> ds) {
    List<String> s = new List<String>();
    for (Decimal d : ds) {
      s.Add(PredicateHelper.ToSoqlQueryString(d));
    }

    return String.join(s, ',');
  }
  public static String ToSoqlQueryString(Double d) {
    return String.valueOf(d);
  }
  public static String ToSoqlQueryString(List<Double> ds) {
    List<String> s = new List<String>();
    for (Double d : ds) {
      s.Add(PredicateHelper.ToSoqlQueryString(d));
    }

    return String.join(s, ',');
  }
  public static String ToSoqlQueryString(String[] ss) {
    List<String> escaped = new List<String>();
    for (String s : ss) {
      escaped.add(PredicateHelper.ToSoqlQueryString(s));
    } 
   
    return String.join(escaped, ',');
  }
}
