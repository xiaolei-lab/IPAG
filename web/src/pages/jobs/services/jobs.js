import { PAGE_SIZE } from '../constants';
import request from '@/utils/request';

export function fetch({ page = 1 }) {
  return request(`/api/jobs?_page=${page}&_limit=${PAGE_SIZE}`);
}

export function remove(id) {
  return request(`/api/jobs/${id}`, {
    method: 'DELETE',
  });
}

export function patch(id, values) {
  return request(`/api/jobs/${id}`, {
    method: 'PATCH',
    body: JSON.stringify(values),
  });
}

export function create(values) {
  return request('/api/jobs', {
    method: 'POST',
    body: JSON.stringify(values),
  });
}