module com.fk.funkcja_kwadratowa {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.fk.funkcja_kwadratowa to javafx.fxml;
    exports com.fk.funkcja_kwadratowa;
}