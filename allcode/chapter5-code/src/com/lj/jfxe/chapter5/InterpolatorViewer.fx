/*
 * InterpolationViewer.fx
 *
 * Created on Sep 8, 2009, 11:03:20 AM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.*;
import javafx.scene.Group;
import javafx.scene.shape.*;
import javafx.scene.paint.Color;
import javafx.scene.text.Text;

/**
 * @author lucasjordan
 */

public class InterpolatorViewer extends Group{
    public var interpolator:Interpolator = Interpolator.LINEAR on replace{
        draw();
    }

    public var currentFraction:Number = 0.0 on replace{
        currentValue = interpolator.interpolate(0.0, 1.0, currentFraction) as Number;
    };

    var currentValue:Number = 0.0;

    var animation = Timeline{
        repeatCount: Timeline.INDEFINITE;
        autoReverse: true;
        keyFrames: [
                    KeyFrame{
                        time: 0s
                        values: currentFraction => 0.0
                    },
                    KeyFrame{
                        time: 3s
                        values: currentFraction => 1.0
                    },

                ]
    }

    init{
        draw();
        animation.playFromStart();
    }

    public function draw():Void{
        delete content;

        var width = 256.0;
        var height = 256.0;

        var border = Rectangle{
            width: width;
            height: height;
            fill: null;
            stroke: Color.GRAY
            strokeWidth: 3
        }
        insert border into content;

        insert Text{
            translateX: width/2.0 - 40
            translateY: height - 2;
            content: "<- fraction ->"
            fill: Color.DARKGRAY
        } into content;
        insert Text{
            translateX: -39
            translateY: height/2.0
            content: "<- 0.0 - 1.0 ->"
            fill: Color.DARKGRAY
            rotate: -90.0
        } into content;


        var samples = 64.0;

        for (i in [0..samples]){
            var fraction:Number = i/samples;
            var value = (interpolator.interpolate(0.0, 1.0, fraction) as Number);
            var dot = Circle{
                translateX: i*(width/samples);
                translateY: height-value*height;
                radius: 2;
                fill: Color.BLUE
            }
            insert dot into content;
        }

        var playhead = Line{
            startX: bind currentFraction * width;
            startY: 0;
            endX: bind currentFraction * width;
            endY: height;
            stroke: Color.RED
        }

        insert playhead into content;


        var topLine = Line{
            startX: 0.0
            startY: 0.0
            endX: 10.0
            endY: 0.0
            stroke: Color.GRAY
            strokeDashOffset: 10
        }

        var bottomLine = Line{
            startX: 1.0
            startY: height
            endX: 10.0
            endY: height
            stroke: Color.GRAY
            strokeDashOffset: .5
        }

        var vball = Circle{
            radius: 4
            fill: Color.GREEN
            translateX: 5
            translateY: bind height - currentValue*height;
        }

        var vetical = Group{
            translateX: width + 20
            content: [topLine, bottomLine, vball]
        }

        insert vetical into content;

        var rotate = Rectangle{
            translateX: width + 80
            translateY: 90;
            width: 70
            height: 70
            fill: Color.MAGENTA
            rotate: bind currentValue*360.0
        }

        insert rotate into content;

    }
}
