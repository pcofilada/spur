import React, { Component } from 'react'
import ReactDOM from 'react-dom'
import { store } from '../index'
import { Provider } from 'react-redux'

export default class Modal extends Component {
  componentDidMount() {
    this.modalTarget = document.createElement('div')
    this.modalTarget.className = 'modal-container'
    document.body.appendChild(this.modalTarget)
    this._render(this.props)
  }

  componentWillReceiveProps(newProps) {
    this._render(newProps)
  }

  _render(props) {
    if (props.isOpen) {
      ReactDOM.render(
        <Provider store={store}>
          <div className="modal-wrapper">
            <div className="-modal-backdrop" onClick={this.props.closeModal}></div>
            <div className="-main-modal">{this.props.children}</div>
          </div>
        </Provider>, this.modalTarget
      )
    } else {
      ReactDOM.render(<div></div>, this.modalTarget)
    }
  }

  render() {
    return <noscript />
  }
}
