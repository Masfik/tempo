bool fromSqlBool(value) {
  if (value is bool) return value;
  return value == 1 ? true : false;
}

int toSqlBool(bool value) => value ? 1 : 0;