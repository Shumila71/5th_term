import java.rmi.Remote;
import java.rmi.RemoteException;

public interface IQuadraticSolver extends Remote {
    Roots solve(double a, double b, double c) throws RemoteException;
}