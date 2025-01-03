import axios from 'axios'

axios.defaults.withCredentials = true

const request = axios.create({
  //baseURL: 'http://localhost:8001/lbmapi/',
  baseURL: 'http://zlican.com:8001/lbmapi/',
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json',
  },
})

export default request
