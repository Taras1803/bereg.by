<?php
class ControllerProductCategory extends Controller {
    private $arr = [];
    protected $path_cat =[];
	public function index() {

		$this->load->language('product/category');

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$this->load->model('tool/image');

		if (isset($this->request->get['filter'])) {
			$filter = $this->request->get['filter'];
		} else {
			$filter = '';
		}



        if (isset($this->request->get['filter_manufacturer_id'])) {
            $filter_manufacturer_id = $this->request->get['filter_manufacturer_id'];
        }elseif(isset($this->request->get['manufacturer_id'])){
            $filter_manufacturer_id = $this->request->get['manufacturer_id'];
        } else {
            $filter_manufacturer_id = '';

        }


		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'p.price';
		}



        if (isset($this->request->get['attribute_id'])) {
            $attribute_id = $this->request->get['attribute_id'];
        } else {
            $attribute_id = '';
        }




		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		if (isset($this->request->get['limit'])) {
			$limit = (int)$this->request->get['limit'];
		} else {
			$limit = $this->config->get($this->config->get('config_theme') . '_product_limit');
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => 'Главная',
			'href' => $this->url->link('common/home')
		);

		if (isset($this->request->get['path'])) {
			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$path = '';

			$parts = explode('_', (string)$this->request->get['path']);
            $arr_of_ids = $this->cat_recursive($parts[0]);
            $arr_of_ids = array_reverse($arr_of_ids);
			$category_id = (int)array_pop($parts);
            array_pop($arr_of_ids);
			foreach ($arr_of_ids as $path_id) {
				if (!$path) {
					$path = (int)$path_id;
				} else {
					$path .= '_' . (int)$path_id;
				}

				$category_info = $this->model_catalog_category->getCategory($path_id);


				if ($category_info) {
					$data['breadcrumbs'][] = array(
						'text' => $category_info['name'],
						'href' => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $path . $url))
					);
				}
			}
		} else {
			$category_id = 0;
		}
        $category_info = $this->model_catalog_category->getCategory($category_id);






		if (isset($category_info)) {
			$this->document->setTitle($category_info['meta_title']);
			$this->document->setDescription($category_info['meta_description']);
			$this->document->setKeywords($category_info['meta_keyword']);

			$data['heading_title'] = $category_info['name'];

			$data['text_refine'] = $this->language->get('text_refine');
            $data['date_modified'] = ($category_info['date_modified']);
			$data['text_empty'] = $this->language->get('text_empty');
			$data['text_quantity'] = $this->language->get('text_quantity');
			$data['text_manufacturer'] = $this->language->get('text_manufacturer');
			$data['text_model'] = $this->language->get('text_model');
			$data['text_price'] = $this->language->get('text_price');
			$data['text_tax'] = $this->language->get('text_tax');
			$data['text_points'] = $this->language->get('text_points');
			$data['text_compare'] = sprintf($this->language->get('text_compare'), (isset($this->session->data['compare']) ? count($this->session->data['compare']) : 0));
			$data['text_sort'] = $this->language->get('text_sort');
			$data['text_limit'] = $this->language->get('text_limit');

			$data['button_cart'] = $this->language->get('button_cart');
			$data['button_wishlist'] = $this->language->get('button_wishlist');
			$data['button_compare'] = $this->language->get('button_compare');
			$data['button_continue'] = $this->language->get('button_continue');
			$data['button_list'] = $this->language->get('button_list');
			$data['button_grid'] = $this->language->get('button_grid');

			// Set the last category breadcrumb
			$data['breadcrumbs'][] = array(
				'text' => $category_info['name'],
				'href' => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path']))
			);

			if ($category_info['image']) {
				$data['thumb'] = $this->model_tool_image->resize($category_info['image'], $this->config->get($this->config->get('config_theme') . '_image_category_width'), $this->config->get($this->config->get('config_theme') . '_image_category_height'));
			} else {
				$data['thumb'] = '';
			}

			$data['description'] = html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8');

			$data['compare'] = $this->url->link('product/compare');

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['categories'] = array();

			$results = $this->model_catalog_category->getAllCategories();

            foreach ($results as $cat){
                $cats[$cat['parent_id']][$cat['category_id']] =  $cat;
            }
            //echo '<pre>';
           // print_r($category_id);
           // echo '</pre>';
           // die;
            $data['categories'] = $this->recursive($cats, $category_id,  '', $this->request->get['path']);


            $data['parent_categories'] = $this->recursive($cats, 0, '', '');

//echo '<pre>';
//print_r($data['categories']);
//echo '</pre>';
//die;
			$data['products'] = array();
			$data['manufacturers'] = array();
            $category_attributes_ids = $this->model_catalog_category->getCategoryAttributes($category_id);

            $category_attributes = [];
            foreach ($category_attributes_ids as $category_attributes_id){
                $category_attributes[] = $this->model_catalog_category->getAttribute($category_attributes_id);
            }
//echo '<pre>';
//print_r($category_attributes);
//echo '</pre>';
//die;
			$filter_data = array(
				'filter_category_id' => $category_id,
				'filter_manufacturer_id' => $filter_manufacturer_id,
				'filter_sub_category' => true,
				'filter_filter'      => $filter,
				'sort'               => $sort,
				'$attribute_id'      => $attribute_id,
				'order'              => $order,
				'start'              => ($page - 1) * $limit,
				'limit'              => $limit
			);


			$product_total = $this->model_catalog_product->getTotalProducts($filter_data);

			$results = $this->model_catalog_product->getProducts($filter_data);

            $check = [];
            $weight = $width = $length = $height = 0;
			foreach ($results as $result) {
                $weight += $result['weight'];
                $length += $result['length'];
                $width  += $result['width'];
                $height += $result['height'];

				if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_product_width'), $this->config->get($this->config->get('config_theme') . '_image_product_height'));
				}

				if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
					$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$price = false;
				}


				if ((float)$result['special']) {
					$special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
				} else {
					$special = false;
				}

				if ($this->config->get('config_tax')) {
					$tax = $this->currency->format((float)$result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
				} else {
					$tax = false;
				}

				if ($this->config->get('config_review_status')) {
					$rating = (int)$result['rating'];
				} else {
					$rating = false;
				}


				if($result['manufacturer_id'] != '' && !in_array($result['manufacturer_id'], $check)){
				    $check[] = $result['manufacturer_id'];
                    $data['manufacturers'][] = [
                        'text' => $result['manufacturer'],
                        'value' => 'p.sort_manufacturer-DESC',
                        'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category/manufacturer', 'path=' . $this->request->get['path'] . '_' . $result['manufacturer_id']))
                    ];
                }
                $attribute_groups= $this->model_catalog_product->getProductAttributes($result['product_id']);
                foreach ($attribute_groups as $attribute_group){
                    if($attribute_group['name'] == 'Технические'){
                        $data['technical_attributes'] = $attribute_group;
                    }elseif ($attribute_group['name']  == 'Описательные'){
                        $data['common_attributes'] = $attribute_group;
                    }
                }

                if(isset($data['common_attributes'])){
                    foreach ($data['common_attributes']['attribute'] as $attribute){
                        if($attribute['name'] == 'Ед. изм.')
                            $data['unit'] = $attribute['text'];
                    }
                }




                foreach ($category_attributes as $key => $category_attribute){
                    $product_attr = $this->model_catalog_category->getAttributeValue($result['product_id'], $category_attribute['attribute_id']);
                    if(isset($product_attr['text'])){
                        $category_attributes[$key]['value'] = $product_attr['text'];
                    }else{
                        $category_attributes[$key]['value'] = '';
                    }

                }



				$data['products'][] = array(
					'product_id'  => $result['product_id'],
					'thumb'       => $image,
					'name'        => $result['name'],
					'manufacturer'  => $result['manufacturer'],
					'weight'        => $result['weight'],
					'length'        => $result['length'],
					'width'         => $result['width'],
					'height'         => $result['height'],
					'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
					'price'       => $price,
					'special'     => $special,
					'tax'         => $tax,
					'minimum'     => $result['minimum'] > 0 ? $result['minimum'] : 1,
					'rating'      => $result['rating'],
					'attribute'   => $category_attributes,
					'href'        => str_replace(HTTP_SERVER,'goods/' . $result['sku'] . '/', $this->url->link('product/product',  '&product_id=' . $result['product_id'] . $url))
				);
			}


			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['sorts'] = array();

            $data['sorts'][] = array(
                'text'  => $this->language->get('text_default'),
                'value' => 'p.sort_order-ASC',
                'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC' . $url))
            );

//			if(count($category_attributes) > 0){
//			    foreach ($category_attributes as $attribute){
//			        if($attribute['name'] != 'Ед. изм.' && $attribute['name'] != '**'){
//                        $data['sorts'][] = array(
//                            'text'  => $attribute['name'] . " по возрастанию",
//                            'value' => 'attribute-ASC',
//                            'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=attribute&attribute_id='. $attribute['attribute_id'].'&order=ASC' . $url))
//                        );
//
//                        $data['sorts'][] = array(
//                            'text'  => $attribute['name'] . " по убыванию",
//                            'value' => 'attribute-DESC',
//                            'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=attribute&attribute_id='. $attribute['attribute_id'].'&order=DESC' . $url))
//                        );
//                    }
//                }
//            }




            if($weight > 0){
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_weight_asc'),
                    'value' => 'p.weight-ASC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.weight&order=ASC' . $url))
                );
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_weight_desc'),
                    'value' => 'p.weight-DESC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.weight&order=DESC' . $url))
                );
            }

            if($length > 0){
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_length_asc'),
                    'value' => 'p.length-ASC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.length&order=ASC' . $url))
                );
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_length_desc'),
                    'value' => 'p.length-DESC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.length&order=DESC' . $url))
                );
            }

            if($width > 0){
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_width_asc'),
                    'value' => 'p.width-ASC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.width&order=ASC' . $url))
                );
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_width_desc'),
                    'value' => 'p.width-DESC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.width&order=DESC' . $url))
                );
            }

            if($height > 0){
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_height_asc'),
                    'value' => 'p.height-ASC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.height&order=ASC' . $url))
                );
                $data['sorts'][] = array(
                    'text'  => $this->language->get('text_height_desc'),
                    'value' => 'p.height-DESC',
                    'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.height&order=DESC' . $url))
                );
            }








			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_asc'),
				'value' => 'p.price-ASC',
				'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=ASC' . $url))
			);

			$data['sorts'][] = array(
				'text'  => $this->language->get('text_price_desc'),
				'value' => 'p.price-DESC',
				'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url))
			);



            $data['manufacturers'][] = array(
                'text' => 'Все',
                'value' => 'p.sort_order-ASC',
                'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.price&order=DESC' . $url)));

//			if ($this->config->get('config_review_status')) {
//				$data['sorts'][] = array(
//					'text'  => $this->language->get('text_rating_desc'),
//					'value' => 'rating-DESC',
//					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=DESC' . $url)
//				);
//
//				$data['sorts'][] = array(
//					'text'  => $this->language->get('text_rating_asc'),
//					'value' => 'rating-ASC',
//					'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=rating&order=ASC' . $url)
//				);
//			}
//
//			$data['sorts'][] = array(
//				'text'  => $this->language->get('text_model_asc'),
//				'value' => 'p.model-ASC',
//				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=ASC' . $url)
//			);
//
//			$data['sorts'][] = array(
//				'text'  => $this->language->get('text_model_desc'),
//				'value' => 'p.model-DESC',
//				'href'  => $this->url->link('product/category', 'path=' . $this->request->get['path'] . '&sort=p.model&order=DESC' . $url)
//			);

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$data['limits'] = array();

			$limits = array_unique(array($this->config->get($this->config->get('config_theme') . '_product_limit'), 25, 50, 75, 100));

			sort($limits);

			foreach($limits as $value) {
				$data['limits'][] = array(
					'text'  => $value,
					'value' => $value,
					'href'  => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&limit=' . $value))
				);
			}

			$url = '';

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$pagination = new Pagination();
			$pagination->total = $product_total;
			$pagination->page = $page;
			$pagination->limit = $limit;
			$pagination->url = str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $this->request->get['path'] . $url . '&page={page}'));

            $data['pagination'] = $pagination->render(1);

			$data['results'] = sprintf($this->language->get('text_pagination'), ($product_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($product_total - $limit)) ? $product_total : ((($page - 1) * $limit) + $limit), $product_total, ceil($product_total / $limit));

			// http://googlewebmastercentral.blogspot.com/2011/09/pagination-with-relnext-and-relprev.html
			if ($page == 1) {
			    $this->document->addLink(str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $category_info['category_id'], true)), 'canonical');
			} elseif ($page == 2) {
			    $this->document->addLink(str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $category_info['category_id'], true)), 'prev');
			} else {
			    $this->document->addLink(str_replace(HTTP_SERVER,'catalog/',$this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page - 1), true)), 'prev');
			}

			if ($limit && ceil($product_total / $limit) > $page) {
			    $this->document->addLink(str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $category_info['category_id'] . '&page='. ($page + 1), true)), 'next');
			}


            if (isset($this->request->get['filter_manufacturer_id'])) {
                $sort = 'p.sort_manufacturer';
                $order = 'DESC';
            }
			$data['sort'] = $sort;
			$data['order'] = $order;
			$data['limit'] = $limit;

			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
            $data['search'] = $this->load->controller('common/search');
			$data['header'] = $this->load->controller('common/header');
            $data['catalog'] = $this->url->link('product/catalog', '', true);
            if(isset($_SERVER["HTTP_REFERER"])){
                $data['back'] = $_SERVER["HTTP_REFERER"];
            }else{
                $data['back'] = $this->url->link('common/home');
            }

            $this->load->model('setting/setting');
            $current_language_id = $this->config->get('config_language_id');
            $data['loadmore_button'] = $this->config->get('loadmore_button_name_'.$current_language_id);
            $data['loadmore_status'] = $this->config->get('loadmore_status');
            $data['loadmore_style'] = $this->config->get('loadmore_style');
            $data['loadmore_arrow_status'] = $this->config->get('loadmore_arrow_status');

			$this->response->setOutput($this->load->view('product/category', $data));

		} else {
			$url = '';

			if (isset($this->request->get['path'])) {
				$url .= '&path=' . $this->request->get['path'];
			}

			if (isset($this->request->get['filter'])) {
				$url .= '&filter=' . $this->request->get['filter'];
			}

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			if (isset($this->request->get['limit'])) {
				$url .= '&limit=' . $this->request->get['limit'];
			}

			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', $url))
			);

			$this->document->setTitle($this->language->get('text_error'));

			$data['heading_title'] = $this->language->get('text_error');

			$data['text_error'] = $this->language->get('text_error');

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header', array('headerss'=>'false'));
			$data['search'] = $this->load->controller('common/search');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function recursive($cats, $parent_id,  $path = '', $path_id){

        $tree = [];
        if(is_array($cats) and isset($cats[$parent_id])){

                foreach($cats[$parent_id] as $key => $cat){

                    $tree[$key]['category_id'] = $cat['category_id'];
                    $tree[$key]['name'] = $cat['name'];

                    if($parent_id == 0){
                        $tree[$key]['href'] =  str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $cat['category_id'] ));
                        $tree[$key]['path_id'] = $cat['category_id'];
                    }else{
                        $tree[$key]['href'] = str_replace(HTTP_SERVER,'catalog/', $this->url->link('product/category', 'path=' . $cat['category_id'] ));
                        $tree[$key]['path_id'] = $path_id . '_'. $cat['category_id'];
                    }
                    if($this->recursive($cats, $cat['category_id'], $tree[$key]['href'], $tree[$key]['path_id'] )){
                        $tree[$key]['sub_categories'] = $this->recursive($cats, $cat['category_id'],  $tree[$key]['href'], $tree[$key]['path_id']);
                    }
                }
            }
            return $tree;
    }


    private function cat_recursive($id){

        $this->load->model('catalog/category');
        $this->arr[] = $id;
        $cat_info = $this->model_catalog_category->getCategory($id);
        if((int)$cat_info['parent_id'] != 0){
            $this->cat_recursive($cat_info['parent_id']);
        }
        return $this->arr;
    }

}
