/*
 * Peg.fx
 *
 * Created on Sep 24, 2009, 1:46:59 PM
 */

package org.lj.jfxe.chapter10;

import javafx.scene.shape.Circle;
import net.phys2d.raw.StaticBody;
import javafx.scene.paint.Color;

/**
 * @author lucasjordan
 */

public class Peg extends WorldNode, Circle{
    init{
        bodies[0] = new StaticBody(new net.phys2d.raw.shapes.Circle(radius));
        bodies[0].setPosition(translateX, translateY);
        bodies[0].setRestitution(1.0);
        fill = Color.GRAY;
    }
    public override function update():Void{
        //static bodies do not move
    }
}
