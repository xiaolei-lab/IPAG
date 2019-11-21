export const PAGE_SIZE = 3;
export const STATUS_MAP = {
    '00': { status: 'default', text : 'saved'},
    '01': { status: 'warning', text : 'waiting'},
    '02': { status: 'processing', text : 'running'},
    '10': { status: 'success', text : 'succeed'},
    '11': { status: 'error', text : 'failed'},
};