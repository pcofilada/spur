import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import App from './components/app'
import Index from './components/index'

export default (
  <Router history={browserHistory}>
    <Route path='/' component={App}>
      <IndexRoute component={Index} />
    </Route>
  </Router>
)
