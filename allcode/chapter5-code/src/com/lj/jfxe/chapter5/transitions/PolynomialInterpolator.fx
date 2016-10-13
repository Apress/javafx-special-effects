/*
 * PolynomialInterpolator.fx
 *
 * Created on Sep 8, 2009, 3:18:56 PM
 */

package com.lj.jfxe.chapter5.transitions;

import javafx.animation.SimpleInterpolator;

/**
 * @author lucasjordan
 */

public class PolynomialInterpolator extends SimpleInterpolator{
    public var solveFor = 0 on replace{
        solve();
    }

    public var coefficients:Number[] = [1.0, 1.0, 1.0] on replace{
        solve();
    }
    
    init{
        solve();
    }


    public function solve():Void{
        //given a + b + c = 1, then c = 1 - b - c, or a = 1 - c - b
        if (solveFor != -1){
            var solvedValue = 1.0;
            for (index in [0..(sizeof coefficients)-1]){
                if (index != solveFor){
                    solvedValue -= coefficients[index];
                }
            }
            coefficients[solveFor] = solvedValue;
        }
    }

    public override function curve(fraction:Number):Number{
        var power = fraction;
        var total = 0.0;
        for (coeff in coefficients){
            total += coeff*power;
            power *= fraction;
        }
        return total;
    }
    
}
