(
n = NodeProxy.audio(s, 2);  // audio rate NP running on the default server with two internal channels
n.fadeTime = 10;
n.play;

n.put(0, { SinOsc.ar([3000, 3100]) * LFTri.kr(1/10, 3).range(-90, -30).dbamp });
n.put(1, { SinOsc.ar([3030, 3060]) * LFTri.kr(1/5.4, 3).range(-60, -30).dbamp });
n.put(2, { Saw.ar([3030, 3060]/20) * LFTri.kr(1/5.4, 3).range(-60, -30).dbamp });
n.put(3, { Dust.ar([3030, 3060]/30) * LFTri.kr(1/2.4, 3).range(-60, -10).dbamp });
)

