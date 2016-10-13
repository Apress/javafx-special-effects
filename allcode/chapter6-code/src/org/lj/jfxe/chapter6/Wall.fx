/*
 * Wall.fx
 *
 * Created on Aug 26, 2009, 4:52:00 PM
 */

package org.lj.jfxe.chapter6;

import javafx.scene.shape.Rectangle;
import net.phys2d.raw.StaticBody;
import javafx.scene.Group;
import javafx.scene.effect.*;
import javafx.scene.effect.light.*;
import javafx.scene.paint.*;
import javafx.util.Math;

/**
 * @author lucasjordan
 */
var lighting = Lighting {
    light: DistantLight { azimuth: -135 elevation: 85  }
    surfaceScale: 5
}
public class Wall extends Group, WorldNode{
    public var width:Number;
    public var height:Number;

    init{
        var rectangle = Rectangle{
            width: width;
            height: height;
            translateX: width/-2.0;
            translateY: height/-2.0;
            
            fill: Color.RED
        }
        effect = lighting;
        
        var shape = new net.phys2d.raw.shapes.Box(width,height);
        bodies[0] = new StaticBody(shape);
        bodies[0].setRotation(Math.toRadians(rotate));
        bodies[0].setPosition(translateX, translateY);
        bodies[0].setRestitution(0.5);

        insert rectangle into content;
    }
    public override function update():Void{
        //do nothing, walls don't move.
    }
}
