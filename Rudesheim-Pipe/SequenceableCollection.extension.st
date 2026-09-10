Extension { #name : 'SequenceableCollection' }

{ #category : '*Rudesheim-Pipe' }
SequenceableCollection >> asRHPipe [
	^ Rudesheim Pipe
		withPipeCommands:	self.
]
