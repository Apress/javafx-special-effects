/*
 * SparkEmitter.fx
 *
 * Created on Sep 24, 2009, 10:36:48 AM
 */

package org.lj.jfxe.chapter10;

import javafx.scene.Group;
import javafx.scene.image.*;
import javafx.animation.*;
import net.phys2d.raw.World;
import javafx.scene.effect.ColorAdjust;

/**
 * @author lucasjordan
 */

public class SparkEmitter extends Emitter{
    public var x:Number;
    public var y:Number;
    
    var cloudTimeline:Timeline = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: KeyFrame{
            time: 1/5.0*1s;
            action: emitCloud;
        }
    }
    var sparkTimeline:Timeline = Timeline{
        repeatCount: Timeline.INDEFINITE;
        keyFrames: KeyFrame{
            time: 1/4.0*1s;
            action: emitSpark;
        }
    }
    function emitCloud():Void{
        var particle = PhysicsParticle{
            scaleX: .8
            scaleY: .8
            translateX: x;
            translateY: y;
            image: Main.cloud;
            radius: 4;
            weight: 1;
            totalSteps: 10 + Main.random.nextInt(30);
            effect: ColorAdjust{
                hue: .3
            }
            fadeInterpolator: Interpolator.LINEAR;
        }
        Main.addWoldNode(particle);
    }
    
    function emitSpark():Void{
        var size:Number = 2.0 + Main.random.nextFloat()*3.0;
        var direction = 225 + Main.random.nextInt(90);
        var speed = Main.random.nextInt(50);
        var particle = PhysicsParticle{
            scaleX: size/11.0
            scaleY: size/11.0
            translateX: x;
            translateY: y;
            image: Main.spark;
            radius: 5;
            weight: 1;
            startingSpeed: speed
            startingDirection: direction
            totalSteps: 1/size*400
            effect: ColorAdjust{
                hue: .3
            }
            fadeInterpolator: Interpolator.SPLINE(0.0, .8, 0.0, .8)

        }
        Main.addWoldNode(particle);
    }

    public override function play():Void{
       cloudTimeline.play();
        sparkTimeline.play();
    }

    public override function stop():Void{
        cloudTimeline.stop();
        sparkTimeline.stop();
    }
}
