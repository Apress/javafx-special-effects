/*
 * Particle.fx
 *
 * Created on Jul 3, 2009, 2:16:28 PM
 */

package org.lj.jfxe.chapter2.example5;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.Group;
import javafx.util.Math;

/**
 * @author lucasjordan
 */

var random = new java.util.Random();

var cloud = Image{
    url: "{__DIR__}cloud.png"
}
public class Particle extends ImageView{
    
    public-init var initialSteps:Integer;//number of steps until removed
    public-init var startingOpacity = 1.0;
    public-init var speed:Number;//pixels per step
    public-init var fadeout = true;

    var deltaX;//change in x location per step
    var deltaY;//change in y location per step
    var stepsRemaining = initialSteps;

    init{
        image = cloud;
        smooth = true;
        translateX -= cloud.width/2.0;
        translateY -= cloud.height/2.0;
        rotate = Math.toDegrees(random.nextFloat()*2.0*Math.PI);


        opacity = startingOpacity;
        //radom direction in radians
        var theta = random.nextFloat()*2.0*Math.PI;
        deltaX = Math.cos(theta)*speed;
        deltaY = Math.sin(theta)*speed;
    }

    package function doStep(){
        //remove particle if particle has expired
        if (--stepsRemaining == 0){
            delete this from (parent as Group).content;
        }
        //advance particle's location
        translateX += deltaX;
        translateY += deltaY;
        if (fadeout){
            opacity = startingOpacity*(stepsRemaining as Number)/(initialSteps as Number);
        }
        rotate += 4;
    }
}
