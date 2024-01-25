module com.example.rysowaniefigur {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.rysowaniefigur to javafx.fxml;
    exports com.example.rysowaniefigur;
}