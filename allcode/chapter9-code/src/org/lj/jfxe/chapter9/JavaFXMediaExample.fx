/*
 * JavaFXMediaExample.fx
 *
 * Created on Nov 1, 2009, 1:58:47 PM
 */

package org.lj.jfxe.chapter9;

import javafx.stage.*;
import javafx.scene.*;
import javafx.scene.paint.*;
import javafx.scene.shape.*;
import javafx.scene.*;
import javafx.animation.*;
import javafx.scene.layout.*;
import javafx.scene.control.*;
import javafx.util.*;
import javafx.geometry.*;
import javafx.fxd.Duplicator;
import javafx.scene.media.*;

/**
 * @author lucasjordan
 */



function run():Void{
    var media = Media{
        source: "file:///Users/lucasjordan/astroidE_32_0001_0031.avi"
    }
    var mediaPlayer = MediaPlayer{
        media: media;
    }
    var mediaView = MediaView{
        mediaPlayer: mediaPlayer;
    }
    
    Stage {
        title: "Chapter 9 - JavaFX Media Support"
        width: 640
        height: 480
        scene: Scene{
            content: [mediaView]
        }

    }
    
    mediaPlayer.play();
}