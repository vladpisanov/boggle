/*
  Displays the Boggle board grid
*/

import React           from 'react'
import { useSelector } from 'react-redux'

export default function Board() {
  const board        = useSelector(state => state.board)
  const formatLetter = (letter) => (letter == 'q') ? 'Qu' : letter.toUpperCase()

  return (
    <>
      <h2>Game Board</h2>

      <table>
        <tbody>
          {board.map((row, i) => (
            <tr key={i}>
              {row.map((letter, j) => (
                <td key={j}>
                  <div className="die">{formatLetter(letter)}</div>
                </td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </>
  )
}
