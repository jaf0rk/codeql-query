import cpp

class Unretained
extends Function {
    Unretained(){
        this.hasQualifiedName(
            "base", "Unretained")
    }
}

class UnretainedCall
extends FunctionCall {
    UnretainedCall(){
        this.getTarget() 
        instanceof 
        Unretained
    }
}

class UnsafeDangling 
extends Function{
    UnsafeDangling(){
        this.hasQualifiedName(
            "base", "UnsafeDangling")
    }
}

class UnsafeDanglingCall
extends FunctionCall {
    UnsafeDanglingCall(){
        this.getTarget() 
        instanceof 
        UnsafeDangling
    }
}

class UnsafeDanglingUntriaged
extends Function{
    UnsafeDanglingUntriaged(){
        this.hasQualifiedName(
            "base", "UnsafeDanglingUntriaged")
    }
}

class UnsafeDanglingUntriagedCall
extends FunctionCall{
    UnsafeDanglingUntriagedCall(){
        this.getTarget() 
        instanceof 
        UnsafeDanglingUntriaged
    }
}

class RetainedRef extends Function {
    RetainedRef(){
        this.hasQualifiedName(
            "base", "RetainedRef")
    }
}

class RetainedRefCall
extends FunctionCall{
    RetainedRefCall(){
        this.getTarget() 
        instanceof 
        RetainedRef
    }
}

class Owned extends Function {
    Owned(){
        this.hasQualifiedName(
            "base", "Owned")
    }
}

class OwnedCall extends FunctionCall {
    OwnedCall(){
        this.getTarget() 
        instanceof 
        Owned
    }
}

class OwnedRef extends Function {
    OwnedRef(){
        this.hasQualifiedName(
            "base", "OwnedRef")
    }
}

class OwnedRefCall extends FunctionCall {
    OwnedRefCall(){
        this.getTarget() 
        instanceof 
        OwnedRef
    }
}