/*
 * Fireball.fx
 *
 * Created on Sep 24, 2009, 1:25:44 PM
 */

package org.lj.jfxe.chapter10;

import javafx.scene.Group;
import javafx.scene.effect.*;
import javafx.animation.*;
import net.phys2d.raw.Body;
import net.phys2d.raw.shapes.Circle;
import net.phys2d.math.Vector2f;

/**
 * @author lucasjordan
 */

public class Fireball extends Group, WorldNode, Particle, Emitter{
    var emitTimeline = Timeline{
        repeatCount: Timeline.INDEFINITE
        keyFrames: KeyFrame{
            time: 1/15.0*1s
            action: emit;
        }
    }
    init{
        blendMode = BlendMode.ADD;
        
        bodies[0] = new Body(new Circle(4), 1);
        bodies[0].setPosition(translateX, translateY);
        bodies[0].setRestitution(.9);
    }
    function emit():Void{
        var fireParticle = FireParticle{
            image: Main.cloud;
            scaleX: .5;
            scaleY: .5;
            initialSteps: 10;
            direction: 270;
            speed: 2
        }
        insert fireParticle into content;
    }
    public override function update():Void{

        var dX = translateX - bodies[0].getPosition().getX();
        var dY = translateY - bodies[0].getPosition().getY();

        translateX = bodies[0].getPosition().getX();
        translateY = bodies[0].getPosition().getY();

        for (node in content){
            node.translateX += dX;
            node.translateY += dY;
            (node as FireParticle).doStep();
        }

        if (translateX > 660){
            translateX = -20;
            bodies[0].setPosition(translateX, translateY);
        }
        if (translateX < -20){
            translateX = 660;
            bodies[0].setPosition(translateX, translateY);
        }
        if (dX == 0){
            bodies[0].adjustVelocity(new Vector2f(.2,0));
        }
        if (translateY > 500){
            Main.removeWoldNode(this);
            Main.removeEmitter(this);
        }
    }
    public override function play():Void{
       emitTimeline.play();
    }
    public override function stop():Void{
       emitTimeline.stop();
    }
}
