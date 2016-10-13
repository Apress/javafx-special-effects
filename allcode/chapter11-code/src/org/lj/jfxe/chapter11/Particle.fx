/*
 * Particle.fx
 *
 * Created on Jul 3, 2009, 2:16:28 PM
 */

package org.lj.jfxe.chapter11;

import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.Group;
import javafx.util.Math;

/**
 * @author lucasjordan
 */

//provices random numbers for direction of particle
var random = new java.util.Random();

var defaultImage = Image{
    url: "{__DIR__}star.png"
}
public class Particle extends ImageView{
    
    public-init var initialSteps:Integer;//number of steps until removed
    public-init var startingOpacity = 1.0;
    public-init var speed:Number;//pixels per step
    public-init var fadeout = true;
    public-init var direction = -90.0;
    public-init var directionVariation = 10.0;
    public-init var gravity = 0.0;

    var deltaX;//change in x location per step
    var deltaY;//change in y location per step
    var stepsRemaining = initialSteps;

    init{
        if (image == null){
            image = defaultImage;
        }
        smooth = true;
        translateX -= image.width/2.0;
        translateY -= image.height/2.0;

        rotate = Math.toDegrees(random.nextFloat()*2.0*Math.PI);


        opacity = startingOpacity;
        //radom direction in radians
        var startingDirection = direction + Main.randomFromNegToPos(directionVariation);
        var theta = Math.toRadians(startingDirection);//random.nextFloat()*2.0*Math.PI;
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
        deltaY += gravity;
        
        if (fadeout){
            opacity = startingOpacity*(stepsRemaining as Number)/(initialSteps as Number);
        }
        rotate += 4;
    }
}
