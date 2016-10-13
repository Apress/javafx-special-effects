/*
 * Explosion.fx
 *
 * Created on Nov 5, 2009, 9:08:18 PM
 */

package org.lj.jfxe.chapter11;

import javafx.scene.Group;
import javafx.animation.*;
import javafx.scene.effect.*;

/**
 * @author lucasjordan
 */

public class Explosion extends Group{
    var moveSparks = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1/30*1s
            action: function(){
                for (node in content){
                    (node as Particle).doStep();
                }
            }
        }
    }
    init{
        var hue1 = ColorAdjust{
            hue: -1 + Main.random.nextDouble()*2.0;
        }
        for (i in [0..10]){
            insert Particle{
                fadeout: true
                speed: .7
                initialSteps: 200;
                direction: 0
                directionVariation: 360;
                gravity: .002
                effect: hue1;
                scaleX: .4
                scaleY: .4
            } into content;
        }
        var hue2 = ColorAdjust{
            hue: -1 + Main.random.nextDouble()*2.0;
        }
        for (i in [0..10]){
            insert Particle{
                fadeout: true
                speed: .4
                initialSteps: 200;
                direction: 0
                directionVariation: 360;
                gravity: .002
                effect: hue2;
                scaleX: .4
                scaleY: .4
            } into content;
        }
        moveSparks.play();
    }

    public function stop():Void{
        moveSparks.stop();
    }
}
