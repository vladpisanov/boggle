/*
  Panel that allows the user to type in new words,
  and submits them to the reducer
*/

import React, { useState } from 'react'
import { useDispatch }     from 'react-redux'
import Box                 from '@material-ui/core/Box'
import TextField           from '@material-ui/core/TextField'
import Button              from '@material-ui/core/Button'
import { findWord }        from '../slices/Master'

export default function WordSubmitter() {
  const [newWord, setNewWord] = useState('')
  const dispatch              = useDispatch()

  const submitWord = () => {
    dispatch(findWord(newWord))
    setNewWord('')
  }

  const onKeyPress = (e) => {
    if (e.key === 'Enter')
      submitWord()
  }

  const onChange = (e) => {
    setNewWord(e.target.value)
  }

  return (
    <Box display="flex" mt={2} alignItems="center">
      <Box flexGrow={1}>
        <TextField
          value={newWord}
          onKeyPress={onKeyPress}
          onChange={onChange}
          variant="outlined"
          label="Your word"
          fullWidth
          margin="dense"
        />
      </Box>
      <Box ml={1}>
        <Button variant="contained" color="primary" onClick={submitWord}>Submit</Button>
      </Box>
    </Box>
  )
}