(
{ var levels, times, doneAction, env, a;
	// THIS IS JUST THE TEST SOUND
	a = PinkNoise.ar;
	a = RLPF.ar(a, [500, 600], 0.01).softclip * 0.1;

	// HERE IS THE ENVELOPE
	doneAction = 2;				// when the envelope finishes, it will dispose of the synth
	levels = [0,1,1,0];			// envelope will begin at 0 go to 1, stay there and then decay
	times = [2, 3, 1];			// 0 to 1: 20 seconds, 1 to 1: 3 seconds, 1 to 0: 0.1 seconds
	env = Env(levels, times);	// define the envelope
	env = env.kr(doneAction);	// make it run as a UGen
	env = env.lincurve(0, 1, 0,4, 3); // read the SimpleNumber helpfile discussion of lincurve

	// applying the envelope to the sound
	a = env * a;
}.play;)