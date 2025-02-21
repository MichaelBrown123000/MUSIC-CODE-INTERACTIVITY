n = NodeProxy.audio(s, 2);
n.fadeTime = 5;
n.play;
(
n.source =
{
	var frog1, frog2, frog3, frog4, out, sig, mix;
	frog1= Mix.ar(SinOsc.ar(exprand(0.3,8) * [rrand(0.7,1.3),1], [2pi.rand,2pi.rand], 0.1)).max(0);
	frog2= Mix.ar(SinOsc.ar(exprand(6,24) * [rrand(0.7,1.3),1], [2pi.rand,2pi.rand], 0.1)).abs;
	frog3= Mix.ar(LFNoise2.ar(exprand(5,6) * [rrand(0.7,1.3),1], [2pi.rand,2pi.rand], 0.1)).abs;
	frog4= Mix.ar(BrownNoise.ar(exprand(2,6) * [rrand(0.7,1.3),1], [2pi.rand,2pi.rand], 0.1)).abs;
    sig = SinOsc.ar(rrand(80,108).midicps, 2pi.rand, frog1*frog2*frog3*frog4);
	out = Pan2.ar(sig, 1.0.rand2);
};
)