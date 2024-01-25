package com.fk.funkcja_kwadratowa;

import javafx.application.Application;
import javafx.event.ActionEvent;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.chart.*;
import javafx.scene.layout.*;
import javafx.stage.Stage;
import javafx.geometry.Pos;


class Trinomial
{
    double a,b,c,delta,x1,x2;

    public Trinomial (double a, double b, double c)
    {
        this.a = a;
        this.b = b;
        this.c = c;
        System.out.println("\nTrinomial");
        System.out.println("a = " + a);
        System.out.println("b = " + b);
        System.out.println("c = " + c);

        counting_delta(a, b, c);
    }

    void counting_delta(double a, double b, double c)
    {
        delta = b * b - 4 * a * c;
        if (delta>0)
        {
            x1 = (-b-Math.sqrt(delta))/2*a;
            x2 = (-b+Math.sqrt(delta))/2*a;
            System.out.println("Delta > 0; two roots");
            System.out.println("x1 = " + x1 + "    AND    x2 = " + x2);
        }
        else
        {
            if (delta==0)
            {
                x1 = (-b)/2*a;
                System.out.println("Delta = " + delta + "    ==>    one root");
                System.out.println("x1 = " + x1);
            }
            else
            {

                System.out.println("Delta = " + delta + "    ==>    Delta < 0    ==>    no roots");
            }
        }
    }
}

class Quadrinomial {

    Double a,b,c,d,f,g,h,x1,x2,x3;
    public Quadrinomial(Double a, Double b, Double c, Double d) {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        System.out.println("\nQuadrinomial");
        System.out.println("a = " + a);
        System.out.println("b = " + b);
        System.out.println("c = " + c);
        System.out.println("d = " + d);

        counting_fgh(a,b,c,d);
    }

    void counting_fgh(double a, double b, double c, double d) {
        f = (c/a)-((b*b)/(3*a*a*a));
        g = (2*b*b*b)/(27*a*a*a)-(b*c)/(3*a*a)+d/a;
        h = ((g*g)/4)+(f*f*f)/27;

        System.out.println("f = " + f +"    g = " + g + "    h = " + h);
        if ( h>0 ) {
            System.out.println("h>0    ==>    one real root");
            x1 = Math.cbrt((-g/2)+Math.sqrt(h))+Math.cbrt((-g/2)-Math.sqrt(h))-b/(3*a);
            System.out.println("x1 = " + x1);
        } else if ( f==0 & g==0 ) {
            System.out.println("f = 0  AND  g = 0    ==>    one triple root");
            x1=-Math.cbrt(d/a);
            System.out.println("x1 = x2 = x3 = " + x1);
        } else {
            System.out.println("Three real roots");
            Double i = Math.sqrt((g*g/4)-h);
            Double j = Math.cbrt(i);
            Double k = Math.acos(-g/(2*i));
            Double m = Math.cos(k/3);
            Double n = Math.sqrt(3)*Math.sin(k/3);
            Double p = -b/(3*a);
            x1 = 2*j*m+p;
            x2 = -j*(m+n)+p;
            x3 = -j*(m-n)+p;
            System.out.println("x1 = " + x1 + "    x2 = " + x2 + "    x3 = " + x3);
        }

    }
}




public class Chart_1 extends Application
{
    int HEIGHT = 710;
    int WIDHT = 560;
    TextField t1, t2, t3, t4;
    LineChart l;
    XYChart.Series<Double, Double> series;

    @Override

    public void start(Stage primaryStage) throws Exception
    {
        AnchorPane ap = new AnchorPane();

        Label l1,l2,l3,l4;

        Button action = new Button("Display");

        action.setOnAction(this::display);

        double a, b, c, d;

        VBox parameters = new VBox();
        parameters.setSpacing( 5.0d );
        parameters.setAlignment(Pos.TOP_LEFT);

        HBox line_1, line_2, line_3, line_4;

        line_1 = new HBox();
        line_1.setSpacing( 4.0d );
        l1 = new Label("a:");
        t1 = new TextField("0.0");
        line_1.getChildren().addAll(l1, t1);

        line_2 = new HBox();
        line_2.setSpacing( 4.0d );
        l2 = new Label("b:");
        t2 = new TextField("0.0");
        line_2.getChildren().addAll(l2, t2);

        line_3 = new HBox();
        line_3.setSpacing( 4.0d );
        l3 = new Label("c:");
        t3 = new TextField("0.0");
        line_3.getChildren().addAll(l3, t3);

        line_4 = new HBox();
        line_4.setSpacing( 4.0d );
        l4 = new Label("d:");
        t4 = new TextField("-");
        line_4.getChildren().addAll(l4, t4);

        parameters.getChildren().addAll(line_1, line_2, line_3, line_4, action);


        ap.getChildren().add( parameters );

        l = new LineChart(new NumberAxis("X", -5.0, 5.0, 1), new NumberAxis("Y", -5.0, 5.0, 1));

        l.setLegendVisible(false);
        l.setCreateSymbols(false);

        series = new XYChart.Series<>();

        series.getData().add( new XYChart.Data<>(0.0,0.0));
        series.getData().add( new XYChart.Data<>(0.0,0.0));
        series.getData().add( new XYChart.Data<>(0.0,0.0));

        l.getData().add(series);


        l.setTitle("Function");
        l.setStyle("-fx-background-color: #87bd7b");
        ap.getChildren().add( l );
        AnchorPane.setTopAnchor( l, 160.0d );
        AnchorPane.setBottomAnchor( l, 10.0d );
        AnchorPane.setRightAnchor( l, 10.0d );
        AnchorPane.setLeftAnchor( l, 10.0d );
        Scene scene = new Scene(ap);
        primaryStage.setTitle("Simple chart plotting");
        primaryStage.setScene( scene );
        primaryStage.setWidth(WIDHT);
        primaryStage.setHeight(HEIGHT);
        primaryStage.show();
    }

    private void display(ActionEvent e)
    {
        series.getData().clear();
        String t4_check = String.valueOf(t4.getText());
        if (t4_check.equals("-")) {
            Trinomial trinomial = new Trinomial(Double.parseDouble(t1.getText()),
                    Double.parseDouble(t2.getText()),
                    Double.parseDouble(t3.getText()));
            for (double x=-5; x<5; x+=0.01) {
                series.getData().add( new XYChart.Data<>(x,trinomial.a*x*x+trinomial.b*x+trinomial.c));
                l.setTitle("Trinomial");
            }
        } else {
            Quadrinomial quadrinomial = new Quadrinomial(Double.parseDouble(t1.getText()),
                    Double.parseDouble(t2.getText()), Double.parseDouble(t3.getText()),
                    Double.parseDouble(t4.getText()));
            for (double x=-5; x<5; x+=0.01) {
                series.getData().add( new XYChart.Data<>(x, quadrinomial.a*x*x*x+quadrinomial.b*x*x+quadrinomial.c*x+quadrinomial.d));
                l.setTitle("Quadrinomial");
            }
        }
    }

    public static void main(String[] args)
    {
        launch(args);
    }
}