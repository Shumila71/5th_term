import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class QuadraticSolver extends UnicastRemoteObject implements IQuadraticSolver {

    protected QuadraticSolver() throws RemoteException {
        super();
    }

    @Override
    public Roots solve(double a, double b, double c) throws RemoteException {
        double discriminant = b * b - 4 * a * c;
        boolean hasRealRoots = discriminant >= 0;

        double root1 = 0;
        double root2 = 0;

        if (hasRealRoots) {
            root1 = (-b + Math.sqrt(discriminant)) / (2 * a);
            root2 = (-b - Math.sqrt(discriminant)) / (2 * a);
        }

        return new Roots(root1, root2, hasRealRoots);
    }
}