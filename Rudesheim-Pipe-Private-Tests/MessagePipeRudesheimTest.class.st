"
A RHPipeMessageTest is a test class for testing the behavior of RHPipeMessage
"
Class {
	#name : 'MessagePipeRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Pipe-Private-Tests',
	#package : 'Rudesheim-Pipe-Private-Tests'
}

{ #category : 'accessing' }
MessagePipeRudesheimTest class >> targetClass [

	^ MessagePipeRudesheim.
]

{ #category : 'accessing' }
MessagePipeRudesheimTest >> defaultBasicTarget [

	^ self targetClass
		send: #value:
		to:
		[ :streams |
		].
]

{ #category : 'accessing' }
MessagePipeRudesheimTest >> testBasicInstanceCreation [

	super testBasicInstanceCreation.
]

{ #category : 'tests' }
MessagePipeRudesheimTest >> testExecuteWithPipeStream [
	|
		pipeStreams
		expected
	|

	expected :=
		1
			to: 3.
	
	pipeStreams := StreamsPipeRudesheim new.	
	pipeStreams stdin
		nextPutAll: expected.
	
	[
		(
			self targetClass
				send: #value:
				to:
				[ :streams |
					streams stdin
						do:
						[ :each |
							streams stdout
								nextPut: each.
						]
				]
		)
			executeWithPipeStream: pipeStreams.
	] fork.
	
	expected
		do:
		[ :each |
			self
				assert: pipeStreams stdout next
				equals: each 
		].
]
