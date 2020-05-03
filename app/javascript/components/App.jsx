/*
  Root app. Simply wraps Game in a Redux provider
  and a Material-UI Container
*/

import React           from 'react'
import { Provider }    from 'react-redux'
import Container       from '@material-ui/core/Container'
import { masterStore } from '../slices/Master'
import Game            from './Game'

export default function App() {
  return (
    <Provider store={masterStore}>
      <Container maxWidth="md">
        <Game />
      </Container>
    </Provider>
  )
}