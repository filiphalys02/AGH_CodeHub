public class Main {
    public static void main(String[] args) {
//        Auto Ford = new Auto();
//
//        Ford.waga=700;
//        Ford.kolor="biały";
//        Ford.konie_mechaniczne=200;

        Auto Ford = new Auto( 1000, 200, "Biały");
        System.out.println(Ford.waga);
        System.out.println(Ford.konie_mechaniczne);
        System.out.println(Ford.kolor);

        Ford.cykl();

        Ford.max_predkosc();
    }
}