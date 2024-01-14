
typedef struct Node Node;

struct Node {
	int OpCode;
	int ival;
	float fval;

	Node * left;
	Node * right;
};


