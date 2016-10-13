/*
 * Bars.fx
 *
 * Created on Oct 29, 2009, 7:06:04 PM
 */

package org.lj.jfxe.chapter9;

import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.effect.*;

/**
 * @author lucasjordan
 */

public class Bars extends AudioVisualization{
    init{
        for (i in [0..<sizeof(soundPlayer.levels)]){
            var rect = Rectangle{
                translateX: 500-i*25
                translateY: bind -soundPlayer.levels[i]*200
                width: 20;
                height: bind soundPlayer.levels[i]*200
                arcHeight: 10
                arcWidth: 10
                fill: Color.BLUE
                effect: ColorAdjust {
                        brightness: bind soundPlayer.levels[i] * 1.5 - .75;
                        contrast: bind soundPlayer.levels[i] * 3 + 0.25;
                        hue: bind soundPlayer.levels[i] * 1.5 - .75;
                    };
            }
            insert rect into content;
        }
        effect = Reflection{}
    }
}
