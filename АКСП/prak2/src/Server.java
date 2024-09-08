import java.rmi.Naming;
import java.rmi.registry.LocateRegistry;

public class Server {
    public static void main(String[] args) {
        try {
            LocateRegistry.createRegistry(1099);

            IQuadraticSolver solver = new QuadraticSolver();

            Naming.rebind("rmi://localhost/QuadraticSolver", solver);

            System.out.println("Сервер готов.");
        } catch (Exception e) {
            System.err.println("Ошибка на сервере: " + e);
            e.printStackTrace();
        }
    }
}
