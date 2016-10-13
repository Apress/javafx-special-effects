/*
 * QuadraticInterpolator.fx
 *
 * Created on Sep 8, 2009, 12:21:20 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.SimpleInterpolator;

/**
 * @author lucasjordan
 */

public class QuadraticInterpolator extends SimpleInterpolator {
    public var a = 1.0 on replace{
        b = 1.0 - a;
    }
    var b:Number = 1.0 - a;

    public override function curve(fraction:Number):Number{
        return (a*fraction*fraction + b*fraction);
    }
}
