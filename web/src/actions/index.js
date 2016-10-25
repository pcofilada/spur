import axios from 'axios'
import { FETCH_BUSINESSES } from './types'

const apiPath = 'http://localhost:3000'

export function fetchBusinesses() {
  const request = axios.get(`${apiPath}/businesses`)

  return (dispatch) => {
    request.then(({data}) => {
      dispatch({ type: FETCH_BUSINESSES, payload: data })
    })
  }
}
