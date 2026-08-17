Class {
	#name : 'SharedQueuePipeRudesheim',
	#superclass : 'SharedQueue',
	#category : 'Rudesheim-Pipe-Private',
	#package : 'Rudesheim-Pipe-Private'
}

{ #category : 'constants' }
SharedQueuePipeRudesheim class >> endOfStream [

	^ self endOfStreamError.
]

{ #category : 'constants' }
SharedQueuePipeRudesheim class >> endOfStreamError [

	^ EndOfStreamPipeRudesheim.
]

{ #category : 'testing' }
SharedQueuePipeRudesheim >> atEnd [
	
	^ monitor
		critical: 
		[
			monitor
				waitWhile:
				[
					items isEmpty.
				].
			
			self class endOfStream = super peek.
		].
]

{ #category : 'open/close' }
SharedQueuePipeRudesheim >> close [

	self
		nextPut:  self class endOfStream.
]

{ #category : 'accessing' }
SharedQueuePipeRudesheim >> next [
	|
		item
	|
	
	item := super next.
	
	self class endOfStream = item 
		ifTrue:
		[
			self class endOfStreamError signal.
		].
	
	^ item.
]

{ #category : 'accessing' }
SharedQueuePipeRudesheim >> peek [
	|
		item
	|
	
	item := super peek.
	
	self class endOfStream = item 
		ifTrue:
		[
			self class endOfStreamError signal.
		].
	
	^ item.
]
