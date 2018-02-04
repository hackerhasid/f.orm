public with sharing class PredicateHelper {
  public static String ToSoqlQueryString(String s) {
    return '\'' + String.escapeSingleQuotes(s) + '\'';
  }
  public static String ToSoqlQueryString(Date d) {
    return '\'' + DateTime.newInstance(d.year(), d.month(), d.day()).format('YYYY-MM-DD') + '\'';
  }
  public static String ToSoqlQueryString(DateTime d) {
    return '\'' + d.formatGMT('YYYY-MM-DDThh:mm:ssZ') + '\'';
  }
  public static String ToSoqlQueryString(Integer i) {
    return String.valueOf(i);
  }
  public static String ToSoqlQueryString(Long l) {
    return String.valueOf(l);
  }
  public static String ToSoqlQueryString(Decimal d) {
    return String.valueOf(d);
  }
  public static String ToSoqlQueryString(Double d) {
    return String.valueOf(d);
  }
  public static String ToSoqlQueryString(String[] ss) {
    List<String> escaped = new List<String>();
    for (String s : ss) {
      escaped.add(PredicateHelper.ToSoqlQueryString(s));
    } 
   
    return '(' + String.join(escaped, ',') + ')';
  }
}
