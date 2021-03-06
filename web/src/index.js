import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore, applyMiddleware } from 'redux'
import { Router, browserHistory } from 'react-router'
import reduxThunk from 'redux-thunk'

import reducers from './reducers'
import routes from './routes'

const createStoreWithMiddleware = applyMiddleware(reduxThunk)(createStore)
export const store = createStoreWithMiddleware(reducers)

render(
  <Provider store={store}>
    <Router history={browserHistory} routes={routes} />
  </Provider>, document.querySelector('.container')
)
