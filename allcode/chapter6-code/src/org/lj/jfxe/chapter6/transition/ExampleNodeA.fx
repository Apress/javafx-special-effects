/*
 * ExampleNodeA.fx
 *
 * Created on Jul 15, 2009, 5:29:55 PM
 */

package org.lj.jfxe.chapter6.transition;

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
        insert Rectangle{
                width: 320
                height: 240
                stroke: Color.BLUE
                strokeWidth: 6
                arcHeight: 24
                arcWidth: 24
            } into content;
        var startY = 30;
        var startX = 30;
        var yStep = 30;
        insert Label{
                translateX: startX
                translateY: startY
                text:"Please Enter Your Personal Information"
                textFill: Color.WHITESMOKE
             } into content;
        startY += 26;
        insert Label{
                translateX: startX
                translateY: startY
                text:"First Name"
                textFill: Color.WHITESMOKE
             } into content;
        insert TextBox{
                translateX: startX + 100
                translateY: startY
             } into  content;
        startY += yStep;
        insert Label{
                translateX: startX
                translateY: startY
                text:"Last Name"
                textFill: Color.WHITESMOKE
             } into content;
        insert TextBox{
                translateX: startX + 100
                translateY: startY
             } into  content;
        startY += yStep;
        insert Label{
                translateX: startX
                translateY: startY
                text:"Home Phone"
                textFill: Color.WHITESMOKE
             } into content;
        insert TextBox{
                translateX: startX + 100
                translateY: startY
             } into  content;
        startY += yStep;
        insert CheckBox{
                translateX: startX
                translateY: startY
                graphic: Label{text:"Happy?", textFill: Color.WHITESMOKE}
             } into content;
   }
}