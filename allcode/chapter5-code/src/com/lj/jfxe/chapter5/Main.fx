/*
 * Main.fx
 *
 * Created on Sep 8, 2009, 10:40:01 AM
 */

package com.lj.jfxe.chapter5;

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.scene.control.*;
import javafx.scene.layout.VBox;
import javafx.animation.*;
import javafx.scene.paint.Color;
import javafx.scene.text.*;
import javafx.scene.shape.*;

/**
 * @author lucasjordan
 */


var label = Text{
    content: "Linear"
    translateX: 260
    translateY: 22
    fill: Color.BLACK;
    scaleX: 1.5
    scaleY: 1.5
}

var interpolatorViewer = InterpolatorViewer{
        translateX: 180
        translateY: 32
}

var editorGroup = Group{
        translateX: 180
        translateY: 300
}


function run():Void{

    var linear = Button{
        text: "Linear"
        action: function(){
            label.content = "Linear";
            interpolatorViewer.interpolator = Interpolator.LINEAR;
            delete editorGroup.content;
        }
    }
    var easeboth = Button{
        text: "Ease"
        action: function(){
            label.content = "Ease";
            delete editorGroup.content;
            insert EaseEditor{
                    viewer: interpolatorViewer;
                    } into editorGroup.content;
             }
        }
    
    var spline = Button{
        text: "Spline"
        action: function(){
            label.content = "Spline";
            delete editorGroup.content;
            insert SplineEditor{
                    viewer: interpolatorViewer;
                    } into editorGroup.content;
             }
        
    }
    var quadratic = Button{
        text: "Quadratic"
        action: function(){
            label.content = "Quadratic";
            delete editorGroup.content;
            insert QuadraticEditor{
                    viewer: interpolatorViewer;
                    } into editorGroup.content;
             }
    }
    var cubic = Button{
        text: "Cubic"
        action: function(){
            label.content = "Cubic";
            delete editorGroup.content;
            insert CubicEditor{
                    viewer: interpolatorViewer;
                    } into editorGroup.content;
        }
    }
    var poly = Button{
        text: "Polynomial"
        action: function(){
            label.content = "Polynomial";
            delete editorGroup.content;
            insert PolynomialEditor{
                    viewer: interpolatorViewer;
                    } into editorGroup.content;
        }
    }
    var windup = Button{
        text: "Windup/Overshoot"
        action: function(){
            label.content = "Windup/Overshoot";
            var interpolator = StepInterpolator{}
            delete editorGroup.content;
            insert WindupOvershootEditor{
                    viewer: interpolatorViewer;
                    } into editorGroup.content;
        }
    }
    var stepi = Button{
        text: "Step Function"
        action: function(){
            label.content = "Step Function";
            var interpolator = StepInterpolator{}
            interpolatorViewer.interpolator = interpolator;
            delete editorGroup.content;
            insert StepEditor{
                    viewer: interpolatorViewer;
                    interpolator: interpolator
                    } into editorGroup.content;
        }
    }

    var box = VBox{
        translateX: 32
        translateY: 16
        spacing: 16
        content: [linear, easeboth, spline, quadratic, cubic, poly, windup, stepi]
    }

    Stage {
        title: "Chapter 5"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.WHITE
            content: [label, box, interpolatorViewer, editorGroup]
        }
    }
}