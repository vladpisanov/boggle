/*
  A component that displays the time left as a progress bar
  and as a timestamp
*/

import React             from 'react'
import { useSelector }   from 'react-redux'
import LinearProgress    from '@material-ui/core/LinearProgress'
import { GAME_DURATION } from '../slices/Master'

export default function Timer() {
  const left = useSelector(state => state.timeLeft)

  return (
    <>
      Time left: {Math.floor(left / 60)} min {left % 60} sec
      <LinearProgress variant="determinate" value={100 * left / GAME_DURATION} />
    </>
  )
}
