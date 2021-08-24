import java.util.Scanner;

/**
 * Diese Klasse wird verwendet um von der Kommandozeile einzulesen
 *
 * @author Leon Lopetrone
 * @version 1.0
 * @since 05.05.2020
 */

public class Einleser {

    static Scanner scanner;

    /**
     * Konstruktor für den Einleser, hier wird der Scanner erstellt und mit System.in verknüpft
     */
    public Einleser() {
        scanner = new Scanner(System.in);
    }

    /**
     * Liest den ersten Buchstabe auf der Kommandozeile ein.
     * Falls kein Buchstabe (a-Z) vorhanden wird eine Fehlermeldung ausgegeben und eine erneute Einlesung findet statt.
     * Ist die Eingabe leer, wird eine Fehlermeldung ausgegeben und die Einlesung erneut gestartet.
     *
     * @return erster Buchstabe der Eingabe im System.in
     */
    public char readChar() {
        drawLine();
        System.out.print("> ");
        String input = scanner.nextLine();
        if(!input.isEmpty()){
            char ch = input.charAt(0);
            while (!Character.isLetter(ch)) {
                drawLine();
                System.out.println("Bitte einen Buchstaben eingeben!");
                drawLine();
                System.out.print("> ");
                ch = scanner.nextLine().charAt(0);
            }
            drawLine();
            return ch;
        }else{
            drawLine();
            System.out.println("Leere Eingabe nicht zulässig, bitte geben Sie etwas ein.");
            return readChar();
        }


    }

    /**
     * Checkt ob sich ein Integer im Scanner befindet, falls ja, liest er den Int ein und gibt ihn zurück.
     * Falls kein Int eingegeben wird, wird eine Fehlermeldung ausgegeben und nochmals eingelesen.
     *
     * @return Int welcher in System.in eingegeben wurde.
     */
    public int readInt() {
        drawLine();
        System.out.print("> ");
        while (!scanner.hasNextInt()) {
            scanner.next();
            System.out.println("Bitte eine Ganzzahl eingeben!");
            drawLine();
            System.out.print("> ");
        }
        int zahl = scanner.nextInt();
        scanner.nextLine();  // Scanner leeren, damit er für die nächste Operation frei ist.
        drawLine();
        return zahl;
    }

    /**
     * Liest einen String von System.in ein.
     *
     * @return String von System.in
     */
    public String readString() {
        drawLine();
        System.out.print("> ");
        String text = scanner.nextLine();
        drawLine();
        return text;
    }

    /**
     * Zeichnet eine Linie aus Strichen für die schöne grafische Darstellung.
     */
    public void drawLine() {
        System.out.println("-----------------------------------------------------------------------------------------");
    }

}
