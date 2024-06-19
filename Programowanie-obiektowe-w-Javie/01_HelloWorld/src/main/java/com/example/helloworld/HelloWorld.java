package com.example.helloworld;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.stage.Stage;

public class HelloWorld extends Application {
    public static void main(String[] args) {

        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("Hello World!");

        int WIDTH = 300;
        int HEIGHT = 300;

        Button btn = new Button();
        btn.setText("Say 'Good morning World'");

        btn.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                System.out.println("Good morning World!");
            }
        });

        Button btn2 = new Button();
        btn2.setText("Say 'Good evening World'");

        btn2.setOnAction(new EventHandler<ActionEvent>() {
                @Override
                public void handle(ActionEvent event) {
                System.out.println("Good evening World!");
            }
        });

        Group root = new Group();

        root.getChildren().add(btn);
        root.getChildren().add(btn2);

        Scene scene = new Scene(root, WIDTH, HEIGHT);

        btn.setLayoutX(scene.getWidth()/5);
        btn.setLayoutY(scene.getHeight()/5);
        btn2.setLayoutX(scene.getWidth()/5);
        btn2.setLayoutY(scene.getHeight()*2/5);

        primaryStage.setScene(scene);
        primaryStage.show();
    }
}
