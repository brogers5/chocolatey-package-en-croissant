
## En Croissant - The Ultimate Chess Toolkit

En-Croissant is an open-source, cross-platform chess GUI that aims to be powerful, customizable and easy to use.

![En Croissant screenshot](https://cdn.jsdelivr.net/gh/brogers5/chocolatey-package-en-croissant@997009f54daa82d14c05998c3f979e1418641b45/Screenshot.webp)

### Features

- Play Chess offline
  - Play against an Engine or a friend locally
  - Configure a custom time control, or take your time with an Unlimited clock
  - Use the same or differing time settings for both players
  - Prepare a Repertoire and train with spaced repetition
  - Train your chess skills with Puzzles
    - Native support for [Lichess Puzzles](https://lichess.org/training)
- Store games
  - Create games from either Portable Game Notation (PGN) or Forsyth-Edwards Notation (FEN)
  - Import from a PGN file
  - Download previously played games from [Lichess](https://lichess.org/) and [Chess.com](https://www.chess.com/)
  - Save games as PGN files
- Engine integration and management
  - Native support for some popular local engines (e.g. [Stockfish](https://stockfishchess.org/), [Leela Chess Zero](https://lczero.org/), [Komodo](https://komodochess.com/))
  - Query select cloud-based engines (i.e. [ChessDB](https://www.chessdb.cn/), [Lichess Cloud](https://lichess.org/))
  - Supports all Universal Chess Interface (UCI) engines
- Database analysis and management
  - Native support for some popular databases
    - [Ajedrez Data's Over the Board (OTB)](https://ajedrezdata.com/databases/otb/)
    - [Ajedrez Data's Correspondence (CORR)](https://ajedrezdata.com/databases/corr/)
    - [Caissabase](http://caissabase.co.uk/)
    - [MillionBase](https://rebel13.nl/rebel13/rebel%2013.html)
  - Create a database from a [Lichess](https://lichess.org/) or [Chess.com](https://www.chess.com/) account's game history
  - Track player wins/draws/losses, Elo, [International Chess Federation (FIDE) statistics](https://ratings.fide.com/), and openings
  - Track tournament games and leaderboards
  - Merge player records
  - Prune empty or duplicate games
- Analyze games
  - Set up and play a past game from a given position
  - Run multiple Engines to find the optimal move
  - Search a reference database for exact or similar games, and forecast the current game's results with a given move
  - Annotate moves

## Package Notes

The installer executed by this package was built using Nullsoft Scriptable Install System (NSIS). For advanced setup scenarios, refer to [NSIS's command-line interface documentation](https://nsis.sourceforge.io/Docs/Chapter3.html#installerusage). Any desired arguments can be appended to (or optionally overriding with the `--override-arguments` switch) the package's default install arguments with the `--install-arguments` option.

---

For future upgrade operations, consider opting into Chocolatey's `useRememberedArgumentsForUpgrades` feature to avoid having to pass the same arguments with each upgrade:

```shell
choco feature enable --name="'useRememberedArgumentsForUpgrades'"
```
