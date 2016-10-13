/*
 * Pendulum.fx
 *
 * Created on Aug 31, 2009, 11:14:27 AM
 */

package org.lj.jfxe.chapter6;

import javafx.scene.Group;
import javafx.scene.shape.*;
import net.phys2d.raw.StaticBody;
import net.phys2d.raw.Body;
import javafx.scene.paint.Color;
import net.phys2d.raw.*;
import net.phys2d.math.Vector2f;
import javafx.util.Math;
import javafx.scene.effect.*;
import javafx.scene.effect.light.*;

/**
 * @author lucasjordan
 */
var lighting = Lighting {
    light: DistantLight { azimuth: -135 elevation: 85  }
    surfaceScale: 5
}

public class Pendulum extends Group, WorldNode{

    public-init var distance = 150.0;
    public-init var angle = 0.0;

    var topNode = Circle{
        radius: 4
        fill: Color.AQUA;
    }
    var bottomNode = Circle{
        radius: 16
        fill: Color.SILVER;
        effect: lighting;
    }
    var shaft = Line{
        fill: Color.CORAL;
        stroke: Color.CORAL;
    }

    init{
        bodies[0] = new StaticBody( new net.phys2d.raw.shapes.Circle(topNode.radius));
        bodies[0].setPosition(translateX, translateY);
        bodies[1] = new Body(new net.phys2d.raw.shapes.Circle(bottomNode.radius), 10);
        bodies[1].setRestitution(.99);
        var a = Math.sqrt((distance*distance)/2.0);

        var x = Math.sin(Math.toRadians(angle))*distance;
        var y = Math.cos(Math.toRadians(angle))*distance;
        bodies[1].setPosition(translateX+x, translateY+y);

        joints[0] = new DistanceJoint(bodies[0], bodies[1], new Vector2f(0,0), new Vector2f(0,0), distance);

        shaft.startX = bodies[0].getPosition().getX() - translateX;
        shaft.startY = bodies[0].getPosition().getY() - translateY;

        insert shaft into content;
        insert topNode into content;
        insert bottomNode into content;
        update();

    }

    public override function update():Void{
        shaft.endX = bodies[1].getPosition().getX() - translateX;
        shaft.endY = bodies[1].getPosition().getY() - translateY;

        bottomNode.translateX = bodies[1].getPosition().getX() - translateX;
        bottomNode.translateY = bodies[1].getPosition().getY()  - translateY;
    }
}
