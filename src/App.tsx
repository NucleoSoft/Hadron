import React from 'react'

function App() {
  return (
    <div className='aurora-outer'>
      <div className='aurora-middle'>
        <div className='aurora-inner'>
          <Intro/>
          <hr className='line1'/>
        </div>
      </div>
    </div>
  )
}

const Intro = () => {
  return (
    <>
      <h1 className='text-white text-right font-adventpro
                     mr-16 text-7xl mt-28'>
        Best IDE
      </h1>
      <h3 className='text-white text-right font-novaflat 
                      mr-16 text-lg mt-4 italic'>
        version 0.1.0
      </h3>
    </>
  )
}

export default App