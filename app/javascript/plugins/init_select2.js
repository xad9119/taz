
import $ from 'jquery';
import 'select2';

const initSelect2 = () => {
  $('#search_company_id').select2({ width: '100%' });
};

export { initSelect2 };
