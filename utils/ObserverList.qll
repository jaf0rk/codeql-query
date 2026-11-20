import cpp

class UncheckedObserverAdapter 
extends ClassTemplateInstantiation {
    UncheckedObserverAdapter() {
        this.getSimpleName() = "UncheckedObserverAdapter"
        and
        this.getNamespace()
        .getQualifiedName() = "base::internal"
    }
}

class CheckedObserverAdapter 
extends Class {
    CheckedObserverAdapter() {
        this.getSimpleName() = "CheckedObserverAdapter"
        and
        this.getNamespace()
        .getQualifiedName() = "base::internal"
    }
}

class ObserverList 
extends ClassTemplateInstantiation {
    ObserverList() {
        this.getSimpleName() = "ObserverList"
        and
        this.getNamespace().getName() = "base"
    }
}

class Unchecked
extends ClassTemplateInstantiation {
    Unchecked() {
        exists(UncheckedObserverAdapter uoa |
            this.getSimpleName() = "ObserverList"
            and
            this.getNamespace().getName() = "base"
            and
            uoa.getTemplateArgument(0)
            .(Expr).getValue() = "0"
            and
            uoa.getTemplateArgument(1)
            .(Expr).getValue() = "0"
            and
            this.getTemplateArgument(3)
            .(ClassTemplateInstantiation) = uoa
        )
    }
}

class UncheckedAndDanglingUntriaged 
extends ClassTemplateInstantiation {
    UncheckedAndDanglingUntriaged() {
        exists(UncheckedObserverAdapter uoa |
            this.getSimpleName() = "ObserverList"
            and
            this.getNamespace().getName() = "base"
            and
            uoa.getTemplateArgument(0)
            .(Expr).getValue() = "1"
            and
            uoa.getTemplateArgument(1)
            .(Expr).getValue() = "0"
            and
            this.getTemplateArgument(3)
            .(ClassTemplateInstantiation) = uoa
        )
    }
}

class UncheckedAndRawPtrExcluded 
extends ClassTemplateInstantiation {
    UncheckedAndRawPtrExcluded() {
        exists(UncheckedObserverAdapter uoa |
            this.getSimpleName() = "ObserverList"
            and
            this.getNamespace().getName() = "base"
            and
            uoa.getTemplateArgument(0)
            .(Expr).getValue() = "0"
            and
            uoa.getTemplateArgument(1)
            .(Expr).getValue() = "1"
            and
            this.getTemplateArgument(3)
            .(ClassTemplateInstantiation) = uoa
        )
    }
}

class CheckedObserverList 
extends ClassTemplateInstantiation {
    CheckedObserverList() {
        this.getSimpleName() = "ObserverList"
        and
        this.getNamespace().getName() = "base"
        and
        this.getTemplateArgument(3)
        .(Class) instanceof CheckedObserverAdapter
    }
}


class CheckedObserver
extends Class {
    CheckedObserver() {
        this.getName() = "CheckedObserver"
        and
        this.getNamespace().getName() = "base"
    }
}

class UncheckedObserver
extends Class {
    UncheckedObserver() {
        exists(ClassTemplateInstantiation li | 
            (
                li instanceof Unchecked
                or
                li instanceof UncheckedAndDanglingUntriaged
                or
                li instanceof UncheckedAndRawPtrExcluded
            )
            and
            not this.stripType()
            .(Class)
            .getABaseClass*() instanceof CheckedObserver
            and
            this = li.(ClassTemplateInstantiation)
            .getTemplateArgument(0)
            .(Type)
            .stripType()
            .(Class)
        )
    }
}

class Observer 
extends Class {
    Observer() {
        this instanceof CheckedObserver
        or
        this instanceof UncheckedObserver
    }
}

class ObserverListNotify
extends Function {
    ObserverListNotify(){
        this.getName() = "Notify"
        and
        this.getDeclaringType()
        .(ClassTemplateInstantiation) instanceof ObserverList
    }
}

class ObserverListNotifyCall
extends FunctionCall {
    ObserverListNotifyCall() {
        this.getTarget() instanceof ObserverListNotify
    }
}

class ObserverListAddObserver
extends Function {
    ObserverListAddObserver(){
        this.getName() = "AddObserver"
        and
        this.getDeclaringType()
        .(ClassTemplateInstantiation) instanceof ObserverList
    }
}

class ObserverListAddObserverCall
extends FunctionCall {
    ObserverListAddObserverCall() {
        this.getTarget() instanceof ObserverListAddObserver
    }
}

class ObserverListRemoveObserver
extends Function {
    ObserverListRemoveObserver(){
        this.getName() = "RemoveObserver"
        and
        this.getDeclaringType()
        .(ClassTemplateInstantiation) instanceof ObserverList
    }
}

class ObserverListRemoveObserverCall
extends FunctionCall {
    ObserverListRemoveObserverCall() {
        this.getTarget() instanceof ObserverListRemoveObserver
    }
}

class ObserverListClear
extends Function {
    ObserverListClear(){
        this.getName() = "Clear"
        and
        this.getDeclaringType()
        .(ClassTemplateInstantiation) instanceof ObserverList
    }
}

class ObserverListClearCall
extends FunctionCall {
    ObserverListClearCall() {
        this.getTarget() instanceof ObserverListClear
    }
}