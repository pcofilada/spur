import { combineReducers } from 'redux'
import { reducer as formReducer } from 'redux-form'
import businessesReducer from './businesses_reducer'

const rootReducer = combineReducers({
  businesses: businessesReducer,
  form: formReducer
})

export default rootReducer
