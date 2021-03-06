import axios from 'axios'
import {
  FETCH_BUSINESSES,
  SEARCH,
  SUBMIT_BUSINESS
} from './types'

const apiPath = 'http://localhost:3000'

export function fetchBusinesses() {
  const request = axios.get(`${apiPath}/businesses`)

  return (dispatch) => {
    request.then(({data}) => {
      dispatch({ type: FETCH_BUSINESSES, payload: data })
    })
  }
}

export function search(query) {
  const request = axios.get(`${apiPath}/search?query=${query}`)

  return (dispatch) => {
    request.then(({data}) => {
      dispatch({ type: SEARCH, payload: data })
    })
  }
}

export function submitBusiness(props) {
  const request = axios.post(`${apiPath}/businesses`,  { business: props })

  return (dispatch) => {
    request.then(({data}) => {
      dispatch({ type: SUBMIT_BUSINESS, payload: data })
    })
  }
}
