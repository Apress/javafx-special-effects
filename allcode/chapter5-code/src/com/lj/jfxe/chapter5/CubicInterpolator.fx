/*
 * CubicInterpolator.fx
 *
 * Created on Sep 8, 2009, 1:57:29 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.SimpleInterpolator;

/**
 * @author lucasjordan
 */

public class CubicInterpolator extends SimpleInterpolator {
    public var a = 1.0 on replace{
        c = 1.0 - a -b;
    }
    public var b = 1.0 on replace{
        c = 1.0 - a -b;
    }
    var c:Number = 1.0 - a -b;

    public override function curve(fraction:Number):Number{
        return (a*fraction*fraction*fraction + b*fraction*fraction + c*fraction);
    }

}