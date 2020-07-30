import * as types from './actionTypes';

import { genericAJAX, postFormRequest, addRedirect } from '../helpers/asyncActions'

function registerUser(form_obj) {
  const request = postFormRequest(form_obj)
  return genericAJAX('http://localhost:3001/api/users', request, {
    start: loginUserRequest,
    succeed: addRedirect(loginUserSuccess, '/'),
    fail: loginUserFailure
  })
}

function loginUser(form_obj, redirect = '/') {
  const request = postFormRequest(form_obj)
  return genericAJAX("http://localhost:3001/api/user_token", request, {
    start: loginUserRequest,
    succeed: addRedirect(loginUserSuccess, redirect),
    fail: loginUserFailure,
  });
}



function loginUserSuccess({ user, jwt }) {
  localStorage.setItem('token', jwt)
  return {
    type: types.LOGIN_USER_SUCCESS,
    payload: {
      user: user,
      token: jwt
    }
  }
}

function loginUserFailure(error) {
  localStorage.removeItem('token');
  return {
    type: types.LOGIN_USER_FAILURE,
    payload: { error }
  }
}

function loginUserRequest() {
  return {
    type: types.LOGIN_USER_REQUEST
  }
}

function logoutUser() {
  localStorage.removeItem('token');
  return {
    type: types.LOGOUT_USER
  }
}

const logoutAndRedirect = addRedirect(logoutUser, '/login');

export {
  registerUser,
  loginUser,
  logoutAndRedirect,
  loginUserSuccess,
  loginUserFailure,
  loginUserRequest,
  logoutUser
}
