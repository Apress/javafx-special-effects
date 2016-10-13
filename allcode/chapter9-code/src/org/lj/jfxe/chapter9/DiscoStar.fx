/*
 * Star.fx
 *
 * Created on Oct 31, 2009, 2:35:48 PM
 */

package org.lj.jfxe.chapter9;

import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.effect.*;
import javafx.animation.*;
import javafx.date.DateTime;
import java.util.Random;

/**
 * @author lucasjordan
 */

public class DiscoStar extends AudioVisualization{
    var lastEmit = DateTime{}

    var showFlare = bind soundPlayer.hiChannels on replace {
        if (soundPlayer.hiChannels > 3){
            var now = DateTime{};
            if (now.instant - lastEmit.instant > 100){
                lastEmit = now;
                addFlare();
            }
        }
    }

    var anim = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1/30*1s
            action: function(){
                for (node in content){
                    (node as Flare).update();
                }

            }
        }
    }

    init{
        anim.play();
        blendMode = BlendMode.ADD;
    }

    function addFlare():Void{
       var flare = Flare{}
        insert flare into content;
    }
}
