/*
 * Ball.fx
 *
 * Created on Aug 26, 2009, 4:31:18 PM
 */

package org.lj.jfxe.chapter6;

import net.phys2d.raw.Body;
import javafx.scene.effect.*;
import javafx.scene.effect.light.*;
import javafx.scene.paint.*;
import javafx.util.*;
import javafx.scene.Group;
import javafx.scene.shape.Arc;

/**
 * @author lucasjordan
 */
var lighting = Lighting {
    light: DistantLight { azimuth: -135 elevation: 85  }
    surfaceScale: 5
}
public class Ball extends Group, WorldNode{
    public var radius = 10.0;
    var arcs = Group{};

    init{
       var arc1 = Arc{
            radiusX: radius
            radiusY: radius
            startAngle: 0;
            length: 180
            fill: Color.WHITE
            }

        var arc2 = Arc{
            radiusX: radius
            radiusY: radius
            startAngle: 180;
            length: 180
            fill: Color.BLUE
            }

        insert arc2 into arcs.content;
        insert arc1 into arcs.content;
        
        effect = lighting;
       
       bodies[0] = new Body(new net.phys2d.raw.shapes.Circle(radius), radius);
       bodies[0].setPosition(translateX, translateY);
       bodies[0].setRestitution(1.0);
       bodies[0].setCanRest(true);
       bodies[0].setDamping(0.2);

       insert arcs into content;
    }
    public override function update():Void{
       translateX = bodies[0].getPosition().getX();
       translateY = bodies[0].getPosition().getY();
       arcs.rotate = Math.toDegrees(bodies[0].getRotation());
    }
}
