import cpp


from Class c, Function f, SwitchStmt ss, string name, Enum e
where
  // 第一个查询条件：switch 无 default 分支，获取其表达式类型名
  count(ss.getDefaultCase()) = 0 and
  f = ss.getEnclosingFunction() and
  e = ss.getExpr().getType() and
  count(EnumConstant ec | ec.getDeclaringEnum() = e ) > 3 and
  name = e.toString() and
  // 第二个查询条件：c 在指定文件中，且有静态成员 kIsExtensible 初始化为 "true"，
  // 并且类名等于类型名 + "_Data"
  c.getName() = name + "_Data" and
  c.getFile().getBaseName().matches("%mojom-shared-internal.h") and
  exists(MemberVariable mv |
    mv = c.getAStaticMember() and
    mv.getName() = "kIsExtensible" and
    mv.getInitializer().getExpr().getValueText() = "true"
  )
select f, c, e