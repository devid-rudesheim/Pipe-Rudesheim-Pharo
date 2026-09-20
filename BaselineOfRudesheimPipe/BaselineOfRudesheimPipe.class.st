Class {
	#name : 'BaselineOfRudesheimPipe',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfRudesheimPipe',
	#package : 'BaselineOfRudesheimPipe'
}

{ #category : 'baselines' }
BaselineOfRudesheimPipe >> baseline: spec [
	<baseline>

	spec
		for:	#common
		do:
		[
			spec
				baseline:	'RudesheimKernel'
				with:
				[
					spec
						repository:	'github://devid-rudesheim/Kernel-Rudesheim-Pharo:develop'.
				];
				package:	'Rudesheim-Pipe-Private'
				with:
				[
					spec
						requires:	#( 'RudesheimKernel' ).
				];
				package:	'Rudesheim-Pipe'
				with:
				[
					spec
						requires:	#( 'Rudesheim-Pipe-Private' ).
				];
				project:	'RudesheimKernelTests'
				copyFrom:	'RudesheimKernel'
				with:
				[
					spec
						loads:	#( 'tests' ).
				];
				package:	'Rudesheim-Pipe-Private-Tests'
				with:
				[
					spec
						requires:	#( 'Rudesheim-Pipe' 'RudesheimKernelTests' ).
				];
				package:	'Rudesheim-Pipe-Tests'
				with:
				[
					spec
						requires:	#( 'Rudesheim-Pipe' 'RudesheimKernelTests' ).
				];
				group:	#core
				with:	#( 'Rudesheim-Pipe-Private' 'Rudesheim-Pipe' );
				group:	#tests
				with:	#( 'Rudesheim-Pipe-Private-Tests' 'Rudesheim-Pipe-Tests' );
				group:	#default
				with:	#( #core ).
		].
]
