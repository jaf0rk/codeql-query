import cpp
import ReverseTrackerSig


module ReverseDataFlow<ReverseDataFlowSig Config> {
    /**
     * Default function arguments edge parse
     * 
     * @node1: from 
     * @node2: to
     */
    private predicate parseArgumentEdge(
        DataFlow::Node node1, DataFlow::Node node2) {
        exists(Parameter p, 
            FunctionCall fc | 
            node2.asParameter() = p
            and
            node1.asExpr() = fc.getArgument(p.getIndex())
            and
            fc.getTarget() = p.getFunction())
    }

    /**
     * Default function return value edge parse
     * 
     * @node1: from 
     * @node2: to
     */
    private predicate parseReturnEdge(
        DataFlow::Node node1, DataFlow::Node node2) {
        exists(ReturnStmt ret, 
            FunctionCall fc | 
            node1.asExpr() = ret.getExpr()
            and
            node2.asExpr() = fc
            and
            ret.getEnclosingFunction() = fc.getTarget())
    }

    /**
     * Default class field edge parse
     * 
     * @node1: from
     * @node2: to
     */
    private predicate parseFieldEdge(
        DataFlow::Node node1, DataFlow::Node node2) {
        exists(FieldAccess fa | 
            node1.asIndirectExpr() = fa.getQualifier()
            and
            node2.asIndirectExpr() = fa)
    }

    private predicate isDefaultFlowStep(
        DataFlow::Node node1, DataFlow::Node node2) {

        parseReturnEdge(node1, node2)
        or
        parseArgumentEdge(node1, node2)
        or
        parseFieldEdge(node1, node2)
    }



    private predicate backward(
        DataFlow::Node source, DataFlow::Node sink, int depth){
        depth in [0 .. 30]
        and 
        source = sink 
        and 
        Config::isSource(source)
        or
        depth > 0
        and
        exists(DataFlow::Node mid |
            reverseStep(mid, sink) and
            backward(source, mid, depth-1)
        )
    }

    /**
     * Reverse data flow
     */
    predicate reverseStep(
        DataFlow::Node node1, DataFlow::Node node2) {
        Config::isAdditionalFlowStep(node2, node1) 
        or 
        isDefaultFlowStep(node2, node1)
    }

    predicate flow(
        DataFlow::Node sink, DataFlow::Node source) {
        Config::isSink(sink)
        and
        backward(source, sink, 30)
    }

    predicate hasFlow(
        DataFlow::Node sink, DataFlow::Node source) {
        flow(sink, source)
    }
}