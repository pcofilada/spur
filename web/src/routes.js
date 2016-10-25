import React from 'react'
import { Router, Route, IndexRoute, browserHistory } from 'react-router'

import App from './components/app'
import Business from './containers/business'

export default (
  <Router history={browserHistory}>
    <Route path='/' component={App}>
      <IndexRoute component={Business} />
    </Route>
  </Router>
)
