/*
 * WindupOvershootInterpolator.fx
 *
 * Created on Sep 10, 2009, 9:08:47 AM
 */

package com.lj.jfxe.chapter5;

/**
 * @author lucasjordan
 */

public var WINDUP_OVERSHOOT = PolynomialInterpolator{
    coefficients: [-1.25564,6.842106,-4.586466]
}
public var OVERSHOOT = PolynomialInterpolator{
    coefficients: [0.6992483,2.581203,-2.1804514]
}
public var WINDUP = PolynomialInterpolator{
    coefficients: [-0.95488644,4.135338,-2.1804514]
}

public class WindupOvershootInterpolator extends PolynomialInterpolator{

}
