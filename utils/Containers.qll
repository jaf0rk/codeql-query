import cpp
import semmle.code.cpp.models.interfaces.Iterator
import semmle.code.cpp.dataflow.new.DataFlow

/**
 * Private predicate
 */
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

predicate isInsertFunction(Function f) {
  f.getDeclaringType() 
  instanceof 
  ContainerType
  and
  f.getName() in ["push_back", "emplace_back", 
  "insert", "emplace", "assign"]
}

predicate isDirectAccessFunction(Function f) {
  f.getDeclaringType() 
  instanceof 
  ContainerType 
  and
  f.getName() in ["operator[]", "at", "front", "back"]
}

predicate isIteratorGetterFunction(Function f) {
  f.getDeclaringType() 
  instanceof 
  ContainerType
  and
  f.getName() in ["begin", "cbegin", "find", "rbegin"]
}

/**
 * Determine whether it is an STL container
 */
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