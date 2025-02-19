(
n = NodeProxy.audio(s, 2);  // audio rate NP running on the default server with two internal channels
n.fadeTime = 5;
n.play;

n.put(0, { SinOsc.ar([3000, 3100]) * LFTri.kr(1/10, 3).range(10, 10).dbamp });
n.put(1, { SinOsc.ar([3030, 3060]) * LFTri.kr(1/5.4, 3).range(7, 15).dbamp });
n.put(2, { Saw.ar([3030, 3060]/20) * LFTri.kr(1/5.4, 3).range(12, 11).dbamp });
n.put(3, { Dust.ar([3030, 3060]/30) * LFTri.kr(1/2.4, 3).range(6, 18).dbamp });
)

n.gui

(
SynthDef.new(\sineTest, {
	arg noiseHz=5;
	var freq, amp, sig;
	freq = LFNoise0.kr(noiseHz).exprange(300,1000);
	amp = LFNoise1.kr(6).exprange(0.05,4);
	sig = SinOsc.ar(freq) * amp;
	Out.ar([0,1], sig); //the critical line of code
}).add
)

x = Synth.new(\sineTest);