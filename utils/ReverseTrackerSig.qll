import cpp
import semmle.code.cpp.dataflow.new.DataFlow

signature module ReverseDataFlowSig {
    predicate isAdditionalFlowStep(
        DataFlow::Node node1, DataFlow::Node node2);
    predicate isSink(DataFlow::Node node);
    predicate isSource(DataFlow::Node node);
}
