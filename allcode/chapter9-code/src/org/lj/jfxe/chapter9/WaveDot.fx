/*
 * WaveDot.fx
 *
 * Created on Oct 31, 2009, 4:04:06 PM
 */

package org.lj.jfxe.chapter9;

import javafx.scene.shape.Circle;
import javafx.scene.*;
import javafx.scene.effect.DropShadow;
import javafx.scene.paint.Color;

/**
 * @author lucasjordan
 */

public class WaveDot extends Circle{
    var totalSteps = 6000;
    var currentStep = totalSteps;
    var deltaX = -0.1;

    public function update():Void{
        currentStep--;
        if (currentStep == 0){
            delete this from (parent as Group).content;
        } else{
            translateX += deltaX;
        }
    }
}
