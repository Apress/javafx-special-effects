/*
 * ExampleNodeB.fx
 *
 * Created on Jul 15, 2009, 5:30:08 PM
 */

package org.lj.jfxe.chapter3;

import javafx.scene.Group;
import javafx.scene.shape.Rectangle;
import javafx.scene.layout.*;
import javafx.scene.paint.*;
import javafx.scene.control.*;
import javafx.geometry.HPos;

/**
 * @author lucasjordan
 */

public class ExampleNodeB extends Group{

    var toggleGroup = ToggleGroup{}

    init {

        insert
            Rectangle{
                width: 320
                height: 240
                stroke: Color.RED
                strokeWidth: 6
                arcHeight: 24
                arcWidth: 24
            } into content;
        insert
            VBox{
                spacing: 10
                translateX: 30
                translateY: 30
                hpos: HPos.CENTER
                content: [
                    Label{text:"Please Configure Your Preferences", textFill: Color.WHITESMOKE},
                    Tile{
                        vgap: 4
                        columns: 1
                        content: [
                            Label{text:"Volume", textFill: Color.WHITESMOKE},
                            Slider{
                                min: 1
                                max: 10
                                value: 6
                            },
                            Label{text:"Gain", textFill: Color.WHITESMOKE},
                            Slider{
                                min: 1
                                max: 10
                                value: 3
                            },
                            RadioButton{
                                selected: true
                                toggleGroup: toggleGroup
                                graphic: Label{text:"Repeat All", textFill: Color.WHITESMOKE}
                            },
                            RadioButton{
                                toggleGroup: toggleGroup
                                graphic: Label{text:"Repeat 1", textFill: Color.WHITESMOKE}
                            },
                            CheckBox{
                                graphic: Label{text:"Display Title", textFill: Color.WHITESMOKE}
                            }

                            ]
                        }
                    ]
            } into content;   
    }
}
