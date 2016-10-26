import React, { Component } from 'react'
import { connect } from 'react-redux'
import { bindActionCreators } from 'redux'
import { search } from '../actions/index'

class Search extends Component {
  constructor(props) {
    super(props)

    this.state = { query: '' }

    this.onInputChange = this.onInputChange.bind(this);
  }

  onInputChange(e) {
    this.setState({ query: e.target.value })

    setTimeout(() => {
      this.props.search(this.state.query)
    }, 100)
  }

  render() {
    return(
      <form className="search">
        <div className="form-group">
          <input type="text" className="form-control search-input" placeholder="What are you looking for?" value={this.state.query} onChange={this.onInputChange} />
        </div>
      </form>
    )
  }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators({ search }, dispatch)
}

export default connect(null, mapDispatchToProps)(Search)
