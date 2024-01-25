package com.example.map;

import javafx.application.Application;
import javafx.scene.image.Image;
import javafx.event.ActionEvent;
import javafx.scene.Scene;
import javafx.scene.control.RadioButton;
import javafx.scene.input.MouseEvent;
import javafx.stage.Stage;
import javafx.scene.layout.*;
import javafx.scene.canvas.Canvas;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;

import java.io.File;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;
import java.util.*;

class Obiekt
{
    String tag_name;
    String fill_color;
    String stroke_color;
    ArrayList<Double> arrayListX = new ArrayList<Double>();
    ArrayList<Double> arrayListY = new ArrayList<Double>();

    Obiekt(){};

    Obiekt(String name) {
        tag_name = name;
    }

    public void set_fc(String fc) {
        fill_color = fc;
    }

    public void set_sc(String sc) {
        stroke_color = sc;
    }
}

class Handler_1 extends DefaultHandler
{
    String loc_name;
    String flag = "init";
    Obiekt ob;

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes)
            throws SAXException
    {
        if ( flag.equals("lasy") )
            ob = new Obiekt("lasy");
        if( flag.equals("skala_cz"))
            ob = new Obiekt("skala_cz");
        if( flag.equals("skala_sz"))
            ob = new Obiekt("skala_sz");
        if( flag.equals("skaly") )
            ob = new Obiekt("init");
        if( flag.equals("budynki") )
            ob = new Obiekt( "budynki" );

        for (int i=0; i < attributes.getLength(); ++i)
        {
            loc_name = attributes.getQName(i);
            if (loc_name.equals("id") && (qName.equals("g") || qName.equals("symbol")))
            {
                flag = attributes.getValue(loc_name);
                continue;
            }
            if( flag.equals("lasy") || flag.equals("skala_cz") || flag.equals("skala_sz") || flag.equals("budynki") )
            {
                if (loc_name.equals("fill"))
                {
                    ob.set_fc(attributes.getValue(loc_name));
                    continue;
                }

                if (loc_name.equals("stroke"))
                {
                    ob.set_sc(attributes.getValue(loc_name));
                    continue;
                }
                if (loc_name.equals( "d"))
                {
                    String t = attributes.getValue(loc_name);
                    t.replaceAll("\t"," ");
                    t = t.split("z")[0];
                    t = t.split("M")[1];
                    t.replaceAll("a", "l");
                    String fp = t.split("l")[0];
                    String[] pp = (t.split("l")[1]).split(" ");
                    ob.arrayListX.add(Double.parseDouble(fp.replaceAll("\\s+","").split(",")[0]));
                    ob.arrayListY.add(Double.parseDouble(fp.replaceAll("\\s+","").split(",")[1]));
                    int ii = 0;
                    for(String xy : pp)
                    {
                        if(xy.replaceAll("\\s+","").split(",")[0] == "") continue;
                        if(xy.replaceAll("\\s+","").split(",")[1] == "") continue;

                        ob.arrayListX.add(Double.parseDouble(xy.replaceAll("\\s+","").split(",")[0]) + ob.arrayListX.get(ii));
                        ob.arrayListY.add(Double.parseDouble(xy.replaceAll("\\s+","").split(",")[1]) + ob.arrayListY.get(ii));

                        ++ii;
                    }
                    continue;
                }
            }
            if( flag.equals("skaly"))
            {
                if(qName.equals("use"))
                {
                    if (loc_name.equals("xlink:href"))
                    {
                        ob.tag_name = attributes.getValue(loc_name).split("#")[1];
                        continue;
                    }
                    if( loc_name.equals("x") )
                    {
                        ob.arrayListX.add(Double.parseDouble(attributes.getValue(loc_name)));
                        ob.arrayListX.add(1.0);
                        continue;
                    }
                    if( loc_name.equals("y") )
                    {
                        ob.arrayListY.add(Double.parseDouble(attributes.getValue(loc_name)));
                        ob.arrayListY.add(1.0);
                        continue;
                    }
                    if (loc_name.equals("transform"))
                    {
                        String t = attributes.getValue(loc_name);
                        String translate = t.split("\\(")[1]; //translate

                        translate = translate.split("\\)")[0];

                        ob.arrayListX.add(Double.parseDouble(translate.split(",")[0]));
                        ob.arrayListY.add(Double.parseDouble(translate.split(",")[1]));
                        if(t.split("\\(").length>2)
                        {
                            String scale = t.split("\\(")[2]; //scale
                            scale = scale.split("\\)")[0];
                            ob.arrayListX.add(Double.parseDouble(scale.split(",")[0]));
                            ob.arrayListY.add(Double.parseDouble(scale.split(",")[1]));
                        }
                        else
                        {
                            ob.arrayListX.add(1.0);
                            ob.arrayListY.add(1.0);
                        }
                        continue;
                    }

                }
                if(qName.equals("path"))
                {

                    if (loc_name.equals("transform"))
                    {
                        ob.tag_name = "skala_cz";
                        String t = attributes.getValue(loc_name);
                        String translate = t.split("\\(")[1]; //translate

                        translate = translate.split("\\)")[0];

                        ob.arrayListX.add(Double.parseDouble(translate.split(",")[0]));
                        ob.arrayListY.add(Double.parseDouble(translate.split(",")[1]));
                        if(t.split("\\(").length>2)
                        {
                            String scale = t.split("\\(")[2]; //scale
                            scale = scale.split("\\)")[0];
                            ob.arrayListX.add(Double.parseDouble(scale.split(",")[0]));
                            ob.arrayListY.add(Double.parseDouble(scale.split(",")[1]));
                        }
                        else
                        {
                            ob.arrayListX.add(1.0);
                            ob.arrayListY.add(1.0);
                        }
                        continue;
                    }
                }
            }
        }

        if ( flag.equals("lasy") && qName.equals("path") )
            Map_1.arrayListLas.add(ob);
        if (flag.equals("skala_cz") && qName.equals("path"))
            Map_1.wzorzec_skala_cz = ob;
        if (flag.equals("skala_sz") && qName.equals("path"))
            Map_1.wzorzec_skala_sz = ob;
        if (flag.equals("budynki") && qName.equals("path"))
            Map_1.arrayListBudynki.add(ob);
        if (flag.equals("skaly") && (qName.equals("use") || qName.equals("path")))
        {
            if(ob.tag_name.equals("skala_cz"))
            {
                ob.set_fc(Map_1.wzorzec_skala_cz.fill_color);
                ob.set_sc(Map_1.wzorzec_skala_cz.stroke_color);
            }
            if(ob.tag_name.equals("skala_sz"))
            {
                ob.set_fc(Map_1.wzorzec_skala_sz.fill_color);
                ob.set_sc(Map_1.wzorzec_skala_sz.stroke_color);
            }
            Map_1.arrayListSkala.add(ob);
        }
    }

    @Override
    public void endElement(String uri,String localName,String qName)
            throws SAXException
    {
        if (qName.equalsIgnoreCase("svg"))
        {
            //System.out.println("End Element :" + qName);
        }
    }

    @Override
    public void characters(char ch[], int start, int length) throws SAXException
    {
        //System.out.println(new String(ch, start, length));
    }
}

public class Map_1 extends Application
{
    private static final int FRAME_WIDTH  = 640;
    private static final int FRAME_HEIGHT = 480;

    public static ArrayList<Obiekt> arrayListLas = new ArrayList<Obiekt>();
    public static ArrayList<Obiekt> arrayListBudynki = new ArrayList<Obiekt>();
    public static ArrayList<Obiekt> arrayListSkala = new ArrayList<Obiekt>();
    public static Obiekt wzorzec_skala_cz;
    public static Obiekt wzorzec_skala_sz;

    int flag_w = 1;
    int flag_r = 1;
    int flag_b = 1;

    String imageUrl = getClass().getResource("/map.jpg").toExternalForm();
    Image image = new Image(imageUrl);
    int x, y;

    GraphicsContext gc;
    Canvas canvas;

    public static void main(String[] args)
    {
        try
        {
            File inputFile = new File("points.xml");
            SAXParserFactory factory = SAXParserFactory.newInstance();
            SAXParser saxParser = factory.newSAXParser();

            Handler_1 handler_1 = new Handler_1();

            saxParser.parse(inputFile, handler_1);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        launch(args);
    }

    @Override
    public void start(Stage primaryStage)
    {
        double x_p[] = new double[4];
        double y_p[] = new double[4];

        AnchorPane root = new AnchorPane();
        primaryStage.setTitle("Map");

        canvas = new Canvas(FRAME_WIDTH, FRAME_HEIGHT);
        canvas.setOnMousePressed(this::mouse);

        gc = canvas.getGraphicsContext2D();

        gc.drawImage(image, 0, 0, FRAME_WIDTH, FRAME_HEIGHT);

        root.getChildren().add(canvas);

        RadioButton btn1 = new RadioButton();
        btn1.setText("Woods");
        btn1.setSelected(true);
        btn1.setOnAction(this::woods);
        root.getChildren().add(btn1);
        AnchorPane.setBottomAnchor( btn1, 5.0d );
        AnchorPane.setLeftAnchor( btn1, 50.0d );

        RadioButton btn2 = new RadioButton();
        btn2.setText("Rocks");
        btn2.setSelected(true);
        btn2.setOnAction(this::rocks);
        root.getChildren().add(btn2);
        AnchorPane.setBottomAnchor( btn2, 5.0d );
        AnchorPane.setLeftAnchor( btn2, 150.0d );

        RadioButton btn3 = new RadioButton();
        btn3.setText("Buildings");
        btn3.setSelected(true);
        btn3.setOnAction(this::budynki);
        root.getChildren().add(btn3);
        AnchorPane.setBottomAnchor( btn3, 5.0d );
        AnchorPane.setLeftAnchor( btn3, 250.0d );

        Scene scene = new Scene(root);
        primaryStage.setTitle("Dolina B\u0229dkowska");
        primaryStage.setScene( scene );
        primaryStage.setWidth(FRAME_WIDTH + 10);
        primaryStage.setHeight(FRAME_HEIGHT+ 80);
        gc.setGlobalAlpha(0.5);
        draw_woods();
        gc.setGlobalAlpha(0.75);
        draw_rocks();
        draw_budynki();

        primaryStage.show();
    }

    private void woods(ActionEvent e)
    {
        flag_w = -flag_w;
        draw();
    }
    private void rocks(ActionEvent e)
    {
        flag_r = -flag_r;
        draw();
    }
    private void budynki(ActionEvent e)
    {
        flag_b = -flag_b;
        draw();
    }
    private void mouse(MouseEvent e)
    {
        System.out.println("X=" + e.getX());
        System.out.println("Y=" + e.getY());
    }

    private void draw_woods()
    {
        for(Obiekt ob : Map_1.arrayListLas)
        {
            if(ob.fill_color.equals("green"))
                gc.setFill(Color.GREEN);
            else
                gc.setFill(Color.WHITE);

            Object[] xx = (ob.arrayListX).toArray();
            Object[] yy = (ob.arrayListY).toArray();

            double[] x = new double[xx.length];
            double[] y = new double[yy.length];

            for(int i=0; i<ob.arrayListX.size(); i++)
            {
                x[i] = Double.parseDouble(xx[i].toString());
                y[i] = Double.parseDouble(yy[i].toString());
            }

            gc.fillPolygon( x, y ,ob.arrayListX.size());

            gc.setLineWidth(1);

            if(ob.stroke_color != null)
                gc.strokePolygon(x, y, ob.arrayListX.size());
        }
    }

    private void draw_budynki()
    {
        for(Obiekt ob : Map_1.arrayListBudynki)
        {
            gc.setFill(Color.BROWN);
            Object[] xx = (ob.arrayListX).toArray();
            Object[] yy = (ob.arrayListY).toArray();
            double[] x = new double[xx.length];
            double[] y = new double[yy.length];

            for(int i=0; i<ob.arrayListX.size(); i++)
            {
                x[i] = Double.parseDouble(xx[i].toString());
                y[i] = Double.parseDouble(yy[i].toString());
            }

            gc.fillPolygon( x, y ,ob.arrayListX.size());
            gc.setLineWidth(5);

            if(ob.stroke_color != null)
                gc.strokePolygon(x, y, ob.arrayListX.size());
        }
    }

    private void draw_rocks()
    {
        for(Obiekt ob: Map_1.arrayListSkala)
        {
            Obiekt wzorzec = new Obiekt();

            if(ob.tag_name.equals("skala_cz"))
                wzorzec = Map_1.wzorzec_skala_cz;
            else if(ob.tag_name.equals("skala_sz"))
                wzorzec = Map_1.wzorzec_skala_sz;
            else
                break;

            if(wzorzec.fill_color.equals("black"))
                gc.setFill(Color.BLACK);
            else if(wzorzec.fill_color.equals("darkgray"))
                gc.setFill(Color.DARKGRAY);
            else
                gc.setFill(Color.WHITE);

            Object[] xx = (ob.arrayListX).toArray();
            Object[] yy = (ob.arrayListY).toArray();

            double[] x = new double[xx.length];
            double[] y = new double[yy.length];

            for(int i=0; i<ob.arrayListX.size(); i++)
            {
                x[i] = Double.parseDouble(xx[i].toString());
                y[i] = Double.parseDouble(yy[i].toString());
            }

            int[] X = new int[wzorzec.arrayListX.toArray().length];
            int[] Y = new int[wzorzec.arrayListY.toArray().length];

            for(int i=0; i<X.length; ++i)
            {
                X[i] = (int)( wzorzec.arrayListX.get(i) + x[0] - (1-x[1])*wzorzec.arrayListX.get(i) );
                Y[i] = (int)( wzorzec.arrayListY.get(i) + y[0] - (1-y[1])*wzorzec.arrayListY.get(i) );
            }

            double[] XX = new double[X.length];
            double[] YY = new double[Y.length];

            for (int i = 0; i<X.length; ++i)
            {
                XX[i] = X[i];
                YY[i] = Y[i];
            }

            gc.fillPolygon( XX, YY ,XX.length);

            gc.setLineWidth(1);

            if(ob.stroke_color != null)
                gc.strokePolygon(XX, YY, XX.length);
        }
    }

    private void draw()
    {
        gc.setGlobalAlpha(1);
        gc.clearRect(0,0,canvas.getWidth(),canvas.getHeight());
        gc.drawImage(image, 0, 0, FRAME_WIDTH, FRAME_HEIGHT);
        gc.setGlobalAlpha(0.5);
        if(flag_w==1)
            draw_woods();
        gc.setGlobalAlpha(0.75);
        if(flag_r==1)
            draw_rocks();
        if(flag_b==1)
            draw_budynki();
    }
}
