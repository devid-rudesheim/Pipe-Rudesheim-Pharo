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
		for: #common
		do:
		[
			spec
				baseline: 'RudesheimUtility'
				with: [ spec repository: 'github://devid-rudesheim/Utility-Rudesheim-Pharo:develop' ];

				baseline: 'RudesheimKernel'
				with: [ spec repository: 'github://devid-rudesheim/Kernel-Rudesheim-Pharo:develop' ];

				package: 'Rudesheim-Pipe-Private'
				with:
				[
					spec
						requires: #( 'RudesheimUtility' 'RudesheimKernel' )
				];

				package: 'Rudesheim-Pipe'
				with:
				[
					spec
						requires: #( 'Rudesheim-Pipe-Private' )
				];

				project: 'RudesheimUtilityTests'
				copyFrom: 'RudesheimUtility'
				with:
				[
					spec loads: #( 'tests' )
				];

				package: 'Rudesheim-Pipe-Private-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Pipe' 'RudesheimUtilityTests' )
				];

				package: 'Rudesheim-Pipe-Tests'
				with:
				[
					spec
						requires: #( 'Rudesheim-Pipe' 'RudesheimUtilityTests' )
				];

				group:		#core
				with:		#( 'Rudesheim-Pipe-Private' 'Rudesheim-Pipe' );

				group:		#tests
				with:		#( 'Rudesheim-Pipe-Private-Tests' 'Rudesheim-Pipe-Tests' );

				group:		#default
				with:		#( #core ).
		]
]
