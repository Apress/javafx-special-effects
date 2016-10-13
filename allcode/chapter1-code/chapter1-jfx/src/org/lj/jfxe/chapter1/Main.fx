/*
 * Main.fx
 *
 * Created on Oct 24, 2009, 1:47:06 PM
 */

package org.lj.jfxe.chapter1;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.control.Label;
import javafx.scene.control.TextBox;
import javafx.scene.control.Button;
import javafx.scene.paint.Color;

/**
 * @author lucasjordan
 */

Stage {
    title: "Java FX - Default Style"
    width: 320
    height: 220
    scene: Scene {
        fill: Color.LIGHTGRAY
        content: [
                Label{
                    text: "Please Enter Your Credentials";
                    translateX: 60
                    translateY: 20
                    scaleX: 1.2
                    scaleY: 1.2
                },
                Label{
                    text: "Username";
                    translateX: 20
                    translateY: 55
                    scaleX: 1.1
                    scaleY: 1.1
                },
                Label{
                    text: "Password";
                    translateX: 20
                    translateY: 95
                    scaleX: 1.1
                    scaleY: 1.1
                },
                TextBox{
                    text: "ljordan"
                    width: 200
                    translateX: 90
                    translateY: 50
                },
                TextBox{
                    text: "************"
                    width: 200
                    translateX: 90
                    translateY: 90
                },
                Button{
                    text: "Ok"
                    translateX: 250
                    translateY: 140
                }


        ]
    }
}