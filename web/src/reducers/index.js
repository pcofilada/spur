import { combineReducers } from 'redux'
import businessesReducer from './businesses_reducer'

const rootReducer = combineReducers({
  businesses: businessesReducer
})

export default rootReducer
