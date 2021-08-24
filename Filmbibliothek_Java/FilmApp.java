/**
 * Die Klasse FilmApp verwaltet die Sammlung von Filmen.
 * Und verwaltet die Kommunikation mit dem User.
 * Die Klasse FilmApp verwendet auch die Klasse Einleser.java, welche die Eingaben auf der Konsole verwaltet.
 *
 * @author Leon Lopetrone
 * @version 1.0
 * @since 05.05.2020
 */

public class FilmApp {

    Collection collection;
    Einleser einleser;

    /**
     * Konstruktor für die App
     * Hier werden die globalen Objekte erstellt und die Sammlung wird initial befüllt.
     */
    public FilmApp() {
        collection = new Collection();
        einleser = new Einleser();
        initSammlung();
    }

    /**
     * Main-Methode, die das Programm startet.
     * @param args optionale Übergabeparameter, werden nicht genutzt.
     */
    public static void main(String[] args) {
        FilmApp app = new FilmApp();
        app.run();
    }

    /**
     * Hauptmethode, hier wird der Benutzerdialog gesteuert.
     */
    public void run() {
        Einleser einleser = new Einleser();

        char menueAuswahl = ' ';

        pruefePassWort("Ichbinschlau789");

        while (menueAuswahl != 'x') {
            begruessen();
            menueAuswahl = einleser.readChar();
            if (menueAuswahl == 'a') {
                auswahlAnzeigen();
            } else if (menueAuswahl == 'e') {
                auswahlZitatErstellen();
            } else if (menueAuswahl == 'k') {
                auswahlKategorieErstellen();
            } else if (menueAuswahl == 'l') {
                auswahlLoeschen();
            } else {
                System.out.println("Geben Sie einen gültigen Buchstaben an, bitte erneut eingeben:");
            }

            einleser.drawLine();
            System.out.println("Drücken Sie «h» um zum Hauptmenue zurück zu gelangen.");
            System.out.println("Drücken Sie «x» um das Programm zu beenden.");
            menueAuswahl = einleser.readChar();
        }
        System.out.println("Vielen Dank für Ihren Beitag und bis bald!");
        einleser.drawLine();
    }

    /**
     * Beinhaltet die Logik für das Anzeigen der Filme
     */
    private void auswahlAnzeigen() {
        System.out.println("Welche Kategorie von Filmen möchten Sie anzeigen,\n" +
                "selektieren Sie die Kategorie mittels Auswahl der Zahl:");

        collection.showKategorien();
        Kategorie kategorie = collection.getKategorie(einleser.readInt());

        System.out.println("Sie haben die Kategorie " + kategorie.getName() + " gewählt, \n" +
                "jetzt sehen Sie alle Filme dieser Kategorie");

        einleser.drawLine();
        kategorie.showFilme();
    }

    /**
     * Beinhaltet die Logik für das Erstellen von Kategorien
     */
    private void auswahlKategorieErstellen() {
        System.out.println("Welche Kategorie möchten Sie neu erfassen?");

        String name = einleser.readString();
        Kategorie newKategorie = new Kategorie(name);

        collection.addKategorie(newKategorie);

        System.out.println("Sie haben die Kategorie " + newKategorie.getName() + " neu erfasst.");
    }

    /**
     * Beinhaltet die Logik für das Erstellen von Filmen + Regiseur/Author
     */
    private void auswahlZitatErstellen() {
        System.out.println("Für welche Kategorie von Filmen möchten Sie einen neuen Film erfassen?\n" +
                "Selektieren Sie die Kategorie mittels Auswahl der Zahl:");

        collection.showKategorien();
        Kategorie kategorie = collection.getKategorie(einleser.readInt());

        System.out.println("Sie haben die Kategorie " + kategorie.getName() + " gewählt, \n" +
                "geben Sie nun einen neuen Film inklusive Author/Regiseur ein:");

        String text = einleser.readString();
        kategorie.addFilm(new Filme(text));

        System.out.println("Der Film wurde gespeichert.");
    }

    /**
     * Beinhaltet die Logik für das Löschen von Kategorien und Filmen.
     */
    private void auswahlLoeschen() {
        System.out.println("Was möchten Sie löschen, wählen Sie:\n" +
                "«k»\tfür Kategorie\n" +
                "«f»\tfür Filme");

        char eingabeLoeschen = einleser.readChar();

        if (eingabeLoeschen == 'k') {

            System.out.println("Welche Kategorie möchten Sie löschen?\n" +
                    "Selektieren Sie die Kategorie mittels Auswahl der Zahl:\n");
            collection.showKategorien();
            int zuLoeschen = einleser.readInt();
            System.out.println("Kategorie «" + collection.getKategorie(zuLoeschen).getName() + "» inklusive Filme der Kategorie wurden gelöscht. ");
            collection.removeKategorie(zuLoeschen);

        } else if (eingabeLoeschen == 'z') {
            System.out.println("In welcher Kategorie ist der Film, dass Sie löschen möchten?\n" +
                    "Selektieren Sie die Kategorie mittels Auswahl der Zahl:");
            collection.showKategorien();
            Kategorie kategorie = collection.getKategorie(einleser.readInt());
            System.out.println("Welchen der Filme der Kategorie «" + kategorie.getName() + "» möchten Sie löschen?");
            kategorie.showFilme();
            kategorie.removeFilm(einleser.readInt());
            System.out.println("Der Film wurde gelöscht.");

        } else {
            System.out.println("Befehl nicht erkannt, bitte erneut eingeben:");
        }
    }

    /**
     * Begrüsst den User und Zeichnet das Menue.
     */
    private void begruessen() {
        String ausgabe = "Willkommen zur Filminhaltsbibliothek\n";
        ausgabe += "Was möchten Sie machen, wählen Sie:\n\n";
        ausgabe += "«a» für Anzeigen von Filmen\n";
        ausgabe += "«e» für das Erfassen eines neuen Filmes\n";
        ausgabe += "«k» für das Erfassen einer neuen Kategorie\n";
        ausgabe += "«l» für das Löschen einer Kategorie oder eines Filmes";
        System.out.println(ausgabe);
    }

    /**
     * Befüllt die Sammlung initial mir Werten.
     */
    private void initSammlung() {

        Kategorie kat1 = new Kategorie("Fantasie");
        kat1.addFilm(new Filme("Harry Potter und der Stein der Weisen - J.K Rolling"));
        kat1.addFilm(new Filme("Warrior Cats, Die Schlacht beginnt - Emil Hunter"));

        Kategorie kat2 = new Kategorie("Sci-Fi");
        kat2.addFilm(new Filme("Sei vorsichtig nach was du suchst: LIFE - Andreas Bertoni"));
        kat2.addFilm(new Filme("Raumschiff Enterprise - Roland Handerson"));
        kat2.addFilm(new Filme("Star Wars the Clone Wars - Rene Hamilton"));

        Kategorie kat3 = new Kategorie("Liebesfilme");
        kat3.addFilm(new Filme("La-La-Land - Bredly Cooper"));
        kat3.addFilm(new Filme("Im Bauch, Im Kopf, Im Juli - Till Schweiger"));
        kat3.addFilm(new Filme("Silver Linings - Amanda Lawrence"));

        collection.addKategorie(kat1);
        collection.addKategorie(kat2);
        collection.addKategorie(kat3);
    }

    static void pruefePassWort(String passWortVergabe){
        System.out.println("Ich heisse Sie herzlich willkommen.\n Geben Sie bitte das GeneralPasswort ein:");//Aufforderung zur Passworteingabe
        String passwortPruefung = Einleser.scanner.next() ;//Speichern des eingebenen Passwortes
        int i =1;//Zählvariable für Versuche

        while(passWortVergabe.equals(passwortPruefung)==false && i<3){
            System.out.println("Passwort falsch. Neuer Versuch");
            passwortPruefung = Einleser.scanner.next();
            i++;
        }
        if (passWortVergabe.equals(passwortPruefung)==true){
            System.out.println("Zugang gewährt \n");
        }
        else {
            System.out.println("Passwort falsch. Zugang verweigert. Wenden Sie sich an den System-Administrator");
            System.exit( 0 );
        }
    }



}