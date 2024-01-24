public class Node {
	String OpCode;
	int ival;
	float fval;

	Node left;
	Node right;
	
	public Node(String _OpCode, Node _left, Node _right) {
		OpCode=_OpCode;
		left=_left;
		right=_right;
	}
}
