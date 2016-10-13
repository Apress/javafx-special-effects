/*
 * Main.fx
 *
 * Created on Sep 23, 2009, 12:56:17 PM
 */

package com.lj.jfxe.chapter5.transitions;

import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.layout.*;
import javafx.animation.Interpolator;
import javafx.scene.paint.Color;
import javafx.scene.input.MouseEvent;

/**
 * @author lucasjordan
 */

var interpolator:Interpolator = Interpolator.LINEAR;

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

function run():Void{
    var fadeButton = Button{
        text: "Fade"
        action: fade;
        disable: bind disabled
    }
    var slideButton = Button{
        text: "Slide"
        action: slide;
        disable: bind disabled
    }
    var flipButton = Button{
        text: "Flip"
        action: flip;
        disable: bind disabled
    }

    var transitionButtons = VBox{
        translateX: 32
        translateY: 32
        spacing: 12
        content: [fadeButton,slideButton,flipButton]
    }


    var toggleGroup = ToggleGroup{};

    var linearButton = RadioButton{
       graphic: Label{text: "Linear", textFill: Color.WHITESMOKE}
       toggleGroup: toggleGroup;
       selected: true
       onMouseClicked:function(event:MouseEvent):Void{
                interpolator = Interpolator.LINEAR;
            }
    }
    var easeButton = RadioButton{
       graphic: Label{text: "Ease", textFill: Color.WHITESMOKE}
       toggleGroup: toggleGroup;
       onMouseClicked:function(event:MouseEvent):Void{
                interpolator = Interpolator.EASEBOTH
            }
    }
    var splinButton = RadioButton{
        graphic: Label{text: "Spline", textFill: Color.WHITESMOKE}
        toggleGroup: toggleGroup
        onMouseClicked:function(event:MouseEvent):Void{
                interpolator = Interpolator.SPLINE(.2,.8,.8,.2);
            }
    }

    var polynomialButton = RadioButton{
       graphic: Label{text: "Polynomial", textFill: Color.WHITESMOKE}
       toggleGroup: toggleGroup;
       onMouseClicked:function(event:MouseEvent):Void{
                interpolator = PolynomialInterpolator{
                            coefficients: [5.06, -16.99, 20.0, -14.28, 20.0, -12.78]
                        }
            }
    }

    var windupButton = RadioButton{
       graphic: Label{text: "Windup", textFill: Color.WHITESMOKE}
       toggleGroup: toggleGroup;
       onMouseClicked:function(event:MouseEvent):Void{
                interpolator = WindupOvershootInterpolator.WINDUP_OVERSHOOT
            }
    }



    var interpolatorButtons = VBox{
        translateX: 530
        translateY: 32
        spacing: 12
        content: [linearButton,easeButton,splinButton,polynomialButton,windupButton]
    }

    Stage {
        title: "Chapter 5 - Transitions Example"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.BLACK
            content: [transitionButtons, interpolatorButtons, nodeA]
        }
    }
}

function doAfter():Void{
    var temp = notDisplayed;
    notDisplayed = displayed;
    displayed = temp;
    disabled = false;
}

function fade():Void{
    disabled = true;
    FadeReplace.doReplace(displayed, notDisplayed, interpolator, doAfter);
}
function slide():Void{
    disabled = true;
    SlideReplace.doReplace(displayed, notDisplayed, interpolator, doAfter);
}

function flip():Void{
    disabled = true;
    FlipReplace.doReplace(displayed, notDisplayed, interpolator, doAfter);
}
