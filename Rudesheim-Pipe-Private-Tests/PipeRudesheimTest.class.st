"
A RHPipeTest is a test class for testing the behavior of RHPipe
"
Class {
	#name : 'PipeRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Pipe-Private-Tests',
	#package : 'Rudesheim-Pipe-Private-Tests'
}

{ #category : 'accessing' }
PipeRudesheimTest class >> targetClass [

	^ PipeRudesheim.
]

{ #category : 'accessing' }
PipeRudesheimTest >> defaultBasicTarget [

	^ self targetClass
			withPipeCommands:
			{
			}

]

{ #category : 'tests' }
PipeRudesheimTest >> testBasicInstanceCreation [

	super testBasicInstanceCreation.
]

{ #category : 'tests' }
PipeRudesheimTest >> testWriteStreamDoReadStreamDo [

	self
		testWriteStreamDoReadStreamDo0;
		tearDown;
		setUp;
		testWriteStreamDoReadStreamDo1;
		tearDown;
		setUp;
		testWriteStreamDoReadStreamDo2;
		tearDown;
		setUp;
		testWriteStreamDoReadStreamDo3;
		tearDown;
		setUp;
		testWriteStreamDoReadStreamDo4.
]

{ #category : 'tests' }
PipeRudesheimTest >> testWriteStreamDoReadStreamDo0 [
	|
		expecteds
	|
	
	expecteds :=
		1
			to: 3.
	
	(
		self targetClass
			withPipeCommands:
			{
			}
	)
		writeStreamDo:
		[ :stream |
			stream 
				nextPutAll: expecteds.
		]
		readStreamDo:
		[ :stream |
			expecteds
				do:
				[ :each |
					self
						assert: stream next
						equals: each.
				].
		].
]

{ #category : 'tests' }
PipeRudesheimTest >> testWriteStreamDoReadStreamDo1 [
	|
		expecteds
		actual
	|
	
	actual := OrderedCollection new.
	expecteds :=
		1
			to: 3.
	
	(
		self targetClass
			withPipeCommands:
			{
				EchoPipeRudesheim
			}
	)
		writeStreamDo:
		[ :stream |
			stream 
				nextPutAll: expecteds.
		]
		readStreamDo:
		[ :stream |
			actual
				addAll: stream.
		].

	self
		assert: actual asArray
		equals: expecteds  asArray.

]

{ #category : 'tests' }
PipeRudesheimTest >> testWriteStreamDoReadStreamDo2 [
	|
		expecteds
	|
	
	expecteds :=
		1
			to: 3.
	
	(
		self targetClass
			withPipeCommands:
			{
				EchoPipeRudesheim
			}
	)
		writeStreamDo:
		[ :stream |
			stream 
				nextPutAll: expecteds.
		]
		readStreamDo:
		[ :stream |
			self
				assert: stream atEnd not.
				
			expecteds :=
				expecteds 
					copyWith: 4.
		
			expecteds
				do:
				[ :each |
					stream atEnd
						ifTrue:
						[
							thisContext return.
						].
				
					self
						assert: stream next
						equals: each.
				].
		].
]

{ #category : 'tests' }
PipeRudesheimTest >> testWriteStreamDoReadStreamDo3 [
	|
		expecteds
	|
	
	expecteds :=
		1
			to: 3.
	
	(
		self targetClass
			withPipeCommands:
			{
				EchoPipeRudesheim.
				EchoPipeRudesheim.
			}
	)
		writeStreamDo:
		[ :stream |
			stream 
				nextPutAll: expecteds.
		]
		readStreamDo:
		[ :stream |
			self
				assert: stream atEnd not.
				
			expecteds :=
				expecteds 
					copyWith: 4.
		
			expecteds
				do:
				[ :each |
					stream atEnd
						ifTrue:
						[
							thisContext return.
						].
				
					self
						assert: stream next
						equals: each.
				].
		].
]

{ #category : 'tests' }
PipeRudesheimTest >> testWriteStreamDoReadStreamDo4 [
	|
		actual
	|
	
	actual := 1.
	
	self
		assert:	actual
		equals:
		(
			(
				self targetClass
					withPipeCommands:
					{
						EchoPipeRudesheim.
					}
			)
				writeStreamDo:
				[ :stream |
					stream 
						nextPut: actual.
				]
				readStreamDo:
				[ :stream |
					stream next.
				]
		)

]
