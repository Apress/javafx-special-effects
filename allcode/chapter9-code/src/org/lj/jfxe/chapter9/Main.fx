/*
 * Main.fx
 *
 * Created on Sep 20, 2009, 4:21:16 PM
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

/**
 * @author lucasjordan
 */
var soundPlayer = SoundPlayer{
    url: "{__DIR__}media/01 One Sound.mp3";
}

var bars = Bars{
    translateX: 50
    translateY: 400
    soundPlayer:soundPlayer
    visible: bind barsButton.selected
}
var barsButton = CheckBox{
        graphic: Label{text: "Show Bars", textFill: Color.WHITESMOKE}
}
var disco = DiscoStar{
    translateX: 320
    translateY: 240
    soundPlayer:soundPlayer
    visible: bind discoButton.selected
}
var discoButton = CheckBox{
        graphic: Label{text: "Show Disco", textFill: Color.WHITESMOKE}
}
var wave = Wave{
    translateX: 620
    translateY: 380
    soundPlayer:soundPlayer
    visible: bind waveButton.selected
}
var waveButton = CheckBox{
        graphic: Label{text: "Show Wave", textFill: Color.WHITESMOKE}
}
var scene = Scene {
    fill: Color.BLACK
    content: [
        SoundControl{
            translateX: 30
            translateY: 30
            soundPlayer:soundPlayer
        }, wave, disco, bars
    ]
}
function run():Void{
    var vbox = VBox{
        translateX: 500
        translateY: 50
        content: [barsButton, discoButton, waveButton]
    }
    insert vbox into scene.content;
    Stage {
        title: "Chapter 9"
        width: 640
        height: 480
        scene: scene
    }
    barsButton.selected = true;
}
