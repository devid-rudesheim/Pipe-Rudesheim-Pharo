Class {
	#name : 'MessagePipeRudesheim',
	#superclass : 'CommandPipeRudesheim',
	#traits : 'TShouldntNewRudesheim',
	#classTraits : 'TShouldntNewRudesheim classTrait',
	#instVars : [
		'target',
		'selector'
	],
	#category : 'Rudesheim-Pipe-Private',
	#package : 'Rudesheim-Pipe-Private'
}

{ #category : 'instance creation' }
MessagePipeRudesheim class >> send: aSelectorSymbol
to: anObject [ 

	^ super new
		setTarget: anObject 
		selector: aSelectorSymbol
]

{ #category : 'evaluating' }
MessagePipeRudesheim >> executeWithPipeStream: aPipeStream [

	^ target
		perform: selector
		with: aPipeStream.
]

{ #category : 'initialization' }
MessagePipeRudesheim >> setTarget: anObject
selector: aSelectorSymbol [

	target := anObject.
	selector := aSelectorSymbol.
]
