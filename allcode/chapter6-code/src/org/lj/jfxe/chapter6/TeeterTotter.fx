/*
 * TetterTauter.fx
 *
 * Created on Aug 31, 2009, 1:21:19 PM
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

public class TeeterTotter extends Group, WorldNode{
    var barWidth = 300.0;
    var barHieght = 5.0;

    var crossbar = Rectangle{
        width: barWidth;
        height: barHieght;
        fill: Color.GREEN;
        arcWidth: 3
        arcHeight: 3
    }

    init{
        bodies[0] = new Body(new net.phys2d.raw.shapes.Box(barWidth,barHieght),50);
        bodies[0].setPosition(translateX, translateY);
        bodies[0].setRestitution(0.5);


        var points:Vector2f[];
        insert new Vector2f(0,0) into points;
        insert new Vector2f(20,30) into points;
        insert new Vector2f(-20,30) into points;

        
        bodies[1] = new StaticBody(new net.phys2d.raw.shapes.ConvexPolygon(points));
        bodies[1].setPosition(translateX, translateY);

        joints[0] = new DistanceJoint(bodies[0], bodies[1], new Vector2f(0,barHieght/2.0), new Vector2f(0,0), 0);

        var fulcrum = javafx.scene.shape.Polygon{
            fill: Color.BLUE;
            translateX: bodies[1].getPosition().getX()-translateX;
            translateY: bodies[1].getPosition().getY()-translateY;
        }
        for (vector in points){
            insert vector.getX() into fulcrum.points;
            insert vector.getY() into fulcrum.points;
        }
        insert fulcrum into content;
        

        insert crossbar into content;

        effect = lighting;
        
        update();
    }

    public override function update():Void{
        crossbar.rotate = Math.toDegrees(bodies[0].getRotation());
        crossbar.translateX = (bodies[0].getPosition().getX() - barWidth/2.0) - translateX;
        crossbar.translateY = (bodies[0].getPosition().getY() - barHieght/2.0) - translateY;

    }
}
