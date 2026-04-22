import cpp
import semmle.code.cpp.models.interfaces.Iterator
import semmle.code.cpp.dataflow.new.DataFlow

/**
 * Private predicate
 */
private predicate iteratorVariableBinding(
    FunctionCall fc, Variable v) {
    isIteratorGetterFunction(fc.getTarget())
    and
    (
        exists(AssignExpr ae |
        ae.getRValue() = fc
        and
        ae.getLValue() = v.getAnAccess()
        )
        or
        exists(Initializer i |
        i.getExpr() = fc
        and
        i.getDeclaration() = v
        )
    )
    and
    fc.getQualifier()
        .getType()
        .getUnderlyingType() instanceof ContainerType
}

private predicate matchStlContainer(
    string name, ClassTemplateInstantiation ct) {
    
        exists(ClassTemplateInstantiation c | 
            c.getSimpleName() = name
            and
            c.getNamespace()
            .getQualifiedName()
            .matches("std%")
            and
            ct = c)
}

private predicate matchChromiumContainer(
    string name, ClassTemplateInstantiation ct) {
    exists(ClassTemplateInstantiation c | 
        c.getSimpleName() = name
        and
        c.getNamespace()
        .getQualifiedName()
        .matches("base%")
        and
        c = ct)
}

// 判断是否是容器插入操作
predicate isInsertFunction(Function f) {
  f.getDeclaringType() 
  instanceof 
  ContainerType
  and
  f.getName() in ["push_back", "emplace_back", 
  "insert", "emplace", "assign"]
}

// 判断容器是否不是局部变量
predicate isExternalContainer(Expr c) {
  // 情况1：成员字段（没有创建函数，视为外部）
  exists(FieldAccess fa | fa = c)
  or
  // 情况2：全局变量（没有创建函数，视为外部）
  exists(VariableAccess va |
    va = c and
    va.getTarget() instanceof GlobalVariable
  )
  or
  // 情况3：函数参数（创建函数是调用方，不是当前函数）
  exists(VariableAccess va |
    va = c and
    va.getTarget() instanceof Parameter
  )
}

// 判断容器是否是局部变量
predicate isInternalContainer(Expr c) {
    not isExternalContainer(c)
}

// 判断是否是容器元素获取函数
predicate isDirectAccessFunction(Function f) {
  f.getDeclaringType() 
  instanceof 
  ContainerType 
  and
  f.getName() in ["operator[]", "at", "front", "back"]
}

// 判断是否是迭代器获取函数
predicate isIteratorGetterFunction(Function f) {
    f instanceof IteratorGetterFunction
}

/**
 * Determine whether it is an STL container
 */

private newtype TIteratorGetting = 
MakeIteratorGetting(FunctionCall fc, Variable v) {
    iteratorVariableBinding(fc, v)
}

// 获取任意迭代器获取代码
class IteratorGetting 
extends TIteratorGetting {
    private FunctionCall fc;
    private Variable v;

    IteratorGetting() {
        this = MakeIteratorGetting(fc, v)
    }

    FunctionCall getIteratorGetterCall() { result = fc }

    IteratorGetterFunction getIteratorGetter() { 
        result = fc.getTarget()
    }

    ControlFlowNode getASuccessor() {
        result = fc.getASuccessor()
    }

    ControlFlowNode getATrueSuccessor() {
        result = fc.getATrueSuccessor()
    }

    ControlFlowNode getAFalseSuccessor() {
        result = fc.getAFalseSuccessor()
    }

    File getFile() {
        result = fc.getFile()
    }

    BlockStmt getEnclosingBlock() { 
        result = fc.getEnclosingBlock()
    }

    Declaration getEnclosingDeclaration() {
        result = fc.getEnclosingDeclaration()
    }

    Element getEnclosingElement() {
        result = fc.getEnclosingElement()
    }

    Function getEnclosingFunction() {
        result = fc.getEnclosingFunction()
    }

    Stmt getEnclosingStmt() {
        result = fc.getEnclosingStmt()
    }

    Variable getEnclosingVariable() {
        result = fc.getEnclosingVariable()
    }

    Expr getContainer() { result = fc.getQualifier() }

    Variable getIterator() { result = v }

    string toString() { result = "IteratorGetting" }

    Location getLocation() { result = fc.getLocation() }
}

class EasyFailContainerType 
extends ClassTemplateInstantiation{
    EasyFailContainerType() {
        this instanceof VectorType
        or 
        this instanceof StringType
        or
        this instanceof DequeType
        or
        this instanceof STLArrayType
        or
        this instanceof FlatMapType
        or
        this instanceof FlatSetAlias
    }
}

// 迭代器获取函数
class IteratorGetterFunction 
extends Function {
    IteratorGetterFunction(){
        this.getDeclaringType() 
        instanceof 
        ContainerType
        and
        this.getName() in ["begin", "cbegin", "find", "rbegin"]
    }
}

// 迭代器获取函数调用
class IteratorGetterFunctionCall
extends FunctionCall {
    IteratorGetterFunctionCall(){
        this.getTarget() instanceof IteratorGetterFunction
    }
}

// 所有STL容器类
class STLContainerType 
extends ClassTemplateInstantiation {
    STLContainerType(){
        this instanceof VectorType
        or
        this instanceof ListType
        or
        this instanceof QueueType
        or
        this instanceof MapType
        or
        this instanceof SetType
        or
        this instanceof UnorderedSetType
        or
        this instanceof UnorderedMapType
        or
        this instanceof MultisetType
        or
        this instanceof MultimapType
        or
        this instanceof StringType
        or
        this instanceof DequeType
        or
        this instanceof STLArrayType
    }
}

class StringType 
extends ClassTemplateInstantiation{
    StringType(){
        matchStlContainer("string", this)
    }
}

class DequeType
extends ClassTemplateInstantiation{
    DequeType(){
        matchStlContainer("deque", this)
    }
}

class STLArrayType
extends ClassTemplateInstantiation{
    STLArrayType(){
        matchStlContainer("array", this)
    }
}

class VectorType 
extends ClassTemplateInstantiation{
    VectorType(){
        matchStlContainer("vector", this)
    }
}

class ListType
extends ClassTemplateInstantiation{
    ListType(){
        matchStlContainer("list", this)
    }
}

class QueueType
extends ClassTemplateInstantiation{
    QueueType(){
        matchStlContainer("queue", this)
    }
}

class MapType
extends ClassTemplateInstantiation{
    MapType(){
        matchStlContainer("map", this)
    }
}

class SetType
extends ClassTemplateInstantiation{
    SetType(){
        matchStlContainer("set", this)
    }
}

class UnorderedSetType
extends ClassTemplateInstantiation{
    UnorderedSetType(){
        matchStlContainer("unordered_set", this)
    }
}

class UnorderedMapType
extends ClassTemplateInstantiation{
    UnorderedMapType(){
        matchStlContainer("unordered_map", this)
    }
}

class MultisetType
extends ClassTemplateInstantiation{
    MultisetType(){
        matchStlContainer("multiset", this)
    }
}

class MultimapType
extends ClassTemplateInstantiation{
    MultimapType(){
        matchStlContainer("multimap", this)
    }
}

/**
 * Determine whether it is an chromium container
 */
// 所有Chrome内部定义的容器
class ChromeContainerType
extends ClassTemplateInstantiation {
    ChromeContainerType() {
        this instanceof FlatTreeType
        or
        this instanceof FlatMapType
    }
}

class FlatTreeType
extends ClassTemplateInstantiation {
    FlatTreeType(){
        matchChromiumContainer("flat_tree", this)
    }

    STLContainerType getContainer(){
        result = this.getTemplateArgument(3)
        .(ClassTemplateInstantiation)
        .getUnspecifiedType()
    }
}

class FlatMapType
extends ClassTemplateInstantiation {
    FlatMapType(){
        matchChromiumContainer("flat_map", this)
    }

    STLContainerType getContainer(){
        result = this.getTemplateArgument(3)
        .(ClassTemplateInstantiation)
        .getUnspecifiedType()
    }
}

class FlatSetAlias
extends UsingAliasTypedefType {
    FlatSetAlias(){
        this.getBaseType() instanceof FlatTreeType
        and
        this.getSimpleName() = "flat_set"
    }
    
    STLContainerType getContainer(){
        result = this.getTemplateArgument(2)
        .(ClassTemplateInstantiation)
        .getUnspecifiedType()
    }
}

class ContainerType
extends ClassTemplateInstantiation {
    ContainerType() {
        this instanceof ChromeContainerType
        or 
        this instanceof STLContainerType
    }
}