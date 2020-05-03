/*
  A list to display all found words so far, along with their scores
*/

import React           from 'react'
import { useSelector } from 'react-redux'

export default function FoundWords() {
  const words = useSelector(state => state.wordsFound)

  return (
    <>
      <h2>Found Words</h2>
      <ul>
        {words.map(word => (
          <li key={word}>
            {word.word.toUpperCase()} <small>({word.score}pts)</small>
          </li>
        ))}
      </ul>
    </>
  )
}
