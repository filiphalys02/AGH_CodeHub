package com.example.gameplay;

import javafx.application.*;
import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import java.util.*;
import javafx.concurrent.*;
import javafx.beans.*;
import javafx.beans.value.*;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;

class Snake
{
    double x,y, x0, y0;
    double promien = 30;
    int color; //1 - zielony, 2- czerwony, 3-niebieski, 4-rozowy
    GraphicsContext gc;

    Snake(GraphicsContext gc)
    {
        this.gc = gc;
        x0 = 50.0;
        y0 = 50.0;
    }

    void drawSnake(GraphicsContext gc)
    {
        this.gc = gc;
        x0 = x + x0;
        y0 = y + y0;
        gc.fillOval(x0, y0, promien, promien);
        x = 0;
        y = 0;
    }

    void changeColor(GraphicsContext gc, int color)
    {
        this.gc = gc;
        this.color = color;

        if (color == 0)
        {
            gc.setFill(Color.BLACK);
        }
        else if(color == 1)
        {
            gc.setFill(Color.GREEN);
        }

        else if(color == 2)
        {
            gc.setFill(Color.RED);
        }

        else if(color == 3)
        {
            gc.setFill(Color.BLUE);
        }

        else if(color == 4)
        {
            gc.setFill(Color.PINK);
        }
    }
/*
    void setBackgroundColor(GraphicsContext gc, back_color)
    {

    }
*/
}


class G_task extends Task<Gp_values>
{

    final  int VENDOR_ID   = 0x0810;

    int  result;
    Gp gamepad;
    Gp_values curr_v;
    public G_task()
    {
        gamepad = new Gp();
        result = gamepad.gp_open(VENDOR_ID, 0x0001);
        if(result == -1) System.out.println("gamepad not opened");
    }

    @Override
    protected Gp_values call() throws Exception
    {
        while(true)
        {
            curr_v = gamepad.get_values();


            updateValue(null);
            updateValue(curr_v);




            try { Thread.sleep(10);  System.out.println("sleep method");    }
            catch (InterruptedException ex)
            {
                System.out.println("catch method");
                break;
            }
        }


        return null;
    }
}

class Game_service extends Service<Gp_values>
{

    Task t;

    public Game_service()
    {

    }

    protected Task createTask()
    {
        t = new G_task();

        return t;

    }

}





public class JavaFXApp extends Application implements ChangeListener<Gp_values>
{
    Stage stage;

    Game_service g_s;

    GraphicsContext gc;
    Canvas canvas;
    Snake snake;
    int color = 0;
    int zmiana = 1;

    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) {
        primaryStage.setTitle("JavaFX App");

        stage = primaryStage;

        Menu menu1 = new Menu("File");

        MenuItem menuItem1 = new MenuItem("Item 1");

        MenuItem menuItem2 = new MenuItem("Exit");

        menuItem2.setOnAction(e -> {
            System.out.println("Exit Selected");

            exit_dialog();

        });

        menu1.getItems().add(menuItem1);
        menu1.getItems().add(menuItem2);


        MenuBar menuBar = new MenuBar();

        menuBar.getMenus().add(menu1);

        VBox vbox = new VBox(menuBar);

        Scene scene = new Scene(vbox, 960, 600);

        primaryStage.setScene(scene);

        primaryStage.setOnCloseRequest(e -> {
            e.consume();
            exit_dialog();
        });

        g_s = new Game_service();

        g_s.valueProperty().addListener(this::changed);

        g_s.start();
        primaryStage.show();
        canvas = new Canvas(960, 600);
        gc = canvas.getGraphicsContext2D();
        vbox.getChildren().add(canvas);

        snake = new Snake (gc);
        snake.changeColor(gc,color);
        snake.drawSnake(gc);

    }

    public void changed(ObservableValue<? extends Gp_values> observable,
                        Gp_values oldValue,
                        Gp_values newValue)
    {
        if(newValue != null)
        {
            //System.out.println("changed method called, x = " + newValue.x + "y = " + newValue.y);
            // System.out.println("changed method");
            for(int j = 0; j < newValue.buttons.length; j++)
            {
                switch(j)
                {
                    case 0:
                    {
                        if(newValue.buttons[j]) {
                            if (snake.promien >= 0) snake.promien-=1; //System.out.println("TL");
                        }
                    }
                    break;

                    case 1:
                    {
                        if(newValue.buttons[j]) {
                            if (snake.promien <= 100 ) snake.promien+=1; //System.out.println("TR");
                        }
                    }
                    break;

                    case 2:
                    {
                        if(newValue.buttons[j]) System.out.println("ZL");
                    }
                    break;

                    case 3:
                    {
                        if(newValue.buttons[j]) zmiana+=1; //System.out.println("ZR");
                    }
                    break;

                    case 4:
                    {
                        if(newValue.buttons[j]) System.out.println("SELECT");
                    }
                    break;

                    case 5:
                    {
                        if(newValue.buttons[j]) System.out.println("START");
                    }
                    break;

                    case 6:
                    {
                        if(newValue.buttons[j]) System.out.println("ANALOG");
                    }
                    break;

                    case 7:
                    {
                        if(newValue.buttons[j]) color = 1; //System.out.println("1")
                    }
                    break;

                    case 8:
                    {
                        if(newValue.buttons[j]) color = 2; //System.out.println("2");
                    }
                    break;

                    case 9:
                    {
                        if(newValue.buttons[j]) color = 3; //System.out.println("3");
                    }
                    break;

                    case 10:
                    {
                        if(newValue.buttons[j]) color = 4; //System.out.println("4");
                    }
                    break;

                    case 11:
                    {
                        if(newValue.buttons[j]) snake.y = -1; //System.out.println("N");
                    }
                    break;

                    case 12:
                    {
                        if(newValue.buttons[j]) snake.x = 1; //System.out.println("E");
                    }
                    break;

                    case 13:
                    {
                        if(newValue.buttons[j]) snake.y = 1; //System.out.println("S");
                    }
                    break;

                    case 14:
                    {
                        if(newValue.buttons[j]) snake.x = -1; //System.out.println("W");
                    }
                    break;

                    case 15:
                    {
                        if(newValue.buttons[j]) System.out.println("L_PRESSED");
                    }
                    break;

                    case 16:
                    {
                        if(newValue.buttons[j]) System.out.println("R_PRESSED");
                    }
                    break;
                }
            }

            if(newValue.analog_mode)
            {
                //  snake.x += (newValue.LX-128.0)/127.0; //System.out.println("LX:" + newValue.LX);
                //  snake.y += (newValue.LY-128.0)/127.0; //System.out.println("LY:" + newValue.LY);

                snake.x += newValue.LX-128.0; //System.out.println("LX:" + newValue.LX);
                snake.x/=127.0;
                snake.y += newValue.LY-128.0; //System.out.println("LY:" + newValue.LY);
                snake.y/=127.0;

                System.out.println("RX:" + newValue.RX);
                System.out.println("RY:" + newValue.RY);
            }
        }

        snake.changeColor(gc,color);
        snake.drawSnake(gc);

    }



    public void item_1()
    {
        System.out.println("item 1");
    }

    public void exit_dialog()
    {
        System.out.println("exit dialog");


        Alert alert = new Alert(AlertType.CONFIRMATION,
                "Do you really want to exit the program?.",
                ButtonType.YES, ButtonType.NO);

        alert.setResizable(true);
        alert.onShownProperty().addListener(e -> {
            Platform.runLater(() -> alert.setResizable(false));
        });

        Optional<ButtonType> result = alert.showAndWait();
        if (result.get() == ButtonType.YES)
        {
            Platform.exit();
        }

    }
}
