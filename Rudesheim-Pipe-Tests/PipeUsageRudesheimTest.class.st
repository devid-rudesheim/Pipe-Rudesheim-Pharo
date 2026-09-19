Class {
	#name : 'PipeUsageRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Pipe-Tests',
	#package : 'Rudesheim-Pipe-Tests'
}

{ #category : 'accessing' }
PipeUsageRudesheimTest class >> targetClass [
	^ PipeRudesheim.
]

{ #category : 'accessing' }
PipeUsageRudesheimTest >> defaultBasicTarget [
	^ self targetClass
		withPipeCommands:	#(  ).
]

{ #category : 'tests' }
PipeUsageRudesheimTest >> testEchoCommandCopiesInputToOutput [
	|
		actual
		expected
	|

	actual := OrderedCollection new.
	expected := #( 1 2 3 ).

	{
		self basicTarget class Echo
	} asRHPipe
		writeStreamDo:
		[ :stream |
			stream
				nextPutAll:	expected.
		]
		readStreamDo:
		[ :stream |
			actual
				addAll:	stream.
		].

	self
		assert:	actual asArray
		equals:	expected.
]

{ #category : 'tests' }
PipeUsageRudesheimTest >> testMessageCommandTransformsInput [
	|
		actual
		expected
	|

	actual := OrderedCollection new.
	expected := #( 2 4 6 ).

	{
		self basicTarget class Message
			send:	#value:
			to:
			[ :pipeStreams |
				pipeStreams stdin
					do:
					[ :each |
						pipeStreams stdout
							nextPut:	each * 2.
					].
			]
	} asRHPipe
		writeStreamDo:
		[ :stream |
			stream
				nextPutAll:	#( 1 2 3 ).
		]
		readStreamDo:
		[ :stream |
			actual
				addAll:	stream.
		].

	self
		assert:	actual asArray
		equals:	expected.
]

{ #category : 'tests' }
PipeUsageRudesheimTest >> testMessageCommandsAreComposedInOrder [
	|
		actual
		expected
	|

	actual := OrderedCollection new.
	expected := #( 20 30 40 ).

	{
		self basicTarget class Message
			send:	#value:
			to:
			[ :pipeStreams |
				pipeStreams stdin
					do:
					[ :each |
						pipeStreams stdout
							nextPut:	each + 1.
					].
			].
		self basicTarget class Message
			send:	#value:
			to:
			[ :pipeStreams |
				pipeStreams stdin
					do:
					[ :each |
						pipeStreams stdout
							nextPut:	each * 10.
					].
			]
	} asRHPipe
		writeStreamDo:
		[ :stream |
			stream
				nextPutAll:	#( 1 2 3 ).
		]
		readStreamDo:
		[ :stream |
			actual
				addAll:	stream.
		].

	self
		assert:	actual asArray
		equals:	expected.
]
