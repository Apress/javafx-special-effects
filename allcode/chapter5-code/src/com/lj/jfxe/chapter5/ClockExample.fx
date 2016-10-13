/*
 * ClockExample.fx
 *
 * Created on Sep 11, 2009, 8:32:14 AM
 */

package com.lj.jfxe.chapter5;

/**
 * @author lucasjordan
 */

import javafx.stage.Stage;
import javafx.scene.*;
import javafx.animation.*;
import javafx.scene.paint.Color;
import javafx.scene.shape.*;
import javafx.scene.transform.Transform;


function run():Void{
    var clock = Group{
        translateX: 320
        translateY: 230
    }
    for (i in [0..59]){
        var dot = Group{
            content: Circle{
                translateX: 200
                radius: 1
                fill: Color.BLACK
            }
            transforms: Transform.rotate(i/60.0 * 360.0, 0, 0);
        }
        insert dot into clock.content;
    }
    for (i in [0..11]){
        var bigDot = Group{
            content: Circle{
                translateX: 200
                radius: 3
                fill: Color.BLACK
            }
            transforms: Transform.rotate(i/12.0 * 360.0, 0, 0);
        }
        insert bigDot into clock.content;
    }

    var rotation = 0.0;
    var hand = Rectangle{
        width: 190
        height: 1
        fill: Color.RED
        transforms: bind Transform.rotate(rotation, 0, 0);
    }

    insert hand into clock.content;

    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 60s
            values: rotation => 360.0 tween StepInterpolator{steps: 61}
        }
    }
    anim.play();
    Stage {
        title: "Chapter 5 - Clock Example"
        width: 640
        height: 480
        scene: Scene {
            fill: Color.WHITE
            content: [clock]
        }
    }
}

