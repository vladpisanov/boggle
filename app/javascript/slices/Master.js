/*
  Redux store, reducers and actions
*/

import { createSlice, configureStore, createAsyncThunk } from '@reduxjs/toolkit'
import axios from 'axios'

// Number of seconds given to the player
export const GAME_DURATION = 3 * 60

// Asyncronous action creator for fetching a new board from the server
export const fetchBoard = createAsyncThunk(
  'fetchBoard',
  async () => {
    const response = await axios.post('/board/reset')
    return response.data
  }
)

// Asyncronous action creator for checking if a word is on the board
export const findWord = createAsyncThunk(
  'findWord',
  async (word, store) => {
    word = word.toUpperCase()

    // Do some sanity checks before firing off the request to the server
    if (!word)
      return {error: 'Word cannot be blank!'}

    if (store.getState().wordsFound.find((rec) => rec.word == word))
      return {error: 'You have already found this word!'}

    const response = await axios.get(`/board/find/?word=${word}`)
    return response.data
  }
)

// Master slice
const masterSlice = createSlice({
  name: 'master',
  initialState: {
    lastError:  null,     // most recent error to be displayed; null = "no error"
    board:      null,     // 4x4 matrix of letters; null on init
    wordsFound: [],       // array of words player found, structured like [{word: "dog", score: 1}, ...]
    timeLeft:   0         // number of seconds left in the game
  },
  reducers: {
    // Resets the most-recent error
    clearLastError: state => {
      state.lastError = null
    },
    // Decreases the time left by 1s if game is still going. Should be invoked by a timer
    tickTimer: (state) => {
      if (state.timeLeft > 0)
        state.timeLeft--
    }
  },
  extraReducers: {
    [fetchBoard.pending]: (state) => {
      // TODO: could show a loading screen here
    },
    [fetchBoard.fulfilled]: (state, action) => {
      state.timeLeft   = GAME_DURATION
      state.wordsFound = []
      state.board      = action.payload.board
      state.lastError  = null
    },
    [findWord.pending]: (state) => {
      // TODO: could show a spinner here
    },
    [findWord.fulfilled]: (state, action) => {
      if (action.payload.error)
        state.lastError = action.payload.error
      else
        // Valid word!
        state.wordsFound.push({word: action.payload.word, score: action.payload.score})
    },
    [findWord.rejected]: (state, action) => {
      // Some kind of deep server/network error
      state.lastError = `Something is broken. Contact the developer! ${action.error.response}`
    }
  }
})

// Store
export const masterStore = configureStore({
  reducer: masterSlice.reducer
})

export const { tickTimer, clearLastError } = masterSlice.actions
