package prac1;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;
public class Main {
    static final ReentrantLock lock = new ReentrantLock();
    static final Condition pingCondition = lock.newCondition();
    static final Condition pongCondition = lock.newCondition();
    static boolean pingTurn = true; // флаг
    public static void main(String[] args) {

        Thread pingThread = new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                lock.lock();
                try {
                    while (!pingTurn) {
                        pingCondition.await();
                    }
                    System.out.print("Ping ");
                    pingTurn = false;
                    pongCondition.signal();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                } finally {
                    lock.unlock();
                }
            }
        });

        Thread pongThread = new Thread(() -> {
            for (int i = 0; i < 10; i++) {
                lock.lock();
                try {
                    while (pingTurn) {
                        pongCondition.await();
                    }
                    System.out.print("Pong ");
                    pingTurn = true;
                    pingCondition.signal();
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                } finally {
                    lock.unlock();
                }
            }
        });

        pingThread.start();
        pongThread.start();
    }
}

