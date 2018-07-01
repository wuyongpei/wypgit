package com.yangzi.fullR.util;

import com.jacob.activeX.ActiveXComponent;
import com.jacob.com.ComThread;
import com.jacob.com.Dispatch;
import com.jacob.com.Variant;
import com.sun.tools.classfile.StackMapTable_attribute.same_frame;
import com.yangzi.fullR.util.SoundUtil;

public class MSTTSSpeech {
 
	private int volume=100;// 声音：1到100  
    private int rate=-5;// 频率：-10到10  
    private int voice=0;// 语音库序号  
    private int audio=0;// 输出设备序号  
    private ActiveXComponent ax=null;  
    private Dispatch spVoice=null;// 声音对象  
    private Dispatch spFileStream=null;// 音频文件输出流对象，在读取或保存音频文件时使用  
    private Dispatch spAudioFormat=null;// 音频格式对象  
    private Dispatch spMMAudioOut=null;// 音频输出对象  
    private int formatType=22;// 音频的输出格式，默认为：SAFT22kHz16BitMono  
	 
    
    public MSTTSSpeech()   
    {  
        ComThread.InitSTA();  
        if(ax==null)  
        {  
            ax=new ActiveXComponent("Sapi.SpVoice");  
            spVoice=ax.getObject();  
        }  
    }  
    /** 
     * 改变语音库 
     * @param voice 语音库序号 
     */  
    public void changeVoice(int voice)  
    {  
        if(this.voice != voice)  
        {  
            this.voice=voice;  
        }  
        try  
        {  
            Dispatch voiceItems=Dispatch.call(spVoice,"GetVoices").toDispatch();  
            int count=Integer.valueOf(Dispatch.call(voiceItems,"Count").toString());  
            if(count>0)  
            {  
                Dispatch voiceItem=Dispatch.call(voiceItems,"Item",new Variant(this.voice)).toDispatch();  
                Dispatch.put(spVoice,"Voice",voiceItem);  
            }  
        }  
        catch(Exception e)  
        {  
            System.out.println(e.getMessage());  
            e.printStackTrace();  
        }  
    }  
    /** 
     * 改变音频输出设备 
     * @param audio 音频设备序号 
     */  
    public void changeAudioOutput(int audio)  
    {  
        if(this.audio != audio)  
        {  
            this.audio=audio;  
        }  
        try  
        {  
            Dispatch audioOutputs=Dispatch.call(spVoice,"GetAudioOutputs").toDispatch();  
            int count=Integer.valueOf(Dispatch.call(audioOutputs,"Count").toString());  
            if(count > 0)  
            {  
                Dispatch audioOutput=Dispatch.call(audioOutputs,"Item",new Variant(this.audio)).toDispatch();  
                Dispatch.put(spVoice,"AudioOutput",audioOutput);  
            }  
        }  
        catch(Exception e)  
        {  
            System.out.println(e.getMessage());  
            e.printStackTrace();  
        }  
    }  
    /** 
     * 播放语音  
     * @param text 要转换成语音的文本 
     */  
    public void speak(String text)  
    {  
        this.speak(text,0);  
    }  
    /** 
     * 停止播放语音 
     */  
    public void stop()  
    {  
        // this.speak("", 1);  
        Dispatch.call(spVoice,"Pause");  
    }  
    /** 
     * 播放语音 
     * @param text 要转换成语音的文本 
     * @param type 类型0:播放，1：停止 
     */  
    public synchronized void speak(String text,int type)  
    {  
        switch(type)   
        {  
            case 0:  
                try  
                {  
                    // 调整音量和读的速度  
                    Dispatch.put(spVoice,"Volume",new Variant(this.volume));// 设置音量  
                    Dispatch.put(spVoice,"Rate",new Variant(this.rate));// 设置速率  
                    // 设置音频格式类型  
                    if(spAudioFormat==null)  
                    {  
                        ax=new ActiveXComponent("Sapi.SpAudioFormat");  
                        spAudioFormat=ax.getObject();  
                        ax=new ActiveXComponent("Sapi.SpMMAudioOut");  
                        spMMAudioOut=ax.getObject();  
                    }  
                    Dispatch.put(spAudioFormat,"Type",new Variant(this.formatType));  
                    Dispatch.putRef(spMMAudioOut,"Format",spAudioFormat);  
                    Dispatch.put(spVoice,"AllowAudioOutputFormatChangesOnNextSet",new Variant(false));  
                    Dispatch.putRef(spVoice,"AudioOutputStream",spMMAudioOut);  
                    // 开始朗读  
                    Dispatch.call(spVoice,"Speak",new Variant(text));  
                }  
                catch(Exception e)  
                {  
                    System.out.println(e.getMessage());  
                    e.printStackTrace();  
                }  
                break;  
            case 1:  
                try  
                {  
                    Dispatch.call(spVoice,"Speak",new Variant(text),new Variant(2));  
                }  
                catch(Exception e)  
                {  
                    System.out.println(e.getMessage());  
                    e.printStackTrace();  
                }  
                break;  
            default:  
                break;  
        }  
    }  
    public void speak1(String text,int type)  
    {  
    	switch(type)   
    	{  
    	case 0:  
    		try  
    		{  
    			// 调整音量和读的速度  
    			Dispatch.put(spVoice,"Volume",new Variant(this.volume));// 设置音量  
    			Dispatch.put(spVoice,"Rate",new Variant(this.rate));// 设置速率  
    			// 设置音频格式类型  
    			if(spAudioFormat==null)  
    			{  
    				ax=new ActiveXComponent("Sapi.SpAudioFormat");  
    				spAudioFormat=ax.getObject();  
    				ax=new ActiveXComponent("Sapi.SpMMAudioOut");  
    				spMMAudioOut=ax.getObject();  
    			}  
    			Dispatch.put(spAudioFormat,"Type",new Variant(this.formatType));  
    			Dispatch.putRef(spMMAudioOut,"Format",spAudioFormat);  
    			Dispatch.put(spVoice,"AllowAudioOutputFormatChangesOnNextSet",new Variant(false));  
    			Dispatch.putRef(spVoice,"AudioOutputStream",spMMAudioOut);  
    			// 开始朗读  
    			Dispatch.call(spVoice,"Speak",new Variant(text));  
    		}  
    		catch(Exception e)  
    		{  
    			System.out.println(e.getMessage());  
    			e.printStackTrace();  
    		}  
    		break;  
    	case 1:  
    		try  
    		{  
    			Dispatch.call(spVoice,"Speak",new Variant(text),new Variant(2));  
    		}  
    		catch(Exception e)  
    		{  
    			System.out.println(e.getMessage());  
    			e.printStackTrace();  
    		}  
    		break;  
    	default:  
    		break;  
    	}  
    }  
    /** 
     * 获取系统中所有的语音库名称数组  
     * @return String[] 
     */  
    public String[] getVoices()  
    {  
        String[] voices=null;  
        try  
        {  
            Dispatch voiceItems=Dispatch.call(spVoice,"GetVoices").toDispatch();  
            int count=Integer.valueOf(Dispatch.call(voiceItems,"Count").toString());  
            if(count > 0)  
            {  
                voices=new String[count];  
                for(int i=0;i<count;i++)  
                {  
                    Dispatch voiceItem=Dispatch.call(voiceItems,"Item",new Variant(i)).toDispatch();  
                    String voice=Dispatch.call(voiceItem,"GetDescription").toString();  
                    voices[i]=voice;  
                }  
            }  
        }  
        catch(Exception e)  
        {  
            System.out.println(e.getMessage());  
            e.printStackTrace();  
        }  
        return voices;  
    }  
    /** 
     * 获取音频输出设备名称数组 
     * @return String[] 
     */  
    public String[] getAudioOutputs()  
    {  
        String[] result=null;  
        try  
        {  
            Dispatch audioOutputs=Dispatch.call(spVoice,"GetAudioOutputs").toDispatch();  
            int count=Integer.valueOf(Dispatch.call(audioOutputs,"Count").toString());  
            if(count > 0)  
            {  
                result=new String[count];  
                for(int i=0;i<count;i++)  
                {  
                    Dispatch voiceItem=Dispatch.call(audioOutputs,"Item",new Variant(i)).toDispatch();  
                    String voice=Dispatch.call(voiceItem,"GetDescription").toString();  
                    result[i]=voice;  
                }  
            }  
        }  
        catch(Exception e)  
        {  
            System.out.println(e.getMessage());  
            e.printStackTrace();  
        }  
        return result;  
    }  
    /** 
     * 将文字转换成音频信号，然后输出到.WAV文件 
     * @param text 文本字符串 
     * @param filePath 输出文件路径 
     */  
    public void saveToWav(String text,String filePath)  
    {  
        // 创建输出文件流对象  
        ax=new ActiveXComponent("Sapi.SpFileStream");  
        spFileStream=ax.getObject();  
        // 创建音频流格式对象  
        if(spAudioFormat==null)  
        {  
            ax=new ActiveXComponent("Sapi.SpAudioFormat");  
            spAudioFormat=ax.getObject();  
        }  
        // 设置音频流格式类型  
        Dispatch.put(spAudioFormat,"Type",new Variant(this.formatType));  
        // 设置文件输出流的格式  
        Dispatch.putRef(spFileStream,"Format",spAudioFormat);  
        // 调用输出文件流对象的打开方法，创建一个.wav文件  
        Dispatch.call(spFileStream,"Open",new Variant(filePath),new Variant(3),new Variant(true));  
        // 设置声音对象的音频输出流为输出文件流对象  
        Dispatch.putRef(spVoice,"AudioOutputStream",spFileStream);  
        // 调整音量和读的速度  
        Dispatch.put(spVoice,"Volume",new Variant(this.volume));// 设置音量  
        Dispatch.put(spVoice,"Rate",new Variant(this.rate));// 设置速率  
        // 开始朗读  
        Dispatch.call(spVoice,"Speak",new Variant(text));  
        // 关闭输出文件流对象，释放资源  
        Dispatch.call(spFileStream,"Close");  
        Dispatch.putRef(spVoice,"AudioOutputStream",null);  
    }  
    /** 
     * @return the volume 
     */  
    public int getVolume()  
    {  
        return volume;  
    }  
    /** 
     * @param volume 
     * the volume to set 
     */  
    public void setVolume(int volume)  
    {  
        this.volume = volume;  
    }  
    /** 
     * @return the rate 
     */  
    public int getRate()  
    {  
        return rate;  
    }  
    /** 
     * @param rate 
     * the rate to set 
     */  
    public void setRate(int rate)  
    {  
        this.rate = rate;  
    }  
    /** 
     * @return the voice 
     */  
    public int getVoice()  
    {  
        return voice;  
    }  
    /** 
     * @param voice 
     * the voice to set 
     */  
    public void setVoice(int voice)  
    {  
        this.voice = voice;  
    }  
    /** 
     * @return the audio 
     */  
    public int getAudio()  
    {  
        return audio;  
    }  
    /** 
     * @param audio 
     * the audio to set 
     */  
    public void setAudio(int audio)  
    {  
        this.audio=audio;  
    }  
    /** 
     * @return the ax 
     */  
    public ActiveXComponent getAx()  
    {  
        return ax;  
    }  
    /** 
     * @param ax 
     * the ax to set 
     */  
    public void setAx(ActiveXComponent ax)  
    {  
        this.ax=ax;  
    }  
    /** 
     * @return the formatType 
     */  
    public int getFormatType()  
    {  
        return formatType;  
    }  
    
    public void setFormatType(int formatType)  
    {  
        this.formatType=formatType;  
    }  
    public static void main(String[] args)  
    {  
        MSTTSSpeech speech=new MSTTSSpeech();  
        String text="请 A0003号到骨科第3诊室就诊";  
        speech.setFormatType(22);  
        speech.saveToWav(text,"E://syl//C//test.wav");  
        SoundUtil.wavToPcm("E://syl//C//test.wav");  
        
    }  
    
    
    
}
