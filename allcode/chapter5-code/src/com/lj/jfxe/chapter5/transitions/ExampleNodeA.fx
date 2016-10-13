/*
 * ExampleNodeA.fx
 *
 * Created on Jul 15, 2009, 5:29:55 PM
 */

package com.lj.jfxe.chapter5.transitions;

import javafx.scene.Group;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.*;
import javafx.scene.paint.*;
import javafx.scene.control.*;
import javafx.geometry.HPos;

/**
 * @author lucasjordan
 */

public class ExampleNodeA extends Group{

    init {

        insert
            Rectangle{
                width: 320
                height: 240
                stroke: Color.BLUE
                strokeWidth: 6
                arcHeight: 24
                arcWidth: 24
            } into content;
        insert
            VBox{
                spacing: 15
                translateX: 30
                translateY: 30
                hpos: HPos.CENTER
                content: [
                    Label{text:"Please Enter Your Personal Information", textFill: Color.WHITESMOKE},
                    Tile{
                        vgap: 7
                        columns: 2
                        content: [
                            Label{text:"First Name", textFill: Color.WHITESMOKE},
                            TextBox{},
                            Label{text:"Last Name", textFill: Color.WHITESMOKE},
                            TextBox{},
                            Label{text:"Email Address", textFill: Color.WHITESMOKE},
                            TextBox{},
                            Label{text:"Home Phone", textFill: Color.WHITESMOKE},
                            TextBox{},
                            Label{text:"Cell Phone", textFill: Color.WHITESMOKE},
                            TextBox{},
                            ]
                        }
                    ]
            } into content;
    }
}