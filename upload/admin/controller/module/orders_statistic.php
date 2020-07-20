<?php

class ControllerModuleOrdersStatistic extends Controller {    

    public function index() {

        $this->load->language('module/orders_statistic');
        $this->load->model('module/orders_statistic');

        $this->document->setTitle($this->language->get('heading_title'));
        
        $statistic = array();
        
        $data['is_fail'] = $data['is_success'] = '';
        
        if (isset($this->request->post['date_from']) && isset($this->request->post['type'])) {
            
            $date_from = $this->request->post['date_from'];
            
            if (!$date_from){
                $data['is_fail'] = $this->language->get('error_date_from');
            }
            else{
                $date_to = $this->request->post['date_to'];
                $type = $this->request->post['type']; 

                $statistic = $this->module_orders_statistic->getStatistic($date_from, $date_to, $type);
                
                
                
                
            }
            
        }

     
        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
        );

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('module/orders_statistic', 'token=' . $this->session->data['token'], true)
        );

        $data['start'] = $this->url->link('module/orders_statistic', 'token=' . $this->session->data['token'], true);
        $data['token'] = $this->session->data['token'];

        $data['heading_title'] = $this->language->get('heading_title');
//        $data['text_success'] = $this->language->get('text_success');
//        $data['text_fail'] = $this->language->get('text_fail');
       

       

        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/products_replace', $data));
    }

    public function start() {
        $this->load->language('module/products_replace');
        $this->load->model('module/products_replace');

        if (isset($this->request->post['categories']) && isset($this->request->post['to_category_id'])) {

            $category_to = (int) $this->request->post['to_category_id'];
            $categories = $this->request->post['categories'];

            $replace_to = (isset($this->request->post['replace_to'])) ? 1 : 0;
            $replace_from = (isset($this->request->post['replace_from'])) ? 1 : 0;

            $this->model_module_products_replace->startReplace($categories, $category_to, $replace_to, $replace_from);

            $this->session->data['is_success'] = $this->language->get('text_success');
        } else {
            $this->session->data['is_fail'] = $this->language->get('text_fail');
        }
        $this->response->redirect($this->url->link('module/products_replace', 'token=' . $this->session->data['token'], true));
    }

}
