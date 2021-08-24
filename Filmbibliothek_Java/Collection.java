/**
 * Hier ist die Lite der Kategorien gechpeichert
 *
 * @author Kevin Maurizi
 * @version 0.9
 * @since 06.04.2020
 */
public class Collection {


    private Kategorie[] kategorien;
    private int anzKategorien;
    private final int MAX_KATEGORIEN = 100;
    public Collection() {
        kategorien = new Kategorie[MAX_KATEGORIEN]; // Die Maximale anzahl Kategorien ist 100 Stück
        anzKategorien = 0;                // beim Erstellen einer neuen Sammlung gibt es noch keine Kategorien, also 0;
    }

    /**
     * Methode um eine Kategorie hinzuzufügen.
     *
     * @param kategorie eine Kategorie das zur Liste hinzugefügt werden soll.
     */
    public void addKategorie(Kategorie kategorie) {
        kategorien[anzKategorien] = kategorie;
        anzKategorien++;
    }

    /**
     * Methode um eine Kategorie zu löschen.
     *
     * @param number Nummer der Kategorie das gelöscht werden soll.
     */
    public void removeKategorie(int number) {
        // IF: Fehlerbehandlung, wenn zu löschende Nummer zu gross oder zu klein;
        // ELSE: Löschen der Kategorie aus dem Array
        if (number > anzKategorien || number < 0) {
            System.out.println("Wert nicht gültig, bitte erneut eingeben.");
        } else {
            // BEGIN: Code für das löschen eines Eintrages aus einem Array
            Kategorie[] kategorienCopy = new Kategorie[MAX_KATEGORIEN];
            int anzKategorienCopy = 0;
            for (int i = 0; i < anzKategorien; i++) {
                if (i != number) {
                    kategorienCopy[anzKategorienCopy] = kategorien[i];
                    anzKategorienCopy++;
                }
            }
            kategorien = kategorienCopy;
            anzKategorien = anzKategorienCopy;
            // ENDE: Code für das löschen eines Eintrages aus einem Array
        }
    }

    /**
     * Methode um alle Kategorien auszugeben mit dem Format:
     * "Nummer"     Name
     */
    public void showKategorien() {
        for (int i = 0; i < anzKategorien; i++) {
            System.out.println("«" + i + "»\t" + kategorien[i].getName());
        }
    }

    /**
     * Methode um die gewünschte Kategorie zurück zu geben.
     *
     * @param number welche Kategorie möchte soll zurückgegeben werden.
     * @return gibt die Kategorie mit der number zurück.
     */
    public Kategorie getKategorie(int number) {
        // IF: Fehlerbehandlung, wenn zu löschende Nummer zu gross oder zu klein;
        // ELSE: rückgabe der Kategorie
        if (number > anzKategorien || number < 0) {
            System.out.println("Wert nicht gültig, bitte erneut eingeben.");
            return null;
        } else {
            return kategorien[number];
        }
    }
}