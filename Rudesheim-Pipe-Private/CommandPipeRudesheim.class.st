Class {
	#name : 'CommandPipeRudesheim',
	#superclass : 'Object',
	#category : 'Rudesheim-Pipe-Private',
	#package : 'Rudesheim-Pipe-Private'
}

{ #category : 'evaluating' }
CommandPipeRudesheim class >> executeWithPipeStream: aPipeStream [

	self subclassResponsibility.
]

{ #category : 'evaluating' }
CommandPipeRudesheim >> executeWithPipeStream: aPipeStream [

	self class
		executeWithPipeStream: aPipeStream.
]
