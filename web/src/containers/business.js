import _ from 'lodash'
import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Link } from 'react-router'
import * as actions from '../actions'

import Search from '../containers/search'

class Business extends Component {
  componentWillMount() {
    this.props.fetchBusinesses()
  }

  renderServices(services) {
    return _.map(services, (service, key) => {
      return (
        <span className="service" key={key}>{service}</span>
      )
    })
  }

  renderList() {
    return _.map(this.props.businesses, (business, key) => {
      const imageStyle = {
        backgroundImage: `url('${business.image}')`
      }

      return (
        <div className="business" key={key}>
          <div className="wrapper">
            <div className="image" style={imageStyle}></div>
            <div className="details">
              <div className="name">{business.name}</div>
              <div className="description">{business.description}</div>
              <div className="meta">
                <div className="meta-group">
                  <div className="location">
                    <i className="ion-ios-location"></i>
                    {business.location}
                  </div>
                  <div className="contact-number">
                    <i className="ion-ios-telephone"></i>
                    {business.contact_number}
                  </div>
                </div>
                <div className="meta-group">
                  <div className="website">
                    <Link to={business.website} target="_blank">
                      <i className="ion-android-globe"></i>
                      Website
                    </Link>
                  </div>
                  <div className="facebook-page">
                    <Link to={business.facebook_page} target="_blank">
                      <i className="ion-social-facebook"></i>
                      Facebook Page
                    </Link>
                  </div>
                </div>
                <div className="services">Services: {this.renderServices(business.services)}</div>
              </div>
            </div>
          </div>
        </div>
      )
    })
  }

  renderBlankslate() {
    return (
      <div className="blankslate">
        <div className="icon"><i className="ion-sad-outline"></i></div>
        <p className="hint">Sorry, we're not able to find what you were looking for.</p>
      </div>
    )
  }

  render() {
    let businesses

    if(this.props.businesses != null && this.props.businesses.length > 0) {
      businesses = (this.renderList())
    } else {
      businesses = (this.renderBlankslate())
    }

    return (
      <div className="wrapper">
        <Search />
        <div className="businesses">
          {businesses}
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return { businesses: state.businesses }
}

export default connect(mapStateToProps, actions)(Business)
