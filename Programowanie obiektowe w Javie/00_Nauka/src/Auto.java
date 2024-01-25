public class Auto {
    final int waga;
    String kolor;
    final int konie_mechaniczne;



    public Auto(int waga, int konie_mechaniczne, String kolor) {
        this.waga=waga;
        this.konie_mechaniczne=konie_mechaniczne;
        this.kolor = kolor;
    }

    public void cykl() {
        ruszanie();
        jechanie();
        zatrzymywanie();
    }

    private void ruszanie() {
        System.out.println("Auto Ford rusza");
    }

    private void jechanie() {
        System.out.println("Auto Ford jedzie");
    }

    private void zatrzymywanie() {
        System.out.println("Auto Ford się zatrzymuje");
    }
    public void max_predkosc() {
        System.out.println(300);
    }
}
