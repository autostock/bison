import java.util.HashMap;

public class CalcBaseVisitorImpl extends CalcBaseVisitor<Double> {
	@Override 
	public Double visitInput(CalcParser.InputContext ctx) { 
		return visitChildren(ctx); 
	}
	
	@Override 
	public Double visitLine(CalcParser.LineContext ctx) { 
		if (ctx.expression()!=null) {
			Double result=visit(ctx.expression()); 
	        System.out.println("Result: " + result);
	    }
		return null; 
	}
	
	@Override 
	public Double visitExpression(CalcParser.ExpressionContext ctx) { 
		if (ctx.Number()!=null) {
	    	System.out.println(indent(ctx.depth())+ctx.Number());
			return Double.parseDouble(ctx.Number().getText());
		} else if (ctx.T_MULTIPLY()!=null) {
	    	System.out.println(indent(ctx.depth())+ctx.T_MULTIPLY());
			return visit(ctx.expression(0)) * visit(ctx.expression(1)); 
		} else if (ctx.T_DIVIDE()!=null) {
	    	System.out.println(indent(ctx.depth())+ctx.T_DIVIDE());
			return visit(ctx.expression(0)) / visit(ctx.expression(1)); 
		} else if (ctx.T_PLUS()!=null) {
	    	System.out.println(indent(ctx.depth())+ctx.T_PLUS());
			return visit(ctx.expression(0)) + visit(ctx.expression(1)); 
		} else if (ctx.T_MINUS()!=null) {
	    	System.out.println(indent(ctx.depth())+ctx.T_MINUS());
			return visit(ctx.expression(0)) - visit(ctx.expression(1)); 
		} else if (ctx.T_LEFT()!=null) {
	    	System.out.println(indent(ctx.depth())+ctx.T_LEFT()+ctx.T_RIGHT());
		}
		return visit(ctx.expression(0)); 
	}
	
	private String indent(int len) { 
		String indent="";
		for (int i=0; i<4*len; i++) {
			indent+=" ";
		}
		return indent; 
	}
}
