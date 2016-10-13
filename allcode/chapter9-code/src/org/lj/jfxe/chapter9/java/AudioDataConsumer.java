package org.lj.jfxe.chapter9.java;

import java.util.ArrayList;

import javax.sound.sampled.SourceDataLine;

public class AudioDataConsumer {

    private static final int DEFAULT_SAMPLE_SIZE = 2048;
    private static final int DEFAULT_FPS = 70;
    public static final int SAMPLE_TYPE_EIGHT_BIT = 1;
    public static final int SAMPLE_TYPE_SIXTEEN_BIT = 2;
    public static final int CHANNEL_MODE_MONO = 1;
    public static final int CHANNEL_MODE_STEREO = 2;
    private Object readWriteLock = new Object();
    private SourceDataLine sourceDataLine;
    private int sampleSize;
    private long fpsAsNS;
    private long desiredFpsAsNS;
    private byte[] audioDataBuffer;
    private float[] left;
    private float[] right;
    private int position;
    private long offset;
    private SignalProcessor signalProcessor;
    private ArrayList<SignalProcessorListener> dsps = new ArrayList<SignalProcessorListener>();
    private int sampleType;
    private int channelMode;

    /**
     * Default constructor creates a DSPAC with DEFAULT_SAMPLE_SIZE and DEFAULT_FPS as
     * parameters.
     */
    public AudioDataConsumer() {
        this(DEFAULT_SAMPLE_SIZE, DEFAULT_FPS);
    }

    /**
     * @param pSampleSize The sample size to extract from audio data sent to the SourceDataLine.
     * @param pFramePerSecond The desired refresh rate per second of registered DSP's.
     */
    public AudioDataConsumer(int pSampleSize, int pFramesPerSecond) {
        this(pSampleSize, pFramesPerSecond, SAMPLE_TYPE_SIXTEEN_BIT, CHANNEL_MODE_STEREO);
    }

    /**
     * @param pSampleSize The sample size to extract from audio data sent to the SourceDataLine.
     * @param pFramePerSecond The desired refresh rate per second of registered DSP's.
     * @param pSampleType The sample type SAMPLE_TYPE_EIGHT_BIT or SAMPLE_TYPE_SIXTEEN_BIT.
     * @param pFramePerSecond The channel mode CHANNEL_MODE_MONO or CHANNEL_MODE_STEREO.
     */
    public AudioDataConsumer(int pSampleSize, int pFramesPerSecond, int pSampleType, int pChannelMode) {

        sampleSize = pSampleSize;
        desiredFpsAsNS = 1000000000L / (long) pFramesPerSecond;
        fpsAsNS = desiredFpsAsNS;

        setSampleType(pSampleType);
        setChannelMode(pChannelMode);

    }

    public void add(SignalProcessorListener signalProcessor) {
        dsps.add(signalProcessor);
    }

    public void remove(SignalProcessorListener signalProcessor) {
        dsps.remove(signalProcessor);
    }

    public void setChannelMode(int pChannelMode) {
        channelMode = pChannelMode;
    }

    public void setSampleType(int pSampleType) {
        sampleType = pSampleType;
    }

    /**
     * Start monitoring the specified SourceDataLine.
     *
     * @param pSdl A SourceDataLine.
     */
    public synchronized void start(SourceDataLine pSdl) {

        // -- Stop processing previous source data line.
        if (signalProcessor != null) {
            stop();
        }

        if (signalProcessor == null) {

//			System.out.println( "ADBS: " + pSdl.getBufferSize() );

            sourceDataLine = pSdl;

            // -- Allocate double the memory than the SDL to prevent
            //    buffer overlapping.
            audioDataBuffer = new byte[pSdl.getBufferSize() << 1];

            left = new float[sampleSize];
            right = new float[sampleSize];

            position = 0;
            offset = 0;

            signalProcessor = new SignalProcessor();

            new Thread(signalProcessor).start();

        }

    }

    /**
     * Stop monitoring the currect SourceDataLine.
     */
    public synchronized void stop() {

        if (signalProcessor != null) {

            signalProcessor.stop();
            signalProcessor = null;

            audioDataBuffer = null;
            sourceDataLine = null;

        }

    }

    private void storeAudioData(byte[] pAudioData, int pOffset, int pLength) {

        synchronized (readWriteLock) {

            if (audioDataBuffer == null) {
                return;
            }

            int wOverrun = 0;

            if (position + pLength > audioDataBuffer.length - 1) {

                wOverrun = (position + pLength) - audioDataBuffer.length;
                pLength = audioDataBuffer.length - position;

            }

            System.arraycopy(pAudioData, pOffset, audioDataBuffer, position, pLength);

            if (wOverrun > 0) {

                System.arraycopy(pAudioData, pOffset + pLength, audioDataBuffer, 0, wOverrun);
                position = wOverrun;

            } else {
                position += pLength;
            }

        }

    }

    public void writeAudioData(byte[] pAudioData) {
        storeAudioData(pAudioData, 0, pAudioData.length);
    }

    public void writeAudioData(byte[] pAudioData, int pOffset, int pLength) {
        storeAudioData(pAudioData, pOffset, pLength);
    }

    private class SignalProcessor implements Runnable {

        boolean process = true;
        long lfp = 0;
        int frameSize;

        public SignalProcessor() {
            frameSize = sourceDataLine.getFormat().getFrameSize();
        }

        private int calculateSamplePosition() {

            synchronized (readWriteLock) {

                long wFp = sourceDataLine.getLongFramePosition();
                long wNfp = lfp;

                lfp = wFp;

                int wSdp = (int) ((long) (wNfp * frameSize) - (long) (audioDataBuffer.length * offset));

                return wSdp;

            }

        }

        private void processSamples(int pPosition) {
                int c = pPosition;

                if (channelMode == CHANNEL_MODE_MONO && sampleType == SAMPLE_TYPE_EIGHT_BIT) {

                    for (int a = 0; a < sampleSize; a++, c++) {

                        if (c >= audioDataBuffer.length) {
                            offset++;
                            c = (c - audioDataBuffer.length);
                        }

                        left[a] = (float) ((int) audioDataBuffer[c] / 128.0f);
                        right[a] = left[a];

                    }

                } else if (channelMode == CHANNEL_MODE_STEREO && sampleType == SAMPLE_TYPE_EIGHT_BIT) {

                    for (int a = 0; a < sampleSize; a++, c += 2) {

                        if (c >= audioDataBuffer.length) {
                            offset++;
                            c = (c - audioDataBuffer.length);
                        }

                        left[a] = (float) ((int) audioDataBuffer[c] / 128.0f);
                        right[a] = (float) ((int) audioDataBuffer[c + 1] / 128.0f);

                    }

                } else if (channelMode == CHANNEL_MODE_MONO && sampleType == SAMPLE_TYPE_SIXTEEN_BIT) {

                    for (int a = 0; a < sampleSize; a++, c += 2) {

                        if (c >= audioDataBuffer.length) {
                            offset++;
                            c = (c - audioDataBuffer.length);
                        }

                        left[a] = (float) (((int) audioDataBuffer[c + 1] << 8) + audioDataBuffer[c]) / 32767.0f;
                        
                        right[a] = left[a];

                    }

                } else if (channelMode == CHANNEL_MODE_STEREO && sampleType == SAMPLE_TYPE_SIXTEEN_BIT) {

                    for (int a = 0; a < sampleSize; a++, c += 4) {

                        if (c >= audioDataBuffer.length) {
                            offset++;
                            c = (c - audioDataBuffer.length);
                        }

                        left[a] = (float) (((int) audioDataBuffer[c + 1] << 8) + audioDataBuffer[c]) / 32767.0f;
                        right[a] = (float) (((int) audioDataBuffer[c + 3] << 8) + audioDataBuffer[c + 2]) / 32767.0f;
                        
                    }

                }
        }

        public void run() {

            while (process) {

                try {

                    long wStn = System.nanoTime();

                    int wSdp = calculateSamplePosition();

                    if (wSdp > 0) {
                        processSamples(wSdp);
                    }

                    // -- Dispatch sample data to digtal signal processors.
                    for (int a = 0; a < dsps.size(); a++) {

                        // -- Calculate the frame rate ratio hint. This value can be used by
                        //    animated DSP's to fast forward animation frames to make up for
                        //    inconsistencies with the frame rate.
                        float wFrr = (float) fpsAsNS / (float) desiredFpsAsNS;

                        try {
                            ((SignalProcessorListener) dsps.get(a)).process(left, right, wFrr);
                        } catch (Exception pEx) {
                            System.err.println("-- DSP Exception: ");
                            pEx.printStackTrace();
                        }
                    }

                    long wDelay = fpsAsNS - (System.nanoTime() - wStn);

                    // -- No DSP registered? Put the the DSP thread to sleep.
                    if (dsps.isEmpty()) {
                        wDelay = 1000000000; // -- 1 second.
                    }

                    if (wDelay > 0) {

                        try {
                            Thread.sleep(wDelay / 1000000, (int) wDelay % 1000000);
                        } catch (Exception pEx) {
                            // TODO Auto-generated catch block
                        }

                        // -- Adjust FPS until we meet the "desired FPS".
                        if (fpsAsNS > desiredFpsAsNS) {
                            fpsAsNS -= wDelay;
                        } else {
                            fpsAsNS = desiredFpsAsNS;
                        }

                    } else {

                        // -- Reduce FPS because we cannot keep up with the "desired FPS".
                        fpsAsNS += -wDelay;

                        // -- Keep thread from hogging CPU.
                        try {
                            Thread.sleep(10);
                        } catch (InterruptedException pEx) {
                            // TODO Auto-generated catch block
                        }

                    }

                } catch (Exception pEx) {
                    System.err.println("- DSP Exception: ");
                    pEx.printStackTrace();
                }

            }

        }

        public void stop() {
            process = false;
        }
    }
}
