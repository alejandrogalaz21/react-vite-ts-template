import './App.css'

// Establecer el estilo CSS para el fondo de neón
const neonStyle = {
  background:
    'linear-gradient(90deg, rgba(204,0,255,1) 0%, rgba(0,255,255,1) 100%)',
  height: '100vh',
  display: 'flex',
  justifyContent: 'center',
  alignItems: 'center',
  color: 'white',
  fontSize: '3em',
  fontFamily: 'Arial, sans-serif',
  textShadow:
    '0 0 10px #ff00de, 0 0 20px #ff00de, 0 0 30px #ff00de, 0 0 40px #ff00de'
}

function App() {
  return <div style={neonStyle}>React Template</div>
}

export default App
