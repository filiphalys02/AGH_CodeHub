package com.example.rysowaniefigur;

import javafx.application.Application;
import javafx.scene.Group;
import javafx.scene.Scene;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;
import javafx.scene.shape.ArcType;
import javafx.stage.Stage;

public class BasicOpsTest extends Application {
    public BasicOpsTest() {
    }

    public static void main(String[] args) {
        launch(args);
    }

    int WIDHT = 300;
    int HEIGHT = 250;

    public void start(Stage primaryStage) {
        primaryStage.setTitle("Drawing Operations Test");
        Group root = new Group();
        Canvas canvas = new Canvas(WIDHT, HEIGHT);
        GraphicsContext gc = canvas.getGraphicsContext2D();
        this.drawShapes(gc);
        root.getChildren().add(canvas);
        primaryStage.setScene(new Scene(root));
        primaryStage.show();
    }

//    private void drawflower(GraphicsContext gc) {
//        gc.setStroke(Color.GREEN);
//        gc.setLineWidth(5.0);
//        gc.strokeLine(40.0, 10.0, 10.0, 40.0);
//    }

    public class Flower {
        public Flower(GraphicsContext gc, int trans) {
            gc.setStroke(Color.GREEN);
            gc.setLineWidth(5.0);
            gc.strokeLine(trans, 150.0, trans, 200.0);
            gc.setFill(Color.GREEN);
            gc.fillPolygon(new double[]{0.0, WIDHT, WIDHT, 0.0}, new double[]{200.0, 200.0, HEIGHT, HEIGHT}, 4);
            gc.setFill(Color.RED);
            gc.fillArc(trans-10, 130.0, 20.0, 20.0, 150.0, 240.0, ArcType.OPEN);
        }

    }
    private void drawShapes(GraphicsContext gc) {
//        gc.setFill(Color.GREEN);
//        gc.setStroke(Color.BLUE);
//        gc.setLineWidth(5.0);
//        gc.strokeLine(40.0, 10.0, 10.0, 40.0);
//        gc.fillOval(10.0, 60.0, 30.0, 30.0);
//        gc.strokeOval(60.0, 60.0, 30.0, 30.0);
//        gc.fillRoundRect(110.0, 60.0, 30.0, 30.0, 10.0, 10.0);
//        gc.strokeRoundRect(160.0, 60.0, 30.0, 30.0, 10.0, 10.0);
//        gc.fillArc(10.0, 110.0, 30.0, 30.0, 45.0, 240.0, ArcType.OPEN);
//        gc.fillArc(60.0, 110.0, 30.0, 30.0, 45.0, 240.0, ArcType.CHORD);
//        gc.fillArc(110.0, 110.0, 30.0, 30.0, 45.0, 240.0, ArcType.ROUND);
//        gc.strokeArc(10.0, 160.0, 30.0, 30.0, 45.0, 240.0, ArcType.OPEN);
//        gc.strokeArc(60.0, 160.0, 30.0, 30.0, 45.0, 240.0, ArcType.CHORD);
//        gc.strokeArc(110.0, 160.0, 30.0, 30.0, 45.0, 240.0, ArcType.ROUND);
//        gc.fillPolygon(new double[]{10.0, 40.0, 10.0, 40.0}, new double[]{210.0, 210.0, 240.0, 240.0}, 4);
//        gc.strokePolygon(new double[]{60.0, 90.0, 60.0, 90.0}, new double[]{210.0, 210.0, 240.0, 240.0}, 4);
//        gc.strokePolyline(new double[]{110.0, 140.0, 110.0, 140.0}, new double[]{210.0, 210.0, 240.0, 240.0}, 4);

        for (int i=0; i<10; i++) {
            Flower flower = new Flower(gc, i*(WIDHT/10)+15);
        }
    }
}