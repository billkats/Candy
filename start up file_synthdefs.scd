Server.default.waitForBoot({    /* REVERB */

	SynthDef.new(\reverb, {
	arg in;
	var sig, env;
	sig = In.ar(in, 2);
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [0.1, 180, 1]), doneAction:2);
	sig = FreeVerb.ar(sig, 0.5, 0.8, 0.2)*env;
	Out.ar(0, sig);
	}).add;

	                     /* DRONES */
	/*
	bassnote
	*/

	SynthDef.new(\bassnote, {
		arg t1=3, t2=87, t3=5, out, off=1;
		var temp, sum, env;
		sum = 0;
		10.do{
		temp = VarSaw.ar(
			40 * {Rand(0.99, 1.02)}!2,
			{Rand(0.0, 1.0)}!2,
			0.05
		);
		sum = sum + temp;
	};
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sum = sum*0.1*env*off;
	Out.ar(out, sum);

	}).add;




	/*
	drone
	*/

	SynthDef.new(\drone,
		{

	arg freq=200, dev=1.02, out, t1=2, t2=77, t3=1,off=1;
	var temp, sum, env;
	sum = 0;
	10.do{
		arg count;
		temp = SinOsc.ar(
			freq *
			(count + 1) *
			LFNoise1.kr({Rand(0.05, 0.2)}!2).range(dev.reciprocal, dev)
		);
		temp = temp * LFNoise1.kr({Rand(0.5, 8)}!2).exprange(0.01, 1);
		sum = sum + temp;
	};
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sum = sum * 0.2 * env*off;

	Out.ar(out, sum);
		},[5!3]
	).add;




	                      /* SYNTHS */

	/*
	simplesig
	*/

	SynthDef(\simplesig, {
		arg freq1 = 201, freq2 = 201.5, mul = 0.3, t1=1, t2=63, t3=1, out, off=1;
		var env;
		env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
		Out.ar(out,SinOsc.ar
			([freq1, freq2],
				0, mul*env*off)
	)
	},[2, 2.5]).add;



	/*
	ufo
	*/

SynthDef.new(\ufo, {
		arg t1=2, t2=56, t3=2, out, off=1;
	var sig, amp, env;
	env = EnvGen.kr(
		Env.new([0,1,1,0], [t1, t2, t3], [1, -1]),
	doneAction:2
	);
	amp = SinOsc.kr({ExpRand(0.2,12)}!7).range(0,1);
	sig = SinOsc.ar({ExpRand(300,6000)}!7);
	sig = sig * amp * env*off;
	sig = Splay.ar(sig) * 0.3;
	Out.ar(out, sig);
}).add;



	/*
	blip
	*/

	SynthDef.new(\blip, {
	arg out, fund=300, dens=0.5, decay=0.9, t1=3, t2=54, t3=3;
	var freq, trig, sig, env;
	freq = LFNoise0.kr(3).exprange(fund,fund*4).round(fund);
	sig = SinOsc.ar(freq) * 0.3;
	trig = Dust.kr(dens);
	env = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sig = sig * EnvGen.kr(Env.perc(0.01, decay), trig) * env;
	sig = Pan2.ar(sig, LFNoise1.kr(10));
	Out.ar(out, sig);
	}).add;

		/*
	crazysynth
	*/

SynthDef.new(\crazysynth, {
	arg plus=1, attack=1, decay=2, release=3, circle=0.2, out, t1=1, t2=5, t3=3;
	var sig, env, freq, en;
	freq = EnvGen.kr(Env.adsr(attack,decay,release), 200, circle);
	en = EnvGen.kr(Env.new([0, 1, 1, 0], [t1, t2, t3]), doneAction:2);
	sig = VarSaw.ar(SinOsc.kr(freq,rrand(0.0,1.0)).range(80+plus, 300+plus)) * 0.4 * en;
	Out.ar(out, sig!2);
}).add;

});
