
typedef struct Node Node;

struct Node {
	char* OpCode;
	int ival;
	float fval;

	Node * left;
	Node * right;
};


