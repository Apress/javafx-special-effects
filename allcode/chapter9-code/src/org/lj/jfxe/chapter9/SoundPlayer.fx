package org.lj.jfxe.chapter9;

import java.lang.IllegalArgumentException;
import javafx.scene.media.*;
import org.lj.jfxe.chapter9.java.SoundHelper;
import java.io.File;
import java.util.Observer;
import java.util.Observable;
import java.lang.*;

/**
 * @author lucasjordan
 */

public class SoundPlayer extends Observer{

    public var volume:Number = 1.0 on replace {
        soundHelper.setVolume(volume);
    }

    public var currentTime:Duration;

    public var songDuration:Duration;

    public var url:String;
    public var file:File;
    var soundHelper:SoundHelper;

    override function update(observable: Observable, arg: Object) {
        FX.deferAction(
        function(): Void {
            for (i in [0..(soundHelper.levels.length-1)]){
                levels[i] = soundHelper.getLevel(i);
            }
            currentTime = (soundHelper.getCurrentChunk()*1.0/soundHelper.getChunkCount()*1.0)*soundHelper.getSongLengthInSeconds()*1s;
        }
        );
    }

    //20 channels
    public var levels: Number[] = for (i in [1..20]) 0.0;

    public var hiChannels:Number = bind levels[19] + levels[18] + levels[17] + levels[16] + levels[15] + levels[14] + levels[13];
    
    public var midChannels:Number = bind levels[7] + levels[8] + levels[9] + levels[10] + levels[11] + levels[12];
    
    public var lowChannels:Number = bind levels[0] + levels[1] + levels[2] + levels[3] + levels[4] + levels[5] + levels[6];


    init{
        soundHelper = new SoundHelper(url);
        soundHelper.addObserver(this);
        songDuration = soundHelper.getSongLengthInSeconds() * 1s;
        soundHelper.setVolume(volume);
        reset();
    }

    public function reset():Void{
        soundHelper.pause();
        soundHelper.setTimeInMills(0);
    }

    public function stop():Void{
        soundHelper.pause();
    }
    public function pause():Void{
        soundHelper.pause();
    }
    public function play():Void{
        soundHelper.play();
    }
    public function setTime(time:Duration){
        soundHelper.setTimeInMills(time.toMillis());
    }
    public function isPlaying():Boolean{
        return soundHelper.isPlaying();
    }
}
