/*
 * CircleBody.fx
 *
 * Created on Nov 5, 2009, 6:42:53 PM
 */

package org.lj.jfxe.chapter11;

import javafx.scene.Node;
import net.phys2d.raw.StaticBody;

/**
 * @author lucasjordan
 */

public class StaticCircleBody {
    public var node:Node;
    public var body:StaticBody;

    init{
        var radius = node.boundsInParent.width/2.0;
        body = new StaticBody(new net.phys2d.raw.shapes.Circle(radius));
        body.setPosition(node.translateX, node.translateY);
    }

}
