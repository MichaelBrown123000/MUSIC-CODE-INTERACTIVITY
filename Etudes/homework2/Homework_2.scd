(
{ var levels, times, doneAction, env, a;
	// THIS IS JUST THE TEST SOUND
	a = WhiteNoise.ar;
	a = RLPF.ar(a, [200, 300], 0.01).softclip * 0.4;

	// HERE IS THE ENVELOPE
	doneAction = 8;				// when the envelope finishes, it will dispose of the synth
	levels = [0,1,2,0];			// envelope will begin at 0 go to 1, 1 go to 2, and then decay
	times = [2, 3, 1];			// 0 to 1: 20 seconds, 1 to 2: 30 seconds, 1 to 0: 10 seconds
	env = Env(levels, times);	// define the envelope
	env = env.kr(doneAction);	// make it run as a UGen
	env = env.lincurve(0, 2, 0,5, 6); // read the SimpleNumber helpfile discussion of lincurve

	// applying the envelope to the sound
	a = env * a;
}.play;)