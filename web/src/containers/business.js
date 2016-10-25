import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import * as actions from '../actions'

class Business extends Component {
  componentWillMount() {
    this.props.fetchBusinesses()
  }

  renderList() {
    return _.map(this.props.businesses, (business, key) => {
      return (
        <div className="business" key={key}>
          <div className="image">
            <img src={business.image} />
          </div>
          <div className="details">
            <div className="name">{business.name}</div>
            <div className="description">{business.description}</div>
            <div className="location">{business.location}</div>
            <div className="website">{business.website}</div>
            <div className="facebook-page">{business.facebook_page}</div>
            <div className="contact-number">{business.contact_number}</div>
          </div>
        </div>
      )
    })
  }

  render() {
    return (
      <div className="businesses">
        {this.renderList()}
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { businesses: state.businesses }
}

export default connect(mapStateToProps, actions)(Business)
