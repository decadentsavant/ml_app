// ignore_for_file: cascade_invocations, parameter_assignments, prefer_is_empty,
// ignore_for_file: require_trailing_commas

RegExp _ipv4Maybe =
    RegExp(r'^(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)\.(\d?\d?\d)$');
RegExp _ipv6 =
    RegExp(r'^::|^::1|^([a-fA-F0-9]{1,4}::?){1,7}([a-fA-F0-9]{1,4})$');
/// check if the string [str] is IP [version] 4 or 6
///
/// * [version] is a String or an `int`.
bool isIP(String str, [/*<String | int>*/dynamic version]) {
  version = version.toString();
  if (version == 'null') {
    return isIP(str, 4) || isIP(str, 6);
  } else if (version == '4') {
    if (!_ipv4Maybe.hasMatch(str)) {
      return false;
    }
    final parts = str.split('.');
    parts.sort((a, b) => int.parse(a) - int.parse(b));
    return int.parse(parts[3]) <= 255;
  }
  return version == '6' && _ipv6.hasMatch(str);
}

/// check if the string [str] is a fully qualified domain name 
/// (e.g. domain.com).
///
/// * [requireTld] sets if TLD is required
/// * allowUnderscore sets if underscores are allowed
bool isFQDN(String str,
    {bool requireTld = true, bool allowUnderscores = false}) {
  final parts = str.split('.');
  if (requireTld) {
    final tld = parts.removeLast();
    if (parts.length == 0 || !RegExp(r'^[a-z]{2,}$').hasMatch(tld)) {
      return false;
    }
  }

  for (final part in parts) {
    if (allowUnderscores) {
      if (part.contains('__')) {
        return false;
      }
    }
    if (!RegExp(r'^[a-z\\u00a1-\\uffff0-9-]+$').hasMatch(part)) {
      return false;
    }
    if (part[0] == '-' ||
        part[part.length - 1] == '-' ||
        part.contains('---')) {
      return false;
    }
  }
  return true;
}

// check if the string [str] is a URL
///
/// * [protocols] sets the list of allowed protocols
/// * [requireTld] sets if TLD is required
/// * [requireProtocol] is a `bool` that sets if protocol is required for 
/// validation
/// * [allowUnderscore] sets if underscores are allowed
/// * [hostWhitelist] sets the list of allowed hosts
/// * [hostBlacklist] sets the list of disallowed hosts
///

bool isValidURL(String str,
    {List<String> protocols = const ['http', 'https', 'ftp'],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const []}) {
  if (str.length == 0) {
    return true;
  }
  if (/*str.length == 0 ||*/
      str.length > 2083 ||
      str.startsWith('mailto:')) {
    return false;
  }

  final String protocol;
  String user;
  String auth;
  List<String> auth2;
  String host;
  String hostname;
  int port;
  String portStr;
  String path;
  String query;
  String hash;
  List<String> split;

  // check protocol
  split = str.split('://');
  if (split.length > 1) {
    protocol = shift(split);
    if (!protocols.contains(protocol)) {
      return false;
    }
  } else if (requireProtocol == true) {
    return false;
  }
  str = split.join('://');

  // check hash
  split = str.split('#');
  str = shift(split);
  hash = split.join('#');
  if (hash != '' && RegExp(r'\s').hasMatch(hash)) {
    return false;
  }

  // check query params
  split = str.split('?');
  str = shift(split);
  query = split.join('?');
  if (query != '' && RegExp(r'\s').hasMatch(query)) {
    return false;
  }

  // check path
  split = str.split('/');
  str = shift(split);
  path = split.join('/');
  if (path != '' && RegExp(r'\s').hasMatch(path)) {
    return false;
  }

  // check auth type urls
  split = str.split('@');
  if (split.length > 1) {
    auth = shift(split);
    if (auth.contains(':')) {
      auth2 = auth.split(':');
      user = shift(auth2);
      if (!RegExp(r'^\S+$').hasMatch(user)) {
        return false;
      }
      if (!RegExp(r'^\S*$').hasMatch(user)) {
        return false;
      }
    }
  }

  // check hostname
  hostname = split.join('@');
  split = hostname.split(':');
  host = shift(split);
  if (split.length > 0) {
    portStr = split.join(':');
    try {
      port = int.parse(portStr, radix: 10);
    } catch (e) {
      return false;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(portStr) ||
        port <= 0 ||
        port > 65535) {
      return false;
    }
  }

  if (!isIP(host) &&
      !isFQDN(host,
          requireTld: requireTld, allowUnderscores: allowUnderscore,) &&
      host != 'localhost') {
    return false;
  }

  if (hostWhitelist.isNotEmpty && !hostWhitelist.contains(host)) {
    return false;
  }

  if (hostBlacklist.isNotEmpty && hostBlacklist.contains(host)) {
    return false;
  }

  return true;
}

// Helper functions for validator

String shift(List l) {
  if (l.length >= 1) {
    final first = l.first as String;
    l.removeAt(0);
    return first;
  }
  return '';
}

Map merge(Map obj, Map<String, String> defaults) {
  defaults.forEach((key, val) => obj.putIfAbsent(key, () => val));
  return obj;
}
