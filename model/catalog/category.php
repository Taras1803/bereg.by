<?php
class ModelCatalogCategory extends Model {

	public function getCategory($category_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.category_id = '" . (int)$category_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");

		return $query->row;
	}

    public function getCategoryAttributes($category_id){
        $query = $this->db->query("SELECT attribute_id FROM " . DB_PREFIX . "category_to_attribute WHERE category_id = '" . (int)$category_id . "'");
        $result = [];
        if($query->rows) {
            foreach ($query->rows as $item) {
                $result[] = $item['attribute_id'];
            }
        }
        return $result;
    }
    public function getAttribute($atttibute_id){

        $attribute_name = $this->db->query("SELECT attribute_id, name FROM " . DB_PREFIX . "attribute_description  WHERE attribute_id = '" . (int)$atttibute_id .  "'");
        return $attribute_name->row;

    }

	public function getCategoriesLive($search) {
		$category_data = array();
		$sql = "SELECT * FROM " . DB_PREFIX . "category c
			LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id)
			LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE
			cd.name LIKE '%" . $search . "%' 
			AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "'
			AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
			AND c.status = '1' GROUP BY cd.name  ORDER BY c.sort_order, LCASE(cd.name) LIMIT 6";
		$query = $this->db->query($sql);
		foreach ($query->rows as $result) {
			$category_data[$result['category_id']] = $this->getCategory($result['category_id']);
		}
		return $category_data;
	}
	
	
	public function getCategories($parent_id = 0, $limit = 100) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name) LIMIT $limit");

		return $query->rows;
	}

    public function getAllCategories() {

        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

        return $query->rows;
    }

    public function getAllCategoriesManufacturers($products_ids) {


        $implode = [];
        foreach ($products_ids as $id) {
            $implode[] = "ptc.product_id='" . (int)$id. "'";
        }

        $sql = "SELECT c.category_id, cd.name, ptc.category_id FROM " . DB_PREFIX . "category c 
                LEFT JOIN " . DB_PREFIX . "category_description cd 
                ON (c.category_id = cd.category_id) 
                LEFT JOIN " . DB_PREFIX . "category_to_store c2s 
                ON (c.category_id = c2s.category_id)
                LEFT JOIN " . DB_PREFIX . "product_to_category ptc 
                ON (c.category_id = ptc.category_id)  
                WHERE cd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
                AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  
                AND c.status = '1' AND " . implode(' OR ', $implode) . "
                GROUP BY ptc.category_id
                ORDER BY c.sort_order, LCASE(cd.name)";

        $query = $this->db->query($sql);
        return $query->rows;
    }




	public function getCategoryFilters($category_id) {
		$implode = array();

		$query = $this->db->query("SELECT filter_id FROM " . DB_PREFIX . "category_filter WHERE category_id = '" . (int)$category_id . "'");

		foreach ($query->rows as $result) {
			$implode[] = (int)$result['filter_id'];
		}

		$filter_group_data = array();

		if ($implode) {
			$filter_group_query = $this->db->query("SELECT DISTINCT f.filter_group_id, fgd.name, fg.sort_order FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_group fg ON (f.filter_group_id = fg.filter_group_id) LEFT JOIN " . DB_PREFIX . "filter_group_description fgd ON (fg.filter_group_id = fgd.filter_group_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND fgd.language_id = '" . (int)$this->config->get('config_language_id') . "' GROUP BY f.filter_group_id ORDER BY fg.sort_order, LCASE(fgd.name)");

			foreach ($filter_group_query->rows as $filter_group) {
				$filter_data = array();

				$filter_query = $this->db->query("SELECT DISTINCT f.filter_id, fd.name FROM " . DB_PREFIX . "filter f LEFT JOIN " . DB_PREFIX . "filter_description fd ON (f.filter_id = fd.filter_id) WHERE f.filter_id IN (" . implode(',', $implode) . ") AND f.filter_group_id = '" . (int)$filter_group['filter_group_id'] . "' AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY f.sort_order, LCASE(fd.name)");

				foreach ($filter_query->rows as $filter) {
					$filter_data[] = array(
						'filter_id' => $filter['filter_id'],
						'name'      => $filter['name']
					);
				}

				if ($filter_data) {
					$filter_group_data[] = array(
						'filter_group_id' => $filter_group['filter_group_id'],
						'name'            => $filter_group['name'],
						'filter'          => $filter_data
					);
				}
			}
		}

		return $filter_group_data;
	}

	public function getCategoryLayoutId($category_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category_to_layout WHERE category_id = '" . (int)$category_id . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");

		if ($query->num_rows) {
			return $query->row['layout_id'];
		} else {
			return 0;
		}
	}

	public function getTotalCategoriesByCategoryId($parent_id = 0) {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'");

		return $query->row['total'];
	}
	public function getCategoryId($product_id)
    {
        $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "product_to_category  WHERE product_id = '" . (int)$product_id . "'");
        return $query->row['category_id'];
    }


    public function getAttributeValue($product_id, $attribute_id){
        $query = $this->db->query("SELECT *  FROM " . DB_PREFIX . "product_attribute  WHERE product_id = '" . (int)$product_id . "' AND attribute_id = '" . (int)$attribute_id . "'");
        return $query->row;
    }

}