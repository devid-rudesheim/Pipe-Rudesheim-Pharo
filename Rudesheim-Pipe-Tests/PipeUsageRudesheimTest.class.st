Class {
	#name : 'PipeUsageRudesheimTest',
	#superclass : 'TestCase',
	#category : 'Rudesheim-Pipe-Tests',
	#package : 'Rudesheim-Pipe-Tests'
}

{ #category : 'tests' }
PipeUsageRudesheimTest >> testEchoCommandCopiesInputToOutput [
	|
		actual
		expected
	|

	actual := OrderedCollection new.
	expected := #( 1 2 3 ).

	(
		{
			EchoPipeRudesheim.
		} asRHPipe
	)
		writeStreamDo:
		[ :stream |
			stream
				nextPutAll: expected.
		]
		readStreamDo:
		[ :stream |
			actual
				addAll: stream.
		].

	self
		assert: actual asArray
		equals: expected.
]

{ #category : 'tests' }
PipeUsageRudesheimTest >> testMessageCommandTransformsInput [
	|
		actual
		expected
	|

	actual := OrderedCollection new.
	expected := #( 2 4 6 ).

	(
		{
			MessagePipeRudesheim
				send: #value:
				to:
				[ :pipeStreams |
					pipeStreams stdin
						do:
						[ :each |
							pipeStreams stdout
								nextPut: each * 2.
						].
				].
		} asRHPipe
	)
		writeStreamDo:
		[ :stream |
			stream
				nextPutAll: #( 1 2 3 ).
		]
		readStreamDo:
		[ :stream |
			actual
				addAll: stream.
		].

	self
		assert: actual asArray
		equals: expected.
]

{ #category : 'tests' }
PipeUsageRudesheimTest >> testMessageCommandsAreComposedInOrder [
	|
		actual
		expected
	|

	actual := OrderedCollection new.
	expected := #( 20 30 40 ).

	(
		{
			MessagePipeRudesheim
				send: #value:
				to:
				[ :pipeStreams |
					pipeStreams stdin
						do:
						[ :each |
							pipeStreams stdout
								nextPut: each + 1.
						].
				].
			MessagePipeRudesheim
				send: #value:
				to:
				[ :pipeStreams |
					pipeStreams stdin
						do:
						[ :each |
							pipeStreams stdout
								nextPut: each * 10.
						].
				].
		} asRHPipe
	)
		writeStreamDo:
		[ :stream |
			stream
				nextPutAll: #( 1 2 3 ).
		]
		readStreamDo:
		[ :stream |
			actual
				addAll: stream.
		].

	self
		assert: actual asArray
		equals: expected.
]
