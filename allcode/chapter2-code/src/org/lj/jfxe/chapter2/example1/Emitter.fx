/*
 * Emitter.fx
 *
 * Created on Jul 3, 2009, 2:14:24 PM
 */

package org.lj.jfxe.chapter2.example1;

import javafx.scene.Group;
import javafx.animation.Timeline;
import javafx.animation.KeyFrame;

/**
 * @author lucasjordan
 */

public class Emitter extends Group{

    //specifies when a new particle should be added to the scene
    var emitTimeline = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: KeyFrame{
                    time: .05*1s
                    action: emit
                   }
    }
    //animates the particles.
    var animator = Timeline{
    repeatCount: Timeline.INDEFINITE;
    keyFrames: KeyFrame{
        time: 1.0/30.0*1s
        action:function(){
            for (p in content){
                (p as Particle).doStep();
                }
            }
        }
    }

    init{
        //start emitting
        emitTimeline.play();
        animator.play();
    }

    //called when a new particle should be added.
    function emit():Void{
        insert Particle{} into content;
    }

}
