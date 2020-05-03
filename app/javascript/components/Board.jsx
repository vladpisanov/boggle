/*
  Displays the Boggle board grid
*/

import React           from 'react'
import { useSelector } from 'react-redux'
import Chip            from '@material-ui/core/Chip'

export default function Board() {
  const board = useSelector(state => state.board)
  
  return (
    <>
      <h2>Game Board</h2>
      
      <table>
        {board.map((row, i) => (
          <tr key={i}>
            {row.map((letter, j) => (
              <td key={j}>
                <Chip label={letter} color="primary" variant="outlined" size="medium" style={{fontFamily: 'monospace'}}/>
              </td>
            ))}
          </tr>
        ))}
      </table>
    </>
  )
}
