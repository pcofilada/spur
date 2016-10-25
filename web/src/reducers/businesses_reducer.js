import { FETCH_BUSINESSES } from '../actions/types'

export default function(state={}, action){
  switch(action.type) {
    case FETCH_BUSINESSES:
      return action.payload
  }

  return state
}
