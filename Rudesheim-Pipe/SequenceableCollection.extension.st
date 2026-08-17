Extension { #name : 'SequenceableCollection' }

{ #category : '*Rudesheim-Pipe' }
SequenceableCollection >> asRHPipe [

	^ PipeRudesheim
		withPipeCommands: self.
]
