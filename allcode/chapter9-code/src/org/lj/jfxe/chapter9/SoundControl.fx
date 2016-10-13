/*
 * SoundControl.fx
 *
 * Created on Oct 29, 2009, 7:12:30 PM
 */

package org.lj.jfxe.chapter9;

import javafx.scene.control.Button;
import javafx.scene.shape.*;
import javafx.scene.paint.*;
import javafx.scene.input.MouseEvent;
import javafx.scene.*;


/**
 * @author lucasjordan
 */
def grayGradient = LinearGradient{
                    startX: .5
                    endX: .5
                    startY: 0
                    endY: 1.0
                stops: [Stop{
                    offset:0.0
                    color:Color.LIGHTGRAY
                },Stop{
                    offset:1.0
                    color:Color.DARKGRAY
                }       ]
            }
public class SoundControl extends AudioVisualization{

    var playButton:Button;

    init{

        var background = Rectangle{
            width: 400
            height: 40
            arcHeight: 10
            arcWidth: 10
            fill: grayGradient
            opacity: .3
        }
        insert background into content;


        playButton = Button{
            translateX: 13
            translateY: 8
            action: buttonClicked;
            text: "Play";
        }
        insert playButton into content;

        var group = Group{
            translateX: 80
            translateY: 15
            onMouseReleased:mouseReleased;
            onMouseDragged:mouseDragged;
          }
        insert group into content;
        
        var track = Rectangle{
            width: 300
            height: 8
            arcWidth: 8
            arcHeight: 8
            fill: grayGradient
            strokeWidth: 2
            stroke: Color.web("#339afc");
        }

        insert track into group.content;

        var playhead = Circle{
            translateY: 4
            translateX: bind calculateLocation(soundPlayer.currentTime,dragLocation);
            radius: 8
            fill: grayGradient
            strokeWidth: 2
            stroke: Color.web("#339afc");
        }
        insert playhead into group.content;

    }

    var mouseIsDragging:Boolean = false;
    var dragLocation:Number;

    function calculateLocation(currentTime:Duration,dragX:Number):Number{
        var rawLocation:Number;
        if (mouseIsDragging){
            rawLocation = dragX;
        } else{
            rawLocation = currentTime/soundPlayer.songDuration*300;
        }
        if (rawLocation < 0){
            return 0
        } else if (rawLocation > 300){
            return 300
        } else {
            return rawLocation
        }
    }
    function buttonClicked():Void{
        if (soundPlayer.isPlaying()){
            soundPlayer.pause();
            playButton.text = "Play";
        } else {
            soundPlayer.play();
            playButton.text = "Pause";
        }
    }
    function mouseReleased(event:MouseEvent):Void{
        mouseIsDragging = false;
        soundPlayer.setTime(event.x/300.0*soundPlayer.songDuration);
    }
    function mouseDragged(event:MouseEvent):Void{
        mouseIsDragging = true;
        dragLocation = event.x;
    }
}
