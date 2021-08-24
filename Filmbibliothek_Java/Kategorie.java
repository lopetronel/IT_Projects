/**
 * Die Klasse Kategorie beinhaltet eine Liste von Filmen.

 * @author Leon Lopetrone
 * @version 1.0
 * @since 05.05.2020
 */

public class Kategorie {

    private String name;
    private int anzFilme;
    private final int MAX_Filme = 100;
    private Filme[] film;


    /**
     * Konstruktor der Kategorie
     *
     * @param name Name der Kategorie
     */
    public Kategorie(String name) {
        this.name = name;
        film = new Filme[MAX_Filme]; // Die Maximale anzahl Filme ist 100 Stück
        anzFilme = 0;                  // beim Erstellen einer neuen Kategorie gibt es noch keine Filme, also 0;
    }

    /**
     * Methode um einen Film hinzuzufügen.
     *
     * @param filme ein Film der zur Liste hinzugefügt werden soll.
     */
    public void addFilm(Filme filme) {
        film[anzFilme] = filme;
        anzFilme++;
    }

    /**
     * Methode um einen Film zu löschen.
     *
     * @param number Nummer den Film der gelöscht werden soll.
     */
    public void removeFilm(int number) {
        // IF: Fehlerbehandlung, wenn zu löschende Nummer zu gross oder zu klein;
        // ELSE: Löschen des Filmes aus dem Array
        if (number > anzFilme || number < 0) {
            System.out.println("Wert nicht gültig, bitte erneut eingeben.");
        } else {
            Filme[] FilmeCopy = new Filme[MAX_Filme];
            int anzFilmeCopy = 0;
            for (int i = 0; i < anzFilme; i++) {
                if (i != number) {
                    FilmeCopy[anzFilmeCopy] = film[i];
                    anzFilmeCopy++;
                }
            }
            film = FilmeCopy;
            anzFilme = anzFilmeCopy;

        }
    }

    /**
     * Methode um alle Filme auszugeben mit dem Format:
     *
     */
    public void showFilme() {
        if (anzFilme == 0) {
            System.out.println("Es sind keine Zitate erfasst.");
        } else {
            for (int i = 0; i < anzFilme; i++) {
                System.out.println("«" + i + "»\t" + film[i].getText());
            }
        }
    }

    /**
     * Getter für das Attribut name
     *
     * @return den Namen der Kategorie
     */
    public String getName() {
        return name;
    }

    /**
     * Setter für das Attribut "name"
     *
     * @param name der Kategorie
     */
    public void setName(String name) {
        this.name = name;
    }
}
