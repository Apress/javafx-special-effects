/*
 * StepInterpolator.fx
 *
 * Created on Sep 9, 2009, 4:11:19 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.Interpolator;
/**
 * @author lucasjordan
 */

public class StepInterpolator extends Interpolator{

    public var interpolator = Interpolator.LINEAR;
    public var steps = 7;

    public override function interpolate(start:Object,end:Object,fraction:Number):Object{
        var s = (start as Number);
        var e = (end as Number);
        var range = e-s;

        var value:Number = interpolator.interpolate(start, end, fraction) as Number;
        var stepSize = range/steps;
        var total = e;
        for (r in [1..steps-1]){
            if (value < stepSize*(r)){
                total = (r-1)*(range/(steps - 1.0));
                break;
            }
        }
        
        return total;
    }
}
