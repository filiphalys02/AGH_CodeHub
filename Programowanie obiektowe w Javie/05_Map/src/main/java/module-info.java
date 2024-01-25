module com.example.map {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.xml;


    opens com.example.map to javafx.fxml;
    exports com.example.map;
}