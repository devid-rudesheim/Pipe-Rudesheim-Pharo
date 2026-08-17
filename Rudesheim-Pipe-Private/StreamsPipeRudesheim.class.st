Class {
	#name : 'StreamsPipeRudesheim',
	#superclass : 'Object',
	#instVars : [
		'in',
		'out'
	],
	#category : 'Rudesheim-Pipe-Private',
	#package : 'Rudesheim-Pipe-Private'
}

{ #category : 'instance creation' }
StreamsPipeRudesheim class >> inputPipeStreams: anInputPipeStreams
outputPipeStreams: anOutputPipeStreams [

	^ self new
		setInputPipeStreams: anInputPipeStreams
		outputPipeStreams: anOutputPipeStreams.
]

{ #category : 'instance creation' }
StreamsPipeRudesheim class >> inversePipeStreams: aPipeStreams [

	^ self new 
		setInversePipeStreams: aPipeStreams;
		yourself.
]

{ #category : 'instance creation' }
StreamsPipeRudesheim class >> shiftStream: aPipeStreams [

	^ self new
		shiftStream: aPipeStreams.
]

{ #category : 'accessing-defaults' }
StreamsPipeRudesheim >> defaultStream [

	^ SharedQueuePipeRudesheim new.
]

{ #category : 'operations' }
StreamsPipeRudesheim >> inverse [

	^ self class
		inversePipeStreams: self.
]

{ #category : 'initialization' }
StreamsPipeRudesheim >> setInputPipeStreams: anInputPipeStreams
outputPipeStreams: anOutputPipeStreams [

	in := anInputPipeStreams stdin.
	out := anOutputPipeStreams stdout.
]

{ #category : 'initialization' }
StreamsPipeRudesheim >> setInversePipeStreams: aPipeStreams [

	in := aPipeStreams stdout.
	out := aPipeStreams stdin.
]

{ #category : 'accessing' }
StreamsPipeRudesheim >> shiftStream: aPipeStreams [

	out := in.
	in := aPipeStreams stdout.
]

{ #category : 'accessing' }
StreamsPipeRudesheim >> stdin [

	^ in
		ifNil:
		[
			in := self defaultStream.
		].
]

{ #category : 'accessing' }
StreamsPipeRudesheim >> stdout [

	^ out
		ifNil:
		[
			out := self defaultStream.
		].
]
