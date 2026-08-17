Class {
	#name : 'PipeRudesheim',
	#superclass : 'Object',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
	#instVars : [
		'commands'
	],
	#category : 'Rudesheim-Pipe-Private',
	#package : 'Rudesheim-Pipe-Private'
}

{ #category : 'namespace' }
PipeRudesheim class >> Command [ ^ CommandPipeRudesheim
]

{ #category : 'namespace' }
PipeRudesheim class >> Echo [ ^ EchoPipeRudesheim
]

{ #category : 'namespace' }
PipeRudesheim class >> EndOfStream [ ^ EndOfStreamPipeRudesheim
]

{ #category : 'namespace' }
PipeRudesheim class >> Message [ ^ MessagePipeRudesheim
]

{ #category : 'namespace' }
PipeRudesheim class >> SharedQueue [ ^ SharedQueuePipeRudesheim
]

{ #category : 'namespace' }
PipeRudesheim class >> Streams [ ^ StreamsPipeRudesheim
]

{ #category : 'instance creation' }
PipeRudesheim class >> withPipeCommands: aSequencialCollection [

	^ super new
		setPipeCommands: aSequencialCollection.
]

{ #category : 'initialization' }
PipeRudesheim >> setPipeCommands: aSequencialCollection [

	commands :=  aSequencialCollection.
]

{ #category : 'initialization' }
PipeRudesheim >> writeStreamDo: aWritingBlock
readStreamDo: aReadingBlock [
	|
		originStream
		pipeStream
		pipeStreams
		join
	|
	
	originStream := StreamsPipeRudesheim new.
	pipeStream := originStream.
	
	commands
		do: 
		[ :each |
			|
				processLocalStream
			|
			
			processLocalStream := pipeStream :=
				StreamsPipeRudesheim
					shiftStream: pipeStream.
			
			[
				[
					each 
						executeWithPipeStream: processLocalStream.
				]
					ensure:
					[
						processLocalStream stdout close. 
					]
			] fork
		].
	
	pipeStreams :=
		StreamsPipeRudesheim
			inputPipeStreams: pipeStream inverse 
			outputPipeStreams: originStream.
		
	join := Semaphore new.
	[
		[
			aWritingBlock
				value: pipeStreams stdout. 
		]
			ensure:
			[
				pipeStreams
					stdout close.
				join signal.
			].
	] fork.

	^
	[
		aReadingBlock
			value: pipeStreams stdin.
	]
		ensure:
		[
			join wait 
		].
]
