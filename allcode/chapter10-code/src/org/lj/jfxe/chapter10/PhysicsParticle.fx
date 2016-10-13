/*
 * PhysicsParticle.fx
 *
 * Created on Sep 23, 2009, 6:11:08 PM
 */

package org.lj.jfxe.chapter10;

import javafx.scene.Group;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import net.phys2d.raw.Body;
import net.phys2d.raw.shapes.Circle;
import javafx.util.Math;
import java.util.Random;
import net.phys2d.math.Vector2f;
import javafx.animation.Interpolator;

/**
 * @author lucasjordan
 */
public class PhysicsParticle extends Group, WorldNode, Particle{
    public-init var image:Image;
    public-init var radius:Number;
    public-init var weight:Number;
    public-init var totalSteps:Number = 100;
    public-init var startingDirection:Number;
    public-init var startingSpeed:Number;
    public-init var fadeInterpolator:Interpolator=Interpolator.LINEAR;
    var stepsLeft = totalSteps;

    init{
        insert ImageView{
            translateX: image.width/-2.0;
            translateY: image.height/-2.0;
            image: image;
        } into content;

        var body = new Body(new Circle(radius), weight);
        body.setRestitution(.8);

        body.setPosition(translateX, translateY);
        body.setRotation(Math.toRadians(rotate));
        body.adjustAngularVelocity(5.0);

        var theta = Math.toRadians(startingDirection);
        body.adjustVelocity(new Vector2f(Math.cos(theta)*startingSpeed, Math.sin(theta)*startingSpeed));

        insert body into bodies;
    }

    public override function update():Void{
        stepsLeft--;
        if (stepsLeft <= 0){
           Main.removeWoldNode(this)
        }
        var ratio = stepsLeft/totalSteps;
        if (ratio < 0){
             ratio = 0;
        }

        opacity = fadeInterpolator.interpolate(0.0, 1.0, ratio) as Number;
        

        translateX = bodies[0].getPosition().getX();
        translateY = bodies[0].getPosition().getY();
        rotate = Math.toDegrees(bodies[0].getRotation());
    }
}
