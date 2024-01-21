import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.tree.*;

public class Run {
    public static void main(String[] args) throws Exception {
        CharStream input = CharStreams.fromStream(System.in);
        CalcLexer lexer = new CalcLexer(input);
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        CalcParser parser = new CalcParser(tokens);
        ParseTree tree = parser.input();

        CalcBaseVisitorImpl calcVisitor = new CalcBaseVisitorImpl();
        calcVisitor.visit(tree);
    }
}
