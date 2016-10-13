/*
 * Wave.fx
 *
 * Created on Oct 31, 2009, 4:03:40 PM
 */

package org.lj.jfxe.chapter9;

import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.effect.*;
import javafx.animation.*;
import javafx.date.DateTime;
import java.util.Random;
import javafx.scene.paint.*;

/**
 * @author lucasjordan
 */

public class Wave extends AudioVisualization{

    var count = 0;
    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1/30*1s
            action: function(){
                count++;
                for (node in content){
                    (node as WaveDot).update();
                }
                if (count mod 30 == 0){
                    emit();
                }
            }
        }
    }

    init{
        anim.play();
    }

    function emit():Void{
        if (soundPlayer.isPlaying()){
            insert WaveDot{
                radius: 3
                translateY: -soundPlayer.lowChannels*100;
                fill: Color.CRIMSON
                effect: ColorAdjust{
                      hue: -1 + soundPlayer.midChannels/3.5
                }
            } into content;
        }
    }
}
