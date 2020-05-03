/*
  A list to display all found words so far, along with their scores.
  Triggers a confetti rain every time a word is added.
*/

import React, { useState, useEffect } from 'react'
import { useSelector }                from 'react-redux'
import Confetti                       from 'react-confetti'

export default function FoundWords(props) {
  const words                 = useSelector(state => state.wordsFound)
  const [runConf, setRunConf] = useState(false)

  // Watch for changes in words; anytime the list grows, re-trigger the confetti
  useEffect(() => {
    if (words.length)
      setRunConf(true)
  }, [words])

  const afterConfetti = (confetti) => {
    setRunConf(false)
    confetti.reset()
  }

  return (
    <>
      <Confetti gravity={0.3} initialVelocityY={20} recycle={false} run={runConf} onConfettiComplete={afterConfetti} />

      <h2>Found Words</h2>
      <ul>
        {words.map(rec => (
          <li key={rec.word}>
            {rec.word.toUpperCase()} <small>({rec.score}pts)</small>
          </li>
        ))}
      </ul>
    </>
  )
}
