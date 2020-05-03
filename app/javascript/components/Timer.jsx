/*
  A component that displays the time left as a progress bar
  and as a timestamp
*/

import React           from 'react'
import { useSelector } from 'react-redux'
import LinearProgress  from '@material-ui/core/LinearProgress'

export default function Timer() {
  const left = useSelector(state => state.timeLeft)
  
  return (
    <>
      Time left: {Math.floor(left / 60)} min {left % 60} sec
      <LinearProgress variant="determinate" value={100 * left / (3 * 60)} />
    </>
  )
}
