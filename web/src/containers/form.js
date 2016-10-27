import React, { Component } from 'react'
import { connect } from 'react-redux'
import { Field, reduxForm } from 'redux-form'
import { submitBusiness } from '../actions/index'

const renderInputField = ({ input, label, type, placeholder, meta: { touched, error, warning } }) => (
  <div className="form-group">
    <label>{label}</label>
    <input {...input} type={type} className={`form-control ${ touched && error ? 'error' : null }`} placeholder={placeholder} />
    { touched && error ? <small className="error-hint">{error}</small> : null }
  </div>
)

const renderTextareaField = ({ input, label, placeholder, descriptionLength, onChangeAction, descriptionValue, meta: { touched, error, warning } }) => (
  <div className="form-group">
    <label>{label}</label>
    <textarea {...input} className={`form-control ${ touched && error ? 'error' : null }`} placeholder={placeholder} maxLength="140"  onChange={onChangeAction} value={descriptionValue} />
    { touched && error ? <small className="error-hint">{error}</small> : null }
    <span className="remaining">{140 - descriptionLength} remaining</span>
  </div>
)

class Form extends Component {
  constructor(props) {
    super(props)

    this.state = { description: '' }

    this.onInputChange = this.onInputChange.bind(this)
  }

  onSubmit(props) {
    this.props.submitBusiness(props)
  }

  onInputChange(e) {
    this.setState({ description: e.target.value })
  }

  render() {
    const { handleSubmit, pristine, reset, submitting } = this.props

    return (
      <form onSubmit={handleSubmit(this.onSubmit.bind(this))}>
        <h3 className="title-heading">Submit Business</h3>
        <Field name="image" type="text" component={renderInputField} label="Logo url or Image url" placeholder="Logo url or Image url"/>
        <Field name="name" type="text" component={renderInputField} label="Name" placeholder="Business name"/>
        <Field name="description" component={renderTextareaField} label="Description" placeholder="Tell me about your business..." descriptionLength={this.state.description.length} onChangeAction={this.onInputChange} descriptionValue={this.state.descrition} />
        <Field name="location" type="text" component={renderInputField} label="Location" placeholder="Business address"/>
        <Field name="contact_number" type="text" component={renderInputField} label="Contact Number" placeholder="Business contact number"/>
        <Field name="website" type="text" component={renderInputField} label="Website" placeholder="Business website url"/>
        <Field name="facebook_page" type="text" component={renderInputField} label="Facebook Page" placeholder="Business facebook page url"/>
        <Field name="services" type="text" component={renderInputField} label="Services" placeholder="Services catered (Ex. travel,transportation,startup )"/>
        <div className="form-group">
          <button type="submit" className={`btn btn-primary btn-block ${submitting ? 'is-loading' : ''}`} disabled={pristine || submitting}>Submit</button>
        </div>
      </form>
    )
  }
}

function validate(values) {
  const regexp = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/
  const errors = {}

  if (!values.image) {
    errors.image = 'Enter business image url.'
  } else if (!regexp.test(values.image)) {
    errors.image = 'Image url is invalid.'
  }

  if (!values.name) {
    errors.name = 'Enter business name.'
  }

  if (!values.description) {
    errors.description = 'Enter business description.'
  }

  if (!values.location) {
    errors.location = 'Enter business address.'
  }

  if (!values.contact_number) {
    errors.contact_number = 'Enter business contact number.'
  }

  if (!values.website) {
    errors.website = 'Enter business website url.'
  } else if (!regexp.test(values.website)) {
    errors.website = 'Website url is invalid.'
  }

  if (!values.facebook_page) {
    errors.facebook_page = 'Enter business facebook page url.'
  } else if (!regexp.test(values.facebook_page)) {
    errors.facebook_page = 'Facebook page url is invalid.'
  }

  if (!values.services) {
    errors.services = 'Enter business services catered.'
  }

  return errors
}

export default connect(null, { submitBusiness })(reduxForm({
  form: 'submitBusinessForm',
  validate
})(Form))
