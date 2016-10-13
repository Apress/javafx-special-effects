/*
 * ExampleNodeB.fx
 *
 * Created on Jul 15, 2009, 5:30:08 PM
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

public class ExampleNodeB extends Group{

    var toggleGroup = ToggleGroup{}

    init {

        insert Rectangle{
                width: 320
                height: 240
                stroke: Color.RED
                strokeWidth: 6
                arcHeight: 24
                arcWidth: 24
            } into content;

        var startY = 30;
        var startX = 30;
        var yStep = 22;

        insert Label{
                translateX: startX
                translateY: startY
                text:"Please Configure Your Preferences"
                textFill: Color.WHITESMOKE
             } into content;
        startY += 26;
        insert Label{
                translateX: startX
                translateY: startY
                text:"Volume"
                textFill: Color.WHITESMOKE
            } into content;
        startY += yStep;
        insert Slider{
                translateX: startX
                translateY: startY
                min: 1
                max: 10
                value: 6
            } into  content;
        startY += yStep;
        insert Label{
                translateX: startX
                translateY: startY
                text:"Gain"
                textFill: Color.WHITESMOKE
            } into content;
        startY += yStep;
        insert Slider{
                translateX: startX
                translateY: startY
                min: 1
                max: 10
                value: 3
            } into  content;
        startY += yStep;
        insert RadioButton{
                translateX: startX
                translateY: startY
                selected: true
                toggleGroup: toggleGroup
                graphic: Label{text:"Repeat All", textFill: Color.WHITESMOKE}
             } into content;
        startY += yStep;
        insert RadioButton{
                translateX: startX
                translateY: startY
                toggleGroup: toggleGroup
                graphic: Label{text:"Repeat 1", textFill: Color.WHITESMOKE}
             } into content;
        startY += yStep;
        insert Button{
                translateX: startX+200
                translateY: startY
                text: "Next"
             } into content;
    }
}
