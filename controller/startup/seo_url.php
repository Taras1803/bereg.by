<?php // ==========================================  seo_url.php v.030717 opencart-russia.ru ===============================
class ControllerStartupSeoUrl extends Controller {

    private $arr = [];
	public function index() {




		// Add rewrite to url class
		if ($this->config->get('config_seo_url')) {
			$this->url->addRewrite($this);
		}
//echo '<pre>';
//print_r($this->request->get);
//echo '</pre>';
//die;
		// Decode URL
		if (isset($this->request->get['_route_'])) {


            $custom_route = str_replace('.html','', $this->request->get['_route_']);
            $parts = explode('/', $custom_route);



            if (utf8_strlen(end($parts)) == 0) {
                array_pop($parts);
            }

            if(trim($parts[0]) == 'cat'){
               $arr_of_ids = $this->recursive($parts[1]);
                $custom_parts_cpu = [];
               foreach ($arr_of_ids as $arr_id){
                   $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'category_id=" . $this->db->escape($arr_id) . "'");
                   if(isset($query->row['keyword'])){
                       $custom_parts_cpu[] = $query->row['keyword'];
                   }
               }
                $parts = array_reverse($custom_parts_cpu);
                $str = implode('/',$parts);
                $this->response->redirect(HTTP_SERVER .$str, 301);
           }elseif (trim($parts[0]) == 'news' && count($parts) > 1){
                unset($parts[0]);
                $this->response->redirect(HTTP_SERVER . $parts[1], 301);
            }elseif(trim($parts[0]) == 'articles' && count($parts) > 1){
                $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = 'article_id=" . (int)$parts[1] . "'");
                if(isset($query->row['keyword'])){
                    $parts = [];
                    $parts[] = $query->row['keyword'];
                    $this->response->redirect(HTTP_SERVER . $parts[0], 301);
                }
            }
            if ($parts[0] == 'catalog'  || $parts[0] == 'manufacturers') {
                unset($parts[0]);
            }elseif($parts[0] == 'goods'){
                unset($parts[0]);
                unset($parts[1]);
            }

			foreach ($parts as $part) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE keyword = '" . $this->db->escape($part) . "'");

				if ($query->num_rows) {
					$url = explode('=', $query->row['query']);

					if ($url[0] == 'product_id') {
						$this->request->get['product_id'] = $url[1];
					}

					if ($url[0] == 'category_id') {
						if (!isset($this->request->get['path'])) {
							$this->request->get['path'] = $url[1];
						} else {
							$this->request->get['path'] .= '_' . $url[1];
						}
					}

					if ($url[0] == 'manufacturer_id') {
						$this->request->get['manufacturer_id'] = $url[1];
					}

					if ($url[0] == 'information_id') {
						$this->request->get['information_id'] = $url[1];
					}
                    if ($url[0] == 'news_id') {
                        $this->request->get['news_id'] = $url[1];
                    }
                    if ($url[0] == 'article_id') {

                        $this->request->get['article_id'] = $url[1];

                    }

					if ($query->row['query'] && $url[0] != 'information_id'
                        && $url[0] != 'news_id' && $url[0] != 'article_id'
                        && $url[0] != 'manufacturer_id' && $url[0] != 'category_id'
                        && $url[0] != 'product_id') {
					    $this->request->get['route'] = $query->row['query'];
					}
				} else {
					$this->request->get['route'] = 'error/not_found';

					break;
				}
			}

			if (!isset($this->request->get['route'])) {
				if (isset($this->request->get['product_id'])) {
					$this->request->get['route'] = 'product/product';
				} elseif (isset($this->request->get['path'])) {
					$this->request->get['route'] = 'product/category';
				} elseif (isset($this->request->get['manufacturer_id'])) {
					$this->request->get['route'] = 'product/manufacturer/info';
				} elseif (isset($this->request->get['information_id'])) {
					$this->request->get['route'] = 'information/information';
				} elseif (isset($this->request->get['news_id'])) {
                $this->request->get['route'] = 'news/news_single';
				}elseif (isset($this->request->get['article_id'])) {
                    $this->request->get['route'] = 'blog/article';
                }elseif (isset($this->request->get['filter_manufacturer_id'])) {
                    $this->request->get['route'] = 'blog/article';
                }
			}

			if (isset($this->request->get['route'])) {

				return new Action($this->request->get['route']);
			}
			
		  // Redirect 301	
		} elseif (isset($this->request->get['route']) && empty($this->request->post) && !isset($this->request->get['token']) && $this->config->get('config_seo_url')) {
			$arg = '';
			$cat_path = false;

			if ($this->request->get['route'] == 'product/product' && isset($this->request->get['product_id'])) {
				$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'product_id=" . (int)$this->request->get['product_id'] . "'");	
				if ($query->num_rows && $query->row['keyword'] /**/ ) {
					$this->request->get['route'] = 'product_id=' . $this->request->get['product_id'];
				}
			} elseif ($this->request->get['route'] == 'product/category' && isset($this->request->get['path'])) {
				$categorys_id = explode('_', $this->request->get['path']);
				$cat_path = '';
				foreach ($categorys_id as $category_id) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category_id . "'");	
					if ($query->num_rows && $query->row['keyword'] /**/ ) {
						$cat_path .= '/' . $query->row['keyword'];
					} else {
						$cat_path = false;
						break;
					}
				}
				$arg = trim($cat_path, '/');
				if (isset($this->request->get['page'])) $arg = $arg . '?page=' . (int)$this->request->get['page'];
			} elseif ($this->request->get['route'] == 'product/manufacturer/info' && isset($this->request->get['manufacturer_id'])) {
				$this->request->get['route'] = 'manufacturer_id=' . $this->request->get['manufacturer_id'];
				if (isset($this->request->get['page'])) $arg = $arg . '?page=' . (int)$this->request->get['page'];
			} elseif ($this->request->get['route'] == 'information/information' && isset($this->request->get['information_id'])) {
				$this->request->get['route'] = 'information_id=' . $this->request->get['information_id'];
			}

			elseif (sizeof($this->request->get) > 1) {
				$args = '?' . str_replace("route=" . $this->request->get['route'].'&amp;', "", $this->request->server['QUERY_STRING']);
				$arg = str_replace('&amp;', '&', $args);
			}

			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE query = '" . $this->db->escape($this->request->get['route']) . "'");

			if ($query->num_rows && $query->row['keyword']) /**/ {
				$this->response->redirect($query->row['keyword'] . $arg, 301);
			} elseif ($cat_path) {
				$this->response->redirect($arg, 301);
			} elseif ($this->request->get['route'] == 'common/home') {
				$this->response->redirect(HTTP_SERVER . $arg, 301);
			}
		}
	}

	public function rewrite($link) {


		$url_info = parse_url(str_replace('&amp;', '&', $link));

		$url = '';

		$data = array();

		parse_str($url_info['query'], $data);
//      echo "<pre>";
//      print_r($data);
//      echo "</pre>";
//      die;
      
		foreach ($data as $key => $value) {
			if (isset($data['route'])) {
				if (($data['route'] == 'product/product' && $key == 'product_id') || (($data['route'] == 'product/manufacturer/info' || $data['route'] == 'product/product') && $key == 'manufacturer_id') || ($data['route'] == 'information/information' && $key == 'information_id') || ($data['route'] == 'blog/article' && $key == 'article_id') || ($data['route'] == 'news/news_single' && $key == 'news_id')) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($key . '=' . (int)$value) . "'");

					if ($query->num_rows && $query->row['keyword']) {
						$url .= '/' . $query->row['keyword'];

						unset($data[$key]);
					}
				} elseif ($key == 'path') {
					$categories = explode('_', $value);
                    if($data['route'] == 'product/category/manufacturer'){
                        $manufacturer = array_pop($categories);

                    }

                    
					foreach ($categories as $category) {

						$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'category_id=" . (int)$category . "'");

						if ($query->num_rows && $query->row['keyword']) {
							$url .= '/' . $query->row['keyword'];
						} else {
							$url = '';

							break;
						}
					}
                    if($data['route'] == 'product/category/manufacturer' && isset($manufacturer)){
                        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'manufacturer_id=" . (int)$manufacturer . "'");

                        if ($query->num_rows && $query->row['keyword']) {
                            $url .= '/' . $query->row['keyword'];
                        } else {
                            $url .= '';
                        }
                    }
					unset($data[$key]);
				} elseif ($key == 'route') {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = '" . $this->db->escape($data['route']) . "'");
					if ($query->num_rows) /**/ {
						$url .= '/' . $query->row['keyword'];
					}
				}
			}
		}

		if ($url) {

			unset($data['route']);

			$query = '';

			if ($data) {
				foreach ($data as $key => $value) {
					$query .= '&' . rawurlencode((string)$key) . '=' . rawurlencode((is_array($value) ? http_build_query($value) : (string)$value));
				}

				if ($query) {
					$query = '?' . str_replace('&', '&amp;', trim($query, '&'));
				}
			}

			return $url_info['scheme'] . '://' . $url_info['host'] . (isset($url_info['port']) ? ':' . $url_info['port'] : '') . str_replace('/index.php', '', $url_info['path']) . $url . $query;
		} else {

			return $link;
		}
	}

	private function recursive($id){

        $this->load->model('catalog/category');
        $this->arr[] = $id;
        $cat_info = $this->model_catalog_category->getCategory($id);
        if((int)$cat_info['parent_id'] != 0){
            $this->recursive($cat_info['parent_id']);
        }
        return $this->arr;
    }

}