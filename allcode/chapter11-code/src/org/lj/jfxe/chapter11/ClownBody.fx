/*
 * ClownBody.fx
 *
 * Created on Nov 5, 2009, 5:34:35 PM
 */

package org.lj.jfxe.chapter11;

import javafx.scene.*;
import net.phys2d.raw.Body;
import javafx.util.Math;
import net.phys2d.math.Vector2f;
/**
 * @author lucasjordan
 */

public class ClownBody {
    public-init var startingPower:Number;
    public-init var clown:Node;
    public var body:Body;

    init{
        body = new Body(new net.phys2d.raw.shapes.Circle(4), 1);
        body.setPosition(clown.translateX, clown.translateY);
        
        var rotationInRadians = Math.toRadians(clown.rotate);

        var x = Math.cos(rotationInRadians) * startingPower;
        var y = Math.sin(rotationInRadians) * startingPower;

        body.adjustVelocity(new Vector2f(x,y));
    }

    public function update():Void{
        clown.translateX = body.getPosition().getX();
        clown.translateY = body.getPosition().getY();
        var velocity = body.getVelocity();
        var vX = velocity.getX();
        var vY = velocity.getY();
        var tanTheta = vY/vX;
        var arcTan = Math.atan(tanTheta);
        clown.rotate = Math.toDegrees(arcTan);
    }
}
