/*
 * TrivialInterpolator.fx
 *
 * Created on Sep 10, 2009, 6:08:23 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.Interpolator;

/**
 * @author lucasjordan
 */

public class TrivialInterpolator extends Interpolator{
    public override function interpolate(start:Object,end:Object,fraction:Number):Object{
        var s:Number = (start as Number);
        var e:Number = (end as Number);
        return s + (e-s)*fraction;
    }
}
