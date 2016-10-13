/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.lj.jfxe.chapter9.java;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.net.URL;
import java.util.Observable;
import javax.sound.sampled.AudioFormat;
import javax.sound.sampled.AudioInputStream;
import javax.sound.sampled.AudioSystem;
import javax.sound.sampled.DataLine;
import javax.sound.sampled.SourceDataLine;

/**
 *
 * @author lucasjordan
 */
public class SoundHelper extends Observable implements SignalProcessorListener {

    private URL url = null;
    private SourceDataLine line = null;
    private AudioFormat decodedFormat = null;
    private AudioDataConsumer audioConsumer = null;
    private ByteArrayInputStream decodedAudio;
    private int chunkCount;
    private int currentChunk;
    private boolean isPlaying = false;
    private Thread thread = null;
    private int bytesPerChunk = 4096;
    private float volume = 1.0f;

    public SoundHelper(String urlStr) {
        try {
            if (urlStr.startsWith("jar:")) {
                this.url = createLocalFile(urlStr);
            } else {
                this.url = new URL(urlStr);
            }

        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
        init();
    }

    private File getMusicDir() {
        File userHomeDir = new File(System.getProperties().getProperty("user.home"));

        File synethcDir = new File(userHomeDir, ".chapter9_music_cache");
        File musicDir = new File(synethcDir, "music");

        if (!musicDir.exists()) {
            musicDir.mkdirs();
        }
        return musicDir;
    }

    private URL createLocalFile(String urlStr) throws Exception {
        File musicDir = getMusicDir();

        String fileName = urlStr.substring(urlStr.lastIndexOf('/')).replace("%20", " ");

        File musicFile = new File(musicDir, fileName);

        if (!musicFile.exists()) {
            InputStream is = new URL(urlStr).openStream();
            FileOutputStream fos = new FileOutputStream(musicFile);

            byte[] buffer = new byte[512];
            int nBytesRead = 0;

            while ((nBytesRead = is.read(buffer, 0, buffer.length)) != -1) {
                fos.write(buffer, 0, nBytesRead);
            }

            fos.close();
        }
        return musicFile.toURL();
    }

    private void init() {

        fft = new FFT(saFFTSampleSize);
        old_FFT = new float[saFFTSampleSize];
        saMultiplier = (saFFTSampleSize / 2) / saBands;

        AudioInputStream in = null;
        try {

            in = AudioSystem.getAudioInputStream(url.openStream());
            AudioFormat baseFormat = in.getFormat();

            decodedFormat = new AudioFormat(AudioFormat.Encoding.PCM_SIGNED,
                    baseFormat.getSampleRate(), 16, baseFormat.getChannels(),
                    baseFormat.getChannels() * 2,
                    baseFormat.getSampleRate(), false);


            AudioInputStream decodedInputStream = AudioSystem.getAudioInputStream(decodedFormat, in);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();

            chunkCount = 0;
            byte[] data = new byte[bytesPerChunk];
            int bytesRead = 0;
            while ((bytesRead = decodedInputStream.read(data, 0, data.length)) != -1) {
                chunkCount++;
                baos.write(data, 0, bytesRead);
            }
            decodedInputStream.close();
            decodedAudio = new ByteArrayInputStream(baos.toByteArray());

            DataLine.Info info = new DataLine.Info(SourceDataLine.class, decodedFormat);
            line = (SourceDataLine) AudioSystem.getLine(info);

            line.open(decodedFormat);
            line.start();

            audioConsumer = new AudioDataConsumer(bytesPerChunk, 10);
            audioConsumer.start(line);
            audioConsumer.add(this);

            isPlaying = false;

            thread = new Thread(new SoundRunnable());
            thread.start();

        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void setVolume(float v) {
        volume = v;
    }

    public void cleanUp() {
        if (line != null) {
            line.drain();
            line.stop();
            line.close();
        }
    }

    public void play() {
        isPlaying = true;
        line.start();
    }

    public void pause() {
        isPlaying = false;
        line.stop();
    }

    public boolean isPlaying() {
        return isPlaying;
    }

    public void setTimeInMills(double mills) {
        double songLengthInMills = getSongLengthInSeconds() * 1000;
        double ratio = mills / songLengthInMills;
        int chunk = (int) (chunkCount * ratio);
        setChunk(chunk);
    }

    public void setChunk(int chunk) {
        if (chunk >= chunkCount) {
            chunk = chunkCount - 1;
        }

        try {
            boolean wasPlaying = isPlaying;

            isPlaying = false;
            ///Thread.sleep(100);

            currentChunk = chunk;
            decodedAudio.reset();
            decodedAudio.skip(currentChunk * bytesPerChunk);


            line.drain();
            line.close();

            audioConsumer.remove(this);
            audioConsumer.stop();
            audioConsumer = new AudioDataConsumer(bytesPerChunk, 10);
            audioConsumer.start(line);
            audioConsumer.add(this);
            line.open(decodedFormat);
            line.start();

            isPlaying = wasPlaying;
        } catch (Exception e) {
            throw new IllegalArgumentException(e);
        }
    }

    public int getChunkCount() {
        return chunkCount;
    }

    public int getCurrentChunk() {
        return currentChunk;
    }

    public float getSongLengthInSeconds() {
        float bitsPerChunk = (bytesPerChunk * 8) / (decodedFormat.getSampleSizeInBits() * decodedFormat.getChannels());
        return (bitsPerChunk * chunkCount) / decodedFormat.getSampleRate();
    }

    private class SoundRunnable implements Runnable {

        public void run() {
            try {
                byte[] data = new byte[bytesPerChunk];
                byte[] dataToAudio = new byte[bytesPerChunk];

                int nBytesRead;
                while (true) {
                    if (isPlaying) {
                        while (isPlaying && (nBytesRead = decodedAudio.read(data, 0, data.length)) != -1) {

                            for (int i = 0; i < nBytesRead; i++) {
                                dataToAudio[i] = (byte) (data[i] * volume);
                            }

                            line.write(dataToAudio, 0, nBytesRead);
                            audioConsumer.writeAudioData(data);
                            currentChunk++;
                        }
                    }
                    Thread.sleep(10);
                }

            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
    }
    private FFT fft;
    private float[] old_FFT;
    private int saFFTSampleSize = 512;
    private int saBands = 20;
    private float saMultiplier;
    private float saDecay = 0.03f;
    public double[] levels = new double[saBands];

    public void process(float[] leftChannel, float[] rightChannel, float frameRateRatioHint) {
        float[] sample = stereoMerge(leftChannel, rightChannel);
        float c = 0;
        float[] wFFT = fft.calculate(sample);

        float wSadfrr = (saDecay * frameRateRatioHint);
        //float wBw = ( (float)width / (float)saBands );

        for (int a = 0, bd = 0; bd < saBands; a += saMultiplier, bd++) {

            float wFs = 0;

            // -- Average out nearest bands.
            for (int b = 0; b < saMultiplier; b++) {
                wFs += wFFT[a + b];
            }

            // -- Log filter.
            wFs = (wFs * (float) Math.log(bd + 2));

            if (wFs > 1.0f) {
                wFs = 1.0f;
            }

            // -- Compute SA decay...
            if (wFs >= (old_FFT[a] - wSadfrr)) {

                old_FFT[a] = wFs;

            } else {

                old_FFT[a] -= wSadfrr;

                if (old_FFT[a] < 0) {
                    old_FFT[a] = 0;
                }

                wFs = old_FFT[a];

            }

            levels[bd] = wFs;
        }

        startNotification();
    }

    public double getLevel(int i) {
        return levels[i];
    }

    private float[] stereoMerge(float[] left, float[] right) {
        for (int a = 0; a < left.length; a++) {
            left[a] = (left[a] + right[a]) / 2.0f;
        }
        return left;
    }

    private void startNotification() {
        setChanged();
        notifyObservers();
    }
}
