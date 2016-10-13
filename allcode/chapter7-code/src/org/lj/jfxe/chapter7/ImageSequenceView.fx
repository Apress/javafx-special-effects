/*
 * ImageSequenceView.fx
 *
 * Created on Sep 21, 2009, 1:10:28 PM
 */

package org.lj.jfxe.chapter7;

import javafx.scene.Group;
import javafx.scene.image.*;

/**
 * @author lucasjordan
 */

public class ImageSequenceView extends Group{
    public-init var imageSequence:ImageSequence;
    public var currentImage:Integer on replace {
        updateImage()
    }

    var lastImage:Integer = 0;
    init{

        for (i in [0..imageSequence.imageCount-1]){
            var image = imageSequence.images[i];

            var imageView = ImageView{
                image: image;
                translateX: image.width/-2.0
                translateY: image.height/-2.0
                visible: false;
            }

            insert imageView into content;
        }
        currentImage = 0;
        updateImage();
    }

    function updateImage():Void{
        currentImage = currentImage mod imageSequence.imageCount;

        content[lastImage].visible = false;
        var currentImageView = content[currentImage];

        currentImageView.visible = true;

        lastImage = currentImage;
    }
}
