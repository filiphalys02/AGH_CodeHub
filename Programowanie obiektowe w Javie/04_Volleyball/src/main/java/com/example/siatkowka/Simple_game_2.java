package com.example.siatkowka;

import javafx.application.Application;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.event.ActionEvent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Slider;
import javafx.scene.input.MouseEvent;
import javafx.stage.Stage;
import javafx.scene.layout.*;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.util.Duration;

class Ball
{
    double x,y,t,alpha,v,x_0, y_0;
    int height;
    GraphicsContext gc;

    Ball( GraphicsContext gc,int height, double x_0, double y_0)
    {
        this.gc = gc;
        this.height = height;
        this.x_0=x_0;
        this.y_0=y_0;
    }

    void show()
    {
        System.out.println("step");
        double yJava = y;
        y = (double) height - yJava;
        gc.fillOval(x, y, 20, 20);
    }
    void countCoords()
    {
        x = x_0 + v*Math.cos(Math.toRadians(alpha))*t;
        y = y_0 + v*Math.sin(Math.toRadians(alpha))*t - (9.81*t*t)/2;
        t+=0.1;
    }
    void setBeginning(double x_0, double y_0)
    {
        double yJava = y_0;
        y_0 = (double) height - yJava;
        this.x_0 = x_0;
        this.y_0 = y_0;
    }
}

class Net {
    GraphicsContext gc;
    Net(GraphicsContext gc) {
        this.gc = gc;
        gc.fillRect(300,250,10,400);
        gc.fillRect(10,470,600,10);
    }
}

public class Simple_game_2 extends Application implements ChangeListener<Number>
{
    private static final int FRAME_WIDTH  = 640;
    private static final int FRAME_HEIGHT = 480;

    double x_0,y_0;
    GraphicsContext gc;
    Canvas canvas;
    Timeline timeline;


    Ball ball;


    public static void main(String[] args)
    {
        launch(args);
    }



    @Override
    public void start(Stage primaryStage)
    {
        AnchorPane root = new AnchorPane();
        primaryStage.setTitle("Volleyball");

        canvas = new Canvas(FRAME_WIDTH, FRAME_HEIGHT);
        canvas.setOnMousePressed(this::mouse);

        gc = canvas.getGraphicsContext2D();

        gc.fillRect(300,250,10,400);
        gc.fillRect(10,470,600,10);
        ball = new Ball(gc,FRAME_HEIGHT, x_0, y_0);



        root.getChildren().add(canvas);

        Button btn = new Button();
        btn.setText("Play");
        btn.setOnAction(this::play);

        root.getChildren().add(btn);
        AnchorPane.setBottomAnchor( btn, 5.0d );

        Slider alpha, v;

        alpha = new Slider(30, 80, 5);
        alpha.setShowTickMarks(true);
        alpha.setShowTickLabels(true);
        alpha.valueProperty().addListener(this::changed_alpha);
        root.getChildren().add(alpha);
        AnchorPane.setBottomAnchor( alpha, 2.0d );
        AnchorPane.setLeftAnchor( alpha, 150.0d );

        v = new Slider(10, 100, 10);
        v.setShowTickMarks(true);
        v.setShowTickLabels(true);
        v.valueProperty().addListener(this::changed);
        root.getChildren().add(v);
        AnchorPane.setBottomAnchor( v, 2.0d );
        AnchorPane.setLeftAnchor( v, 300.0d );

        Scene scene = new Scene(root);
        primaryStage.setTitle("Volleybal");
        primaryStage.setScene( scene );
        primaryStage.setWidth(FRAME_WIDTH + 10);
        primaryStage.setHeight(FRAME_HEIGHT + 80);
        primaryStage.show();
    }


    public void changed(ObservableValue<? extends Number> ov, Number old_val, Number new_val)
    {
        System.out.println("v=" + new_val);
        ball.v = new_val.doubleValue();
    }
    public void changed_alpha(ObservableValue<? extends Number> ov, Number old_val, Number new_val)
    {
        System.out.println("alpha=" + new_val);
        ball.alpha = new_val.doubleValue();
    }
    private void step()
    {
        gc.clearRect(0,0,FRAME_WIDTH,FRAME_HEIGHT);
        ball.countCoords();
        ball.show();
        Net net = new Net(gc);

        if (ball.x>=FRAME_WIDTH || ball.y>=FRAME_HEIGHT || ball.y<=0)
        {
            timeline.stop();
            System.out.println("Koniec");
        }

    }
    private void mouse(MouseEvent e)
    {
        System.out.println("X=" + e.getX());
        System.out.println("Y=" + e.getY());
        ball.setBeginning(e.getX(),e.getY());
    }
    private void play(ActionEvent e)
    {
        ball.t = 0;
        timeline = new Timeline(new KeyFrame(Duration.millis(10), e1->step()));
        timeline.setCycleCount(Timeline.INDEFINITE);
        timeline.play();
    }
}