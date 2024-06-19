module com.example.siatkowka {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.siatkowka to javafx.fxml;
    exports com.example.siatkowka;
}