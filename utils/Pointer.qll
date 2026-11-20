import cpp


class SmartPointerType 
extends ClassTemplateInstantiation {
  SmartPointerType() {
    this instanceof UniquePtr
    or
    this instanceof SharedPtr
    or
    this instanceof ScopedRefptr
    or
    this instanceof WeakPtr
  }
}

class UniquePtr
extends ClassTemplateInstantiation {
  UniquePtr() {
    (
      this.getNamespace()
      .getQualifiedName()
      .matches("std%")
      or
      this.getNamespace()
      .getQualifiedName()
      .matches("base%")
    )
    and
    this.getSimpleName() = "unique_ptr"
  }
}


class SharedPtr
extends ClassTemplateInstantiation {
  SharedPtr() {
    (
      this.getNamespace()
      .getQualifiedName()
      .matches("std%")
      or
      this.getNamespace()
      .getQualifiedName()
      .matches("base%")
    )
    and
    this.getSimpleName() = "shared_ptr"
  }
}

class ScopedRefptr
extends ClassTemplateInstantiation {
  ScopedRefptr() {
    (
      this.getNamespace()
      .getQualifiedName()
      .matches("std%")
      or
      this.getNamespace()
      .getQualifiedName()
      .matches("base%")
    )
    and
    this.getSimpleName() = "scoped_refptr"
  }
}


class WeakPtr
extends ClassTemplateInstantiation {
  WeakPtr() {
    this.getNamespace().getQualifiedName() = "base"
    and
    this.getSimpleName() = "WeakPtr"
  }
}

Type getSmartPointerElementType(
    SmartPointerType smartPtrType) {
  result = smartPtrType.getTemplateArgument(0)
}


