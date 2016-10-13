/*
 * MediaLoader.fx
 *
 * Created on Aug 10, 2009, 3:47:54 PM
 */

package org.lj.jfxe.chapter7;

import javafx.scene.image.Image;
import java.util.*;

/**
 * @author lucasjordan
 */

def instance:MediaLoader = MediaLoader{};

public function image(classpath:String, background:Boolean):Image{
    instance.getImage(classpath, background);
}

public function imageSequence(classpathBase:String,imageCount:Integer, background:Boolean):ImageSequence{
    return instance.getImageSequence(classpathBase, imageCount, background);
}

public class MediaLoader {
    var imageMap:Map = new HashMap();
    var sequenceMap:Map = new HashMap();

    public function getImage(classpath:String, background:Boolean):Image{
        var image:Image = imageMap.get(classpath) as Image;
        if (image == null){
            image = Image{
                url: this.getClass().getResource(classpath).toString();
                smooth: true
                backgroundLoading: background;
            }
            imageMap.put(classpath, image);
        }
        if (image == null){
            println("WARNING: image not found at: {classpath}");
        }

        return image;
    }

    public function getImageSequence(classpathBase:String,imageCount:Integer, background:Boolean):ImageSequence{
        var key = "{classpathBase}{imageCount}";
        var sequence:ImageSequence = sequenceMap.get(key) as ImageSequence;

        if (sequence == null){
            sequence = ImageSequence{
                classpathBase:classpathBase
                imageCount:imageCount
                backgroundLoading: background;
            };
            sequenceMap.put(key, sequence);
        }

        return sequence;
    }
}

