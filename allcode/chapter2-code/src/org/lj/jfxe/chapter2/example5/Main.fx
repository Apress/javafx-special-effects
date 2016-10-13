/*
 * Main.fx
 *
 * Created on Jul 3, 2009, 2:12:55 PM
 */

package org.lj.jfxe.chapter2.example5;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.Group;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.control.Slider;
import javafx.scene.control.Label;
import javafx.scene.control.CheckBox;
import javafx.scene.text.Font;
import javafx.scene.effect.BlendMode;
import javafx.scene.control.RadioButton;
import javafx.scene.control.ToggleGroup;
import javafx.scene.input.MouseEvent;

/**
 * @author lucasjordan
 */

var particleCountLabel = Label{
    translateX: 480
    translateY: 26
    text: bind "Number of Particles: {sizeof emitter.content}"
    textFill: Color.WHITESMOKE
    width: 200
}

var frequencySlider = Slider{
    vertical: false;
    translateX: 20
    translateY: 40
    min: 0.01
    max: 0.1
    value: 0.08
    width: 200
}
var frequencyLabel = Label{
    translateX: 22
    translateY: 26
    text: bind "Emit Fequency: {frequencySlider.value} seconds";
    width: 200
    textFill: Color.WHITESMOKE
    font: Font{
      size: 10;
    }
}
var scaleSlider = Slider{
    vertical: false;
    translateX: 20
    translateY: 40 + 30
    min: .1
    max: 2.0
    value: 0.5
    width: 200
}
var scaleLabel = Label{
    translateX: 22
    translateY: 26 + 30
    text: bind "Particle Scale: {scaleSlider.value} ";
    width: 200
    textFill: Color.WHITESMOKE
    font: Font{
      size: 10;
    }
}
var speedSlider = Slider{
    vertical: false;
    translateX: 20
    translateY: 40 + 60
    min: .1
    max: 4.0
    value: 1.5
    width: 200
}
var speedLabel = Label{
    translateX: 22
    translateY: 26 + 60
    text: bind "Particle Speed: {speedSlider.value} pixels/step";
    width: 200
    textFill: Color.WHITESMOKE
    font: Font{
      size: 10;
    }
}
var durationSlider = Slider{
    vertical: false;
    translateX: 20
    translateY: 40 + 90
    min: 10
    max: 200
    value: 40
    width: 200
}
var durationLabel = Label{
    translateX: 22
    translateY: 26 + 90
    text: bind "Particle Duration: {durationSlider.value} steps";
    width: 200
    textFill: Color.WHITESMOKE
    font: Font{
      size: 10;
    }
}
var opacitySlider = Slider{
    vertical: false;
    translateX: 20
    translateY: 40 + 120
    min: 0.0
    max: 1.0
    value: 1.0
    width: 200
}
var opacityLabel = Label{
    translateX: 22
    translateY: 26 + 120
    text: bind "Particle Opacity: {opacitySlider.value} out of 1.0";
    width: 200
    font: Font{
      size: 10;
    }
    textFill: Color.WHITESMOKE
}
var fadeCheckbox = CheckBox{
    translateX: 22
    translateY: 26 + 150
    graphic: Label{
       text: "Fade Out"
       textFill: Color.WHITESMOKE
       font: Font{
         size: 10;
       }
    }
    selected: true;
}





var defaultBlendMode = Group{}.blendMode;
var blendMode:BlendMode = BlendMode.ADD;
var toggleGroup = ToggleGroup{}
var modeSelect = VBox{
    translateX: 22
    translateY: 26 + 180
    content:[
            RadioButton{
                selected: false;
                toggleGroup: toggleGroup
                onMouseClicked:function(event:MouseEvent):Void{
                    blendMode = defaultBlendMode;
                }
                graphic: Label{
                    text: "No Blend Mode"
                    textFill: Color.WHITESMOKE
                    font: Font{
                        size: 10;
                    }
                }
            },
            RadioButton{
                selected: true;
                toggleGroup: toggleGroup
                onMouseClicked:function(event:MouseEvent):Void{
                    blendMode = BlendMode.ADD;
                }
                graphic: Label{
                    text: "'ADD' Blend Mode"
                    textFill: Color.WHITESMOKE
                    font: Font{
                        size: 10;
                    }
                }

            },
            RadioButton{
                toggleGroup: toggleGroup
                onMouseClicked:function(event:MouseEvent):Void{
                    blendMode = BlendMode.MULTIPLY;
                }
                graphic: Label{
                    text: "'MULTIPLY' Blend Mode"
                    textFill: Color.WHITESMOKE
                    font: Font{
                        size: 10;
                    }
                }

            },
            RadioButton{
                toggleGroup: toggleGroup
                onMouseClicked:function(event:MouseEvent):Void{
                    blendMode = BlendMode.SCREEN;
                }
                graphic: Label{
                    text: "'SCREEN' Blend Mode"
                    textFill: Color.WHITESMOKE
                    font: Font{
                        size: 10;
                    }
                }

            }
        ]
}


var hueSlider = Slider{
    vertical: false;
    translateX: 420
    translateY: 40 + 350
    min: 0.0
    max: 2.0
    value: 0.3
    width: 200
}
var hueLabel = Label{
    translateX: 422
    translateY: 26 + 350
    text: bind "Particle Hue: {hueSlider.value - 1.0}";
    width: 200
    font: Font{
      size: 10;
    }
    textFill: Color.WHITESMOKE
}
var hueVariationSlider = Slider{
    vertical: false;
    translateX: 420
    translateY: 40 + 380
    min: 0.0
    max: 1.0
    value: 0.2
    width: 200
}
var hueVariationLabel = Label{
    translateX: 422
    translateY: 26 + 380
    text: bind "Particle Hue Vairation: {hueVariationSlider.value}";
    width: 200
    font: Font{
      size: 10;
    }
    textFill: Color.WHITESMOKE
}

var emitter = Emitter{
    blendMode: bind blendMode;
    particleScale: bind scaleSlider.value;
    particleSpeed: bind speedSlider.value;
    particleDuration: bind (durationSlider.value as Integer);
    particleOpacity: bind opacitySlider.value;
    particleFadeout: bind fadeCheckbox.selected;
    frequency: bind frequencySlider.value * 1s
    particleHue: bind hueSlider.value - 1.0;
    particleHueVariation: bind hueVariationSlider.value;
    translateX: 320
    translateY: 240
}

Stage {
    title: "Chapter 2 - Example 5"
    width: 640
    height: 480
    scene: Scene {
        fill: Color.BLACK
        content: [
            emitter,
            particleCountLabel,
            frequencyLabel,
            frequencySlider,
            scaleLabel,
            scaleSlider,
            speedLabel,
            speedSlider,
            durationLabel,
            durationSlider,
            opacityLabel,
            opacitySlider,
            fadeCheckbox,
            modeSelect,
            hueSlider,
            hueLabel,
            hueVariationSlider,
            hueVariationLabel
        ]
    }
}