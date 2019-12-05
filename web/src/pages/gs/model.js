// import * as jobsService from './services/jobs';

export default {
  namespace: 'gs',
  state: {
    current_step: 0,
  },
  reducers: {
    save(state, { payload: { current_step } }) {
      return { ...state, current_step };
    },
  },
//   effects: {
//     *fetch({ payload: { page = 1 } }, { call, put }) {
//       const { data } = yield call(jobsService.fetch, { page });
//       yield put({
//         type: 'save',
//         payload: {
//           data: data['data'],
//           total: parseInt(data['total-count'], 10),
//           page: parseInt(page, 10),
//         },
//       });
//     },
//     *remove({ payload: id }, { call, put, select }) {
//       yield call(jobsService.remove, id);
//       const page = yield select(state => state.jobs.page);
//       yield put({ type: 'fetch', payload: { page } });
//     },
//     // *patch({ payload: { id, values } }, { call, put, select }) {
//     //   yield call(jobsService.patch, id, values);
//     //   const page = yield select(state => state.jobs.page);
//     //   yield put({ type: 'fetch', payload: { page } });
//     // },
//     // *create({ payload: values }, { call, put, select }) {
//     //   yield call(jobsService.create, values);
//     //   const page = yield select(state => state.jobs.page);
//     //   yield put({ type: 'fetch', payload: { page } });
//     // },
//   },
//   subscriptions: {
//     setup({ dispatch, history }) {
//       return history.listen(({ pathname, query }) => {
//         if (pathname === '/jobs') {
//           dispatch({ type: 'fetch', payload: query });
//         }
//       });
//     },
//   },
};