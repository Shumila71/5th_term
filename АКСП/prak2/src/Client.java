import java.rmi.Naming;

public class Client {
    public static void main(String[] args) {
        try {
            IQuadraticSolver solver = (IQuadraticSolver) Naming.lookup("rmi://localhost/QuadraticSolver");

            double a = 2;
            double b = -9;
            double c = 400;

            Roots roots = solver.solve(a, b, c);

            if (roots.hasRealRoots()) {
                System.out.println("Корни уравнения:");
                System.out.println("x1 = " + roots.getRoot1());
                System.out.println("x2 = " + roots.getRoot2());
            } else {
                System.out.println("Уравнение не имеет действительных корней.");
            }

        } catch (Exception e) {
            System.err.println("Ошибка: " + e);
            e.printStackTrace();
        }
    }
}