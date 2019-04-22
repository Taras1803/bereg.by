<?php
class ControllerExtensionModuleIntentBrands extends Controller {
    public function index($setting) {
        $this->load->language('extension/module/intent_brands');

        $data['heading_title'] = $this->language->get('heading_title');

        $data['text_tax'] = $this->language->get('text_tax');

        $data['button_cart'] = $this->language->get('button_cart');
        $data['button_wishlist'] = $this->language->get('button_wishlist');
        $data['button_compare'] = $this->language->get('button_compare');

        $this->load->model('catalog/manufacturer');

        $this->load->model('tool/image');

        $data['products'] = array();

        if (!$setting['limit']) {
            $setting['limit'] = 4;
        }

        if (!empty($setting['product'])) {
            $products = array_slice($setting['product'], 0, (int)$setting['limit']);

            foreach ($products as $product_id) {
                $product_info = $this->model_catalog_manufacturer->getManufacturer($product_id);
                if ($product_info) {
                    if ($product_info['image']) {
                        $image = $this->model_tool_image->resize($product_info['image'], $setting['width'], $setting['height']);
                    } else {
                        $image = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                    }
                    if ($product_info['image2']) {
                        $image2 = $this->model_tool_image->resize($product_info['image2'], $setting['width'], $setting['height']);
                    } else {
                        $image2 = $this->model_tool_image->resize('placeholder.png', $setting['width'], $setting['height']);
                    }

                    $data['products'][] = array(
                        'product_id'  => $product_info['manufacturer_id'],
                        'thumb'       => $image,
                        'thumb2'       => $image2,
                        'name'        => $product_info['name'],
                        'href'        => str_replace(HTTP_SERVER,'manufacturers/', $this->url->link('product/manufacturer/info', 'manufacturer_id=' . $product_info['manufacturer_id']))
                    );
                }
            }
        }
        $data['brands'] = $this->url->link('product/manufacturer');

        if ($data['products']) {
            return $this->load->view('extension/module/intent_brands', $data);
        }
    }
}