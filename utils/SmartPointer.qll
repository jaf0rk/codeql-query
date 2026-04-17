import cpp

predicate isSmartPointerType(Type t) {
  exists(ClassTemplateInstantiation cti | 
    t = cti |
    cti.getSimpleName().matches("unique_ptr") 
    or
    cti.getSimpleName().matches("shared_ptr")
  )
}

Type getSmartPointerElementType(
    Type smartPtrType) {
  exists(ClassTemplateInstantiation cti | 
    smartPtrType = cti 
    and
    result = cti.getTemplateArgument(0)
  )
}
