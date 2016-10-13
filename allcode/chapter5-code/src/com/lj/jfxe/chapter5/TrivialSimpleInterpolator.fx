/*
 * TrivialSimpleInterpolator.fx
 *
 * Created on Sep 10, 2009, 6:29:30 PM
 */

package com.lj.jfxe.chapter5;

import javafx.animation.SimpleInterpolator;

/**
 * @author lucasjordan
 */

public class TrivialSimpleInterpolator extends SimpleInterpolator{

    public override function curve(fraction:Number):Number{
        return fraction;
    }

}
