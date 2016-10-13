/*
 * Flare.fx
 *
 * Created on Oct 31, 2009, 2:59:32 PM
 */

package org.lj.jfxe.chapter9;

import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.effect.*;
import javafx.scene.*;
import javafx.scene.image.*;
import java.util.*;

/**
 * @author lucasjordan
 */
def flareImage = Image{
    url: "{__DIR__}media/flare.png"
}
def random = new Random();

public class Flare extends ImageView{
    public var totalSteps:Number = 1000;
    public var delteRotation:Number;
    var currentStep = totalSteps;

    init{
        image = flareImage;
        translateX = flareImage.width/-2.0;
        translateY = flareImage.height/-2.0;
        effect = ColorAdjust{
            hue: -1 + random.nextFloat()*2
        }
        delteRotation = random.nextFloat()*.04;
        rotate = random.nextInt(360);
    }

    public function update():Void{
        currentStep--;
        if (currentStep == 0){
            delete this from (parent as Group).content;
        } else{
            rotate += delteRotation;
            opacity = currentStep/totalSteps;
        }
    }
}
