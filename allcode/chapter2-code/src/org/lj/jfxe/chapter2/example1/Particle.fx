/*
 * Particle.fx
 *
 * Created on Jul 3, 2009, 2:16:28 PM
 */

package org.lj.jfxe.chapter2.example1;

import javafx.scene.shape.Circle;
import javafx.scene.paint.Color;
import javafx.scene.Group;

/**
 * @author lucasjordan
 */

//provices random numbers for direction of particle
var random = new java.util.Random();
public class Particle extends Circle{
    
    var initialSteps = 100;//number of steps until removed
    var deltaX;//change in x location per step
    var deltaY;//change in y location per step

    init{
        radius = 5;
        fill = Color.RED;

        //Set radnom direction, squere technique.
        deltaX = 1.0 - random.nextFloat()*2.0;
        deltaY = 1.0 - random.nextFloat()*2.0;
    }

    package function doStep(){

        //remove particle if particle has expired
        if (--initialSteps == 0){
            delete this from (parent as Group).content;
        }

        //advance particle's location
        translateX += deltaX;
        translateY += deltaY;
    }
}
