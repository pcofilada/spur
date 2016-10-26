import {
  FETCH_BUSINESSES,
  SEARCH
} from '../actions/types'

export default function(state={}, action){
  switch(action.type) {
    case FETCH_BUSINESSES:
      return action.payload
    case SEARCH:
      return action.payload
  }

  return state
}
