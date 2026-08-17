# Rudesheim Pipe for Pharo

[![GitHub release](https://img.shields.io/github/release/devid-rudesheim/Pipe-Rudesheim-Pharo.svg)](https://github.com/devid-rudesheim/Pipe-Rudesheim-Pharo/releases/latest)
[![Unit Tests](https://github.com/devid-rudesheim/Pipe-Rudesheim-Pharo/actions/workflows/tests.yml/badge.svg)](https://github.com/devid-rudesheim/Pipe-Rudesheim-Pharo/actions/workflows/tests.yml)

[![Pharo 13](https://img.shields.io/badge/Pharo-13-informational)](https://pharo.org)

Rudesheim Pipe is a shell-pipe-style composition mechanism for Pharo. A sequence of commands
(`SequenceableCollection>>asRHPipe`) is wired together with per-stage streams: each command reads
from `stdin` and writes to `stdout`, and adjacent commands share a stream so output flows into the
next command's input, the same way `cmd1 | cmd2 | cmd3` works in a shell.

## Installation

Load the default project group with Metacello:

```smalltalk
Metacello new
	baseline: 'RudesheimPipe';
	repository: 'github://devid-rudesheim/Pipe-Rudesheim-Pharo:main';
	load
```

This also loads the required `RudesheimKernel` and `RudesheimUtility` dependencies from GitHub.

## Usage

```smalltalk
(
	{
		Rudesheim Pipe Echo.
	} asRHPipe
)
	writeStreamDo: [ :stream | stream nextPutAll: #(1 2 3) ]
	readStreamDo: [ :stream | stream do: [ :each | Transcript showCr: each printString ] ]
```

`Rudesheim Pipe Message send: #selector to: anObject` wraps an arbitrary object/block as a pipe
command, evaluating `anObject perform: #selector with: aPipeStream` for each stage.

## Namespace

```
Rudesheim Pipe                       PipeRudesheim
  Command                            CommandPipeRudesheim
    Echo                             EchoPipeRudesheim
  Message                            MessagePipeRudesheim
  Streams                            StreamsPipeRudesheim
  SharedQueue                        SharedQueuePipeRudesheim
  EndOfStream                        EndOfStreamPipeRudesheim
```

`Rudesheim Pipe` resolves to `PipeRudesheim`; each child is reached from `PipeRudesheim class`'s
namespace accessors (e.g. `PipeRudesheim class >> Command`), following the same
`<role><parent>` naming convention as `Rudesheim TableQuery` (see
[Table-Query-Rudesheim-Pharo](https://github.com/devid-rudesheim/Table-Query-Rudesheim-Pharo)).

## Requirements

- Pharo with Metacello.

## Dependencies

The baseline loads these repositories:

- `RudesheimKernel`: `github://devid-rudesheim/Kernel-Rudesheim-Pharo:main`
- `RudesheimUtility`: `github://devid-rudesheim/Utility-Rudesheim-Pharo:main`

## Groups

- `#core`: `Rudesheim-Pipe-Private`, `Rudesheim-Pipe`
- `#tests`: `Rudesheim-Pipe-Private-Tests`, `Rudesheim-Pipe-Tests`
- `#default`: `#core`

## Development

Load the `tests` group to run the unit tests:

```smalltalk
Metacello new
	baseline: 'RudesheimPipe';
	repository: 'github://devid-rudesheim/Pipe-Rudesheim-Pharo:main';
	load: #('tests')
```
