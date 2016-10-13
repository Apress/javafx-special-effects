/*
 * WorldActor.fx
 *
 * Created on Aug 26, 2009, 4:30:38 PM
 */

package org.lj.jfxe.chapter6;

import net.phys2d.raw.Body;
import net.phys2d.raw.Joint;

/**
 * @author lucasjordan
 */

public mixin class WorldNode {
    public var bodies:Body[];
    public var joints:Joint[];
    public abstract function update():Void;
}
