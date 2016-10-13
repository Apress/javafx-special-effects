/*
 * FireballEmitter.fx
 *
 * Created on Sep 24, 2009, 2:18:24 PM
 */

package org.lj.jfxe.chapter10;

import javafx.animation.*;
import javafx.scene.effect.ColorAdjust;

/**
 * @author lucasjordan
 */

public class FireballEmitter extends Emitter{
    var emitTimeline = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: KeyFrame{
            time: 2s
            action: emit;
        }
    }
    function emit():Void{
        var fireball = Fireball{
                translateX: 100 + Main.random.nextInt(440)
                translateY: -30
                effect: ColorAdjust{
                    hue: Main.randomFromNegToPos(1.0);
                }
            }
        Main.addWoldNode(fireball);
        Main.addEmitter(fireball);
    }
    public override function play():Void{
        emitTimeline.play();
    }
    public override function stop():Void{
        emitTimeline.stop();
    }
}
