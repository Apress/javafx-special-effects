/*
 * CLFMain.fx
 *
 * Created on Nov 10, 2009, 4:35:00 PM
 */

package org.lj.jfxe.chapter1;

import javafx.stage.Stage;
import javafx.scene.Scene;

/**
 * @author lucasjordan
 */



public function run():Void{
    Stage {
        title: "Java FX - Custom Look and Feel"
        scene: Scene {
            content: CustomLookAndFeelUI{}
        }
    }
}

