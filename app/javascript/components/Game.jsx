/*
  Top level UI that glues together the core
  components of the game
*/

import React                        from 'react'
import { useSelector, useDispatch } from 'react-redux'
import Button                       from '@material-ui/core/Button'
import Grid                         from '@material-ui/core/Grid'
import Box                          from '@material-ui/core/Box'
import ErrorPopup                   from './ErrorPopup'
import Board                        from './Board'
import FoundWords                   from './FoundWords'
import Timer                        from './Timer'
import WordSubmitter                from './WordSubmitter'
import { masterStore, fetchBoard, tickTimer } from '../slices/Master'


setInterval(() => masterStore.dispatch(tickTimer()), 1000)

export default function Game() {
  const ended         = useSelector(state => state.timeLeft == 0)
  const hasBoard      = useSelector(state => !!state.board)
  const words         = useSelector(state => state.wordsFound)
  const dispatch      = useDispatch()
  const startNewGame  = () => dispatch(fetchBoard())
  const newGameButton = <Button variant="contained" color="secondary" onClick={startNewGame}>
                          New Game!
                        </Button>

  if (!hasBoard)
    // The game hasn't started yet (first load)
    return (
      <>
        <h1>Let's play Boggle!</h1>
        <p>
          Click the button to start a new game!
          ( <a href="https://en.wikipedia.org/wiki/Boggle">Rules</a> )
        </p>
        {newGameButton}
      </>
    )

  if (ended) {
    // A game ran out of time. Show final score
    const score = words.reduce((acc, x) => acc + x.score, 0)
    return (
      <>
        <h1>Time's up!</h1>
        <p>You found {words.length} word(s) for a total score of <strong>{score}</strong></p>
        {newGameButton}
      </>
    )
  }

  // General case, game in progress
  return (
    <>
      <ErrorPopup />
      <Box display="flex" justifyContent="flex-end">
        {newGameButton}
      </Box>
      <Timer />
      <Grid container>
        <Grid item xs={6}>
          <Board />
          <WordSubmitter />
        </Grid>
        <Grid item xs={6}>
          <FoundWords />
        </Grid>
      </Grid>
    </>
  )
}
