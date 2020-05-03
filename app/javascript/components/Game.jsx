/*
  Top level UI that glues together the core
  components of the game
*/

import React           from 'react'
import { useDispatch } from 'react-redux'
import ErrorPopup      from './ErrorPopup'
import Board           from './Board'
import FoundWords      from './FoundWords'
import Timer           from './Timer'
import WordSubmitter   from './WordSubmitter'

import { masterStore, fetchBoard, tickTimer } from '../slices/Master'

import Button from '@material-ui/core/Button'
import Grid   from '@material-ui/core/Grid'
import Box    from '@material-ui/core/Box'

// import Dialog from '@material-ui/core/Dialog'
// import DialogTitle from '@material-ui/core/DialogTitle'
// import DialogContent from '@material-ui/core/DialogContent'



setInterval(() => masterStore.dispatch(tickTimer()), 1000)

export default function Game() {
  const dispatch = useDispatch()
  const startNewGame  = () => dispatch(fetchBoard())

  return (
    <>
      <ErrorPopup />
      
      <Box display="flex" justifyContent="flex-end">
        <Button variant="contained" color="secondary" onClick={startNewGame}>New Game!</Button>
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

