/*
 * ImageSequence.fx
 *
 * Created on Sep 21, 2009, 1:11:03 PM
 */

package org.lj.jfxe.chapter7;

import javafx.scene.image.*;

/**
 * @author lucasjordan
 */

public class ImageSequence {
    public-init var classpathBase:String;
    public-init var imageCount:Integer;
    public-init var backgroundLoading:Boolean = false;
    
    public var images:Image[];

    init{
        for (i in [1..imageCount]){
            var classpath = "{classpathBase}{numberToString(i)}.png";
            insert MediaLoader.image(classpath, backgroundLoading) into images;
        }
    }

    function numberToString(i:Integer):String{
        if (i < 10){
            return "000{i}";
        } else if (i < 100){
            return "00{i}";
        } else if (i < 1000){
            return "0{i}"
        }
        return "{i}"
    }

    public function progress():Number{
        var totalProgress = 0.0;
        for (i in [0..sizeof(images)]){
            totalProgress += images[i].progress;
        }
        return totalProgress/sizeof(images);
    }
}
