/*
 * SimpleExample1.fx
 *
 * Created on Sep 10, 2009, 2:44:15 PM
 */

package com.lj.jfxe.chapter5;

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.animation.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.*;

/**
 * @author lucasjordan
 */
 
function run():Void{
    var dot = Circle{
        radius: 10;
        translateX: 140
        translateY: 240
    }
    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
                time: 5s
                values: dot.translateX => 440 tween Interpolator.EASEBOTH;
            }
    }
    anim.play();
    Stage {
        title: "Chapter 5 - Simple Example"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.WHITE
            content: [dot]
        }
    }
}

