/*
 * Main.fx
 *
 * Created on Jul 3, 2009, 2:12:55 PM
 */

package org.lj.jfxe.chapter2.example1;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.paint.Color;

/**
 * @author lucasjordan
 */

Stage {
    title: "Chapter 2 - Example 1"
    width: 640
    height: 480
    scene: Scene {
        fill: Color.BLACK
        content: [
            Emitter{
                translateX: 320
                translateY: 240
            }
        ]
    }
}