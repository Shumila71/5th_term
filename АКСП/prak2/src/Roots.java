import java.io.Serializable;

public class Roots implements Serializable {
    private final double root1;
    private final double root2;
    private final boolean hasRealRoots;

    public Roots(double root1, double root2, boolean hasRealRoots) {
        this.root1 = root1;
        this.root2 = root2;
        this.hasRealRoots = hasRealRoots;
    }

    public double getRoot1() {
        return root1;
    }

    public double getRoot2() {
        return root2;
    }

    public boolean hasRealRoots() {
        return hasRealRoots;
    }
}