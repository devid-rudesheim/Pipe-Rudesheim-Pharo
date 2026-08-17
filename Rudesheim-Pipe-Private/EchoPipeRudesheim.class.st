Class {
	#name : 'EchoPipeRudesheim',
	#superclass : 'CommandPipeRudesheim',
	#category : 'Rudesheim-Pipe-Private',
	#package : 'Rudesheim-Pipe-Private'
}

{ #category : 'evaluating' }
EchoPipeRudesheim class >> executeWithPipeStream: aPipeStream [

	aPipeStream stdout
		nextPutAll: aPipeStream stdin.

]
