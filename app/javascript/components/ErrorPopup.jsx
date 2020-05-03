/*
  A pop-up alert that is displayed whenever the global
  state's `lastError` is set. Hides automatically in 5s
*/

import React from 'react'
import { useSelector, useDispatch } from 'react-redux'
import Alert from '@material-ui/lab/Alert'
import Snackbar from '@material-ui/core/Snackbar'
import { clearLastError } from '../slices/Master.js'

export default function ErrorPopup() {
  const error    = useSelector(state => state.lastError)
  const dispatch = useDispatch()
  const close    = () => dispatch(clearLastError())

  return (
    <Snackbar open={!!error} autoHideDuration={5000} onClose={close} key={error}>
      <Alert onClose={close} severity="error">
        {error}
      </Alert>
    </Snackbar>
  )
}
