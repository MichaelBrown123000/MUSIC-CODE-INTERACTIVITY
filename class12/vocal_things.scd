//for melany!

(
a = NodeProxy.new.play;
a.fadeTime=1;
a.source = { };
)

(
a[0..3] = { var v = Vowel.compose(
    [\a, \e, \i, \o],
    [\soprano, \bass, \tenor, \alto],
    ({20.rand}!5).normalizeSum
);
Formants.ar(60.midicps + 50.rand, v) * 0.1;
}
)


(
~scale = Scale.minor;
~scale = Scale.major; // both work
~tun = ~scale.degrees + 60;
// Pre-calculate the scale degrees for C major (MIDI note numbers)
a[0..7] = {
    var freq, v;
    freq = (~tun.choose ).midicps;

    v = Vowel.compose(
        [\a, \e, \i, \o],
        [\soprano, \bass, \tenor, \alto],
        ({20.rand}!5).normalizeSum
    );

    Formants.ar(freq, v) * 0.05;

}
)

(
~scale = Scale.minor;
//~scale = Scale.major; // both work
~tun = ~scale.degrees + 60;
Spec.add(\tempo, Spec.specs[\lofreq]);
// Set the source function for the NodeProxy
a[0..3] = {|tempo=2|
    var freq, v, trig;
    trig = Dust.kr(tempo); // Trigger approximately 2 times per second
	freq = TChoose.kr(trig, ~tun).midicps; //now instead of using the choose method, we're using a choose UGEN to be triggered
    v = Vowel.compose(
        [\a, \e, \i, \o],
        [\soprano, \bass, \tenor, \alto],
        TRand.kr({0}!4, {20}!4, trig).normalizeSum //using TRang means
    );
    Formants.ar(freq, v) * 0.05 * EnvGen.kr(Env.perc(0.01, 2), trig);
};

)

a.gui
(
~scale = Scale.minor;
// ~scale = Scale.major; // both work
~octave1 = ~scale.degrees + 24; //
~octave2 = ~scale.degrees + 60; //
~octave3 = ~scale.degrees + 84; //
~tun = ~octave1 ++ ~octave2 ++~octave3;

a[0..7] = {
    var freq, v;
    freq = (~tun.choose).midicps;
    v = Vowel.compose(
        [\a, \e, \i, \o],
        [\soprano, \bass, \tenor, \alto],
        ({20.rand}!5).normalizeSum
    );
    Formants.ar(freq, v) * 0.05;
}
)


(
a[0..1]=
{ |freq=50, lofreq=15 |
	var v = Vowel.compose(
	[\a, \e, \i, \o],
	[\soprano, \bass, \tenor, \alto],
	({10.rand}!5).normalizeSum
);
Formants.ar(freq + 300.rand/lofreq, v) * 0.1;
}
)


(
a[0..7]=
{ |freq=50, lofreq=15 |
	var squiggle = LFClipNoise.kr(100.rand/100).range(0,10);
	var v = Vowel.compose(
	[\a, \e, \i, \o],
	[\soprano, \bass, \tenor, \alto],
	({10.rand}!5).normalizeSum);
	Formants.ar(freq + 300.rand/squiggle, v) * 0.05;
}
)



(
Spec.add(\tempo, Spec.specs[\lofreq]);
Spec.add(\basepitch, Spec.specs[\lofreq]);
a[0..5]=
{ |basepitch=100, tempo=15 |
	var squiggle = LFNoise1.kr(100.rand/tempo).range(0,1);
	var v = Vowel.compose(
	[\a, \e, \i, \o],
	[\soprano, \bass, \tenor, \alto],
	({10.rand}!5).normalizeSum);
	Formants.ar(basepitch + 300.rand/squiggle, v) * 0.05;
}
)

a.play

(
a[0..20] = { var v = Vowel.compose(
    [\a, \e, \i, \o],
    [\soprano, \bass, \tenor, \alto],
    ({80.rand}!20).normalizeSum
);
Formants.ar(80.midicps + 90.rand, v) * 0.01;
})



