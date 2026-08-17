"
A RHSharedQueueTest is a test class for testing the behavior of RHSharedQueue
"
Class {
	#name : 'SharedQueuePipeRudesheimTest',
	#superclass : 'BasicRudesheimTest',
	#category : 'Rudesheim-Pipe-Private-Tests',
	#package : 'Rudesheim-Pipe-Private-Tests'
}

{ #category : 'accessing' }
SharedQueuePipeRudesheimTest class >> targetClass [

	^ SharedQueuePipeRudesheim
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testAtEnd [

	self
		testAtEnd0;
		tearDown;
		setUp;
		testAtEnd1;
		tearDown;
		setUp;
		testAtEnd2;
		tearDown;
		setUp;
		testAtEnd3.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testAtEnd0 [

	self
		should: 
		[
			self basicTarget atEnd. 
		]
		raise: TestTookTooMuchTime.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testAtEnd1 [
	|
		target
	|
	
	target := self basicTarget.
	target
		nextPut: 1.

	self
		assert: target atEnd not
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testAtEnd2 [
	|
		target
	|
	
	target := self basicTarget.
	target
		close.

	self
		assert: target atEnd.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testAtEnd3 [
	|
		target
	|
	
	target := self basicTarget.
	target
		nextPut: 1;
		close.

	self
		assert: target atEnd not;
		assert: target next equals: 1;
		assert: target atEnd.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testBasicInstanceCreation [

	super testBasicInstanceCreation.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testNext [

	self
		testNext0;
		tearDown;
		setUp;
		testNext1.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testNext0 [
	|
		target
	|
	
	target := self basicTarget.
	target
		nextPut: 1.

	self
		assert: target next
		equals: 1.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testNext1 [
	|
		target
	|
		
	target := self basicTarget.
	target close.

	self
		should: 
		[
			target next.
		]
		raise: self targetClass endOfStreamError.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testPeek [

	self
		testPeek0;
		tearDown;
		setUp;
		testPeek1;
		tearDown;
		setUp;
		testPeek2.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testPeek0 [
	|
		target
	|
	
	target := self basicTarget.
	target
		nextPut: 1.

	self
		assert: target peek
		equals: 1.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testPeek1 [
	|
		target
	|
		
	target := self basicTarget.
	target close.

	self
		should: 
		[
			target peek.
		]
		raise: self targetClass endOfStreamError.
]

{ #category : 'tests' }
SharedQueuePipeRudesheimTest >> testPeek2 [
	|
		target
	|
	
	target := self basicTarget.

	self
		assert: target peek
		equals: nil.
]
