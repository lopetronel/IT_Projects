/**
 * Hier werden die entsprechenden Filme mit Author geschpeichert
 *
 * @author Leon Lopetrone
 * @version 1.0
 * @since 05.05.2020
 */

public class Filme {
    private String text;

    /**
     * Konstruktor für einen Film.
     * @param text Textinhalt welcher zu einem Film gehört
     */
    public Filme(String text){
        this.text = text;
    }

    /**
     * Getter für das Attribut "text"
     * @return den Text, der in den Film gehört
     */
    public String getText() {
        return text;
    }

    /**
     * Setter für das Attribut "text"
     * @param text Text welcher in diesen Film gehört
     */
    public void setText(String text) {
        this.text = text;
    }
}
