import React from 'react'

function App() {
  return (
    <div className='aurora-outer'>
      <div className='aurora-middle'>
        <div className='aurora-inner'>
            <Welcome/>
        </div>
      </div>
    </div>
  )
}

const Welcome = () => {
  return (
    <section className='absolute right-0 top-0 backdrop-brightness-75
                        h-full w-2/3'>
      <Intro/>  
        <hr className='line1' />
      <Options/>
    </section>
    
  )
}

const Intro = () => {
  return (
    <>
      <h1 className='text-black text-right font-adventpro
                     mr-16 text-5xl mt-32'>
        Code and building. Extra refined
      </h1>
      <h3 className='text-black text-right font-novaflat 
                      mr-16 text-sm mt-6 italic'>
        An Integrated Development Environment, founded upon 
        <span className='text-primary 
                        text-shadow-md shadow-primary'> speed</span> , 
        <span className='text-primary 
                        text-shadow-md shadow-primary'> light</span> and 
        <span className='text-primary 
                        text-shadow-md shadow-primary'> time</span>
      </h3>
    </>
  )
}

const Options = () => {
  return (
    <div className='rounded-md flex flex-col mr-20 mt-14
                    w-1/3 h-1/3 mx-auto drop-shadow-2xl'>
      <button className='projectOps'>
        <img alt='newProject' 
            src='../icons/clarity-assets-master/icons/essential/plus-circle-line.svg' 
            width={30}/>
        <span className='mx-auto'>New Project</span>
      </button>
      <button className='projectOps'>
        <img alt='newProject'
          src='../icons/clarity-assets-master/icons/core/folder-open-line.svg'
          width={30} />
        <span className='mx-auto'>Open Project</span>
      </button>
      <button className='projectOps group'>
        <img alt='newProject'
          src='../icons/clarity-assets-master/icons/technology/rack-server-line.svg'
          width={30} />
        <span className='mx-auto'>Open from VCS</span>
      </button>
    </div>
  )
}

export default App