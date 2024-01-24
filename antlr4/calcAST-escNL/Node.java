public class Node {
	String OpCode;
	Integer ival;
	Float fval;

	Node left;
	Node right;
	
	public Node(String _OpCode, Node _left, Node _right) {
		OpCode=_OpCode;
		left=_left;
		right=_right;
	}
}
