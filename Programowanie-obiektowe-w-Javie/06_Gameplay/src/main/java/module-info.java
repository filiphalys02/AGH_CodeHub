module com.example.gameplay {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.gameplay to javafx.fxml;
    exports com.example.gameplay;
}