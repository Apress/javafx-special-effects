/*
 * Main.fx
 *
 * Created on Jul 15, 2009, 2:53:13 PM
 */

package org.lj.jfxe.chapter3;

import javafx.stage.Stage;
import org.lj.jfxe.chapter3.example1.*;
import org.lj.jfxe.chapter3.example2.*;
import org.lj.jfxe.chapter3.example3.*;
import org.lj.jfxe.chapter3.example4.*;
import org.lj.jfxe.chapter3.example5.*;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.paint.Color;
import javafx.scene.Node;
import javafx.scene.layout.VBox;

/**
 * @author lucasjordan
 */

var nodeA = ExampleNodeA{
    translateX: 320 - 160
    translateY: 240 - 120
}
var nodeB = ExampleNodeB{
    translateX: 320 - 160
    translateY: 240 - 120
}

var displayed:Node = nodeA;
var notDisplayed:Node = nodeB;

var disabled = false;

var fadeButton = Button{
    text: "Fade Transition"
    action: function(){
        disabled = true;
        FadeReplace.doReplace(displayed, notDisplayed, doAfter);
    }
    disable: bind disabled;
}

var slideButton = Button{
    text: "Slide Transition"
    action: function(){
        disabled = true;
        SlideReplace.doReplace(displayed, notDisplayed, doAfter);
    }
    disable: bind disabled;
}

var flipButton = Button{
    text: "Flip Transition"
    action: function(){
        disabled = true;
        FlipReplace.doReplace(displayed, notDisplayed, doAfter);
    }
    disable: bind disabled;
}
var wipeButton = Button{
    text: "Wipe Transition"
    action: function(){
        disabled = true;
        WipeReplace.doReplace(displayed, notDisplayed, doAfter);
    }
    disable: bind disabled;
}
var burnButton = Button{
    text: "Burn Transition"
    action: function(){
        disabled = true;
        BurnReplace.doReplace(displayed, notDisplayed, doAfter);
    }
    disable: bind disabled;
}

Stage {
    title: "Chapter 3"
    width: 640
    height: 480
    scene: Scene {
        fill: Color.BLACK
        content: [
            VBox{
                spacing: 10
                translateX: 25
                translateY: 30
                content: [fadeButton,slideButton,flipButton,wipeButton,burnButton]
            },
            nodeA
        ]
    }
}

function doAfter():Void{
    var temp = notDisplayed;
    notDisplayed = displayed;
    displayed = temp;
    disabled = false;
}

