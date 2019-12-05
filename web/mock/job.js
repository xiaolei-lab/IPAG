import { mock } from 'mockjs';

export default {
    'GET /api/jobs': mock({
        'total-count': 20, 
        'data|10': [
            {
                'id': 'IPAG000@string("number", 5)',
                'name': 'Cattle_@string("number", 3)' ,
                'status|1': ['00', '01', '02', '10', '11'],   // 00: saved, 01: waiting, 02: running, 10: succeed, 11: failed 
                'creation_time': '@datetime()',
                'end_time': '@datetime()',
            }
        ]
    })
}