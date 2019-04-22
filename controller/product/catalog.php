<?php

class ControllerProductCatalog extends Controller
{
    public function index()
    {

        $this->load->language('product/catalog');
        $this->document->setTitle($this->language->get('heading_title'));

        $data['heading_title'] = $this->language->get('heading_title');


        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );
        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('heading_title'),
            'href' => $this->url->link('product/catalog')
        );


        if (isset($this->request->get['path'])) {
            $parts = explode('_', (string)$this->request->get['path']);
        } else {
            $parts = array();
        }

        if (isset($parts[0])) {
            $data['category_id'] = $parts[0];
        } else {
            $data['category_id'] = 0;
        }

        if (isset($parts[1])) {
            $data['child_id'] = $parts[1];
        } else {
            $data['child_id'] = 0;
        }

        $this->load->model('catalog/category');

        $this->load->model('catalog/product');

        $data['categories'] = array();

        $categories = $this->model_catalog_category->getCategories(0);

        foreach ($categories as $category) {
            $children_data = array();


            $children = $this->model_catalog_category->getCategories($category['category_id']);

            foreach ($children as $child) {
                $filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);

                $children_data[] = array(
                    'category_id' => $child['category_id'],
                    'name' => $child['name'],
                    'href' => str_replace(HTTP_SERVER,'catalog/',$this->url->link('product/category', 'path=' . $child['category_id']))
                );
            }


// . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : '') //


            $filter_data = array(
                'filter_category_id' => $category['category_id'],
                'filter_sub_category' => true
            );


            $data['categories'][] = array(
                'category_id' => $category['category_id'],
                'name' => $category['name'],
                'children' => $children_data,
                'href' => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $category['category_id'])
            ));
        }
        $data['home'] = $this->url->link('common/home', '', true);
        $data['search'] = $this->load->controller('common/search');
        $data['header'] = $this->load->controller('common/header');
        $data['footer'] = $this->load->controller('common/footer');
        if(isset($_SERVER["HTTP_REFERER"])){
            $data['back'] = $_SERVER["HTTP_REFERER"];
        }else{
            $data['back'] = $this->url->link('common/home');
        }


        $this->response->setOutput($this->load->view('product/catalog', $data));
    }

}