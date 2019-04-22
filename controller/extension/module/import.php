<?php

class ControllerExtensionModuleImport extends Controller
{

    public function elasticGenerateCache()

    {
        $url = HTTP_SERVER_ELASTIC . '_all';
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
        $result = curl_exec($ch);
        curl_close($ch);
        print_r($result);

        $url_sitemap = $this->load->controller('extension/feed/google_sitemap');
        require_once('simple_html_dom.php');
        $content_product = file_get_contents($url_sitemap);
        $site_map_xml = new SimpleXMLElement($content_product);
        foreach ($site_map_xml->url as $loc) {
            $loc_tags[] = $loc;
        }

        foreach ($loc_tags as $xml_file) {
            if (is_int(strpos($xml_file->loc, 'category'))) {
                    $content_each_xml_file = file_get_html($xml_file->loc);
                if (!is_object($content_each_xml_file)) {
                    file_put_contents('test_log.txt',$xml_file->loc . "\n");
                } else {
                    $h1 = $content_each_xml_file->find('h1[id=xml_search_category_name]', 0)->plaintext;
                    if (!empty($h1)) {
                        $params = [
                            'title' => (string)$h1,
                            'id' => '0',
                            'href' => (string)$xml_file->loc,
                            'tag' => "category",
                        ];
                        $data_string = json_encode($params);

                        $ch = curl_init();
                        curl_setopt($ch, CURLOPT_URL, HTTP_SERVER_ELASTIC . "elastic/feed");
                        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
                        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);


                        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                        $response = curl_exec($ch);
                        curl_close($ch);

                        if (empty($response)) {
                            echo 'fail generate cache' . PHP_EOL;
                            die;
                        } else {
                            print_r($response);
                        }

                    }
                }
            } else if (is_int(strpos($xml_file->loc, 'product_id')) && (strpos($xml_file->loc, 'path') === FALSE)) {
                $content_each_xml_file = file_get_html($xml_file->loc);

                if (!is_object($content_each_xml_file)) {
                    file_put_contents('test_log.txt',$xml_file->loc . "\n");
                } else {

                    try{
                        $h1 = $content_each_xml_file->find('h1[id=xml_search_product_name]', 0)->plaintext;
                        $id = $content_each_xml_file->find('div[id=xml_search_product_id]', 0)->plaintext;
                        //Если fopen возвращает логическое значение FALSE, то возникает ошибка.
                        if($h1 === false || $id === false){
                            throw new Exception('Невозможно открыть');
                        }
                    }
                    catch (Exception $ex) {
                        file_put_contents('test_log.txt',$xml_file->loc . "\n");
                    }


                    if (!empty($h1)) {
                        $params = [
                            'title' => (string)$h1,
                            'id' => (string)$id,
                            'href' => (string)$xml_file->loc,
                            'tag' => "product",
                        ];
                        $data_string = json_encode($params);

                        $ch = curl_init();
                        curl_setopt($ch, CURLOPT_URL, HTTP_SERVER_ELASTIC . "elastic/feed");
                        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
                        curl_setopt($ch, CURLOPT_HTTPHEADER, array('Content-Type:application/json'));
                        curl_setopt($ch, CURLOPT_POSTFIELDS, $data_string);


                        curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                        $response = curl_exec($ch);
                        curl_close($ch);


                        if (empty($response)) {
                            echo 'fail generate cache' . PHP_EOL;
                            die;
                        } else {
                            print_r($response);
                        }
                    }
                }

            }

        }
    }

    public function test()
    {
        require_once('simple_html_dom.php');
        $content_product = file_get_contents("http://bereg.intent-solutions.com/custom_sitemap_chpu.xml");
        $site_map_xml = new SimpleXMLElement($content_product);
        foreach ($site_map_xml->url as $loc) {
            $loc_tags[] = $loc;
        }

        foreach ($loc_tags as $xml_file) {

            if (is_int(strpos($xml_file->loc, 'category'))) {

                $content_each_xml_file = file_get_html("http://bereg.intent-solutions.com/index.php?route=product/category&path=10232_102708_109112");
                if (!is_object($content_each_xml_file)) {
                    file_put_contents('test_log.txt',$xml_file->loc . "\n");
                } else {

                    $h1 = $content_each_xml_file->find('h1[id=xml_search_category_name]', 0)->plaintext;
                    if (!empty($h1)) {
                        $params = [
                            'title' => (string)$h1,
                            'id' => '0',
                            'href' => (string)$xml_file->loc,
                            'tag' => "category",
                        ];
                        $data_string = json_encode($params);
                        var_dump($params);
                        die();
                    }
                }
            }
        }
    }

    public function createCsv(){
        $this->load->model('catalog/product');
        $results = $this->model_catalog_product->getProducts();
        $array_of_products_name = [];
        foreach ($results as $item){
            $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "url_alias WHERE `query` = 'product_id=" . (int)$item['product_id'] . "'");
            if ($query->num_rows && isset($query->row['keyword']) ) {
                $chpu = $query->row['keyword'];
            }else{
                $chpu = $this->str2url($item['name']);
            }
            $array_of_products_name[] =[
              'name' =>  $item['name'],
              'url' =>  "goods/" . $item['sku'] ."/" . $chpu,
            ];
        }

        array_unshift($array_of_products_name, array('Название товара', 'Ссылка на товар'));
       echo '<pre>';
       print_r( $this->generateCsv($array_of_products_name));
       echo '</pre>';
       die;

    }

    public  function generateCsv($data, $delimiter = ';', $enclosure = '"') {
        $handle = fopen(DIR_SITEMAP . 'products_url.csv', 'r+');
        foreach ($data as $line) {
            fputcsv($handle, $line, $delimiter, $enclosure);
        }
        rewind($handle);
        $contents = '';
        while (!feof($handle)) {
            $contents .= fread($handle, 8192);
        }
        fclose($handle);
        return $contents;
    }

    public function rus2translit($string)
    {
        $converter = array(
            'а' => 'a', 'б' => 'b', 'в' => 'v',
            'г' => 'g', 'д' => 'd', 'е' => 'e',
            'ё' => 'e', 'ж' => 'zh', 'з' => 'z',
            'и' => 'i', 'й' => 'y', 'к' => 'k',
            'л' => 'l', 'м' => 'm', 'н' => 'n',
            'о' => 'o', 'п' => 'p', 'р' => 'r',
            'с' => 's', 'т' => 't', 'у' => 'u',
            'ф' => 'f', 'х' => 'h', 'ц' => 'c',
            'ч' => 'ch', 'ш' => 'sh', 'щ' => 'sch',
            'ь' => '', 'ы' => 'y', 'ъ' => '',
            'э' => 'e', 'ю' => 'yu', 'я' => 'ya',

            'А' => 'A', 'Б' => 'B', 'В' => 'V',
            'Г' => 'G', 'Д' => 'D', 'Е' => 'E',
            'Ё' => 'E', 'Ж' => 'Zh', 'З' => 'Z',
            'И' => 'I', 'Й' => 'Y', 'К' => 'K',
            'Л' => 'L', 'М' => 'M', 'Н' => 'N',
            'О' => 'O', 'П' => 'P', 'Р' => 'R',
            'С' => 'S', 'Т' => 'T', 'У' => 'U',
            'Ф' => 'F', 'Х' => 'H', 'Ц' => 'C',
            'Ч' => 'Ch', 'Ш' => 'Sh', 'Щ' => 'Sch',
            'Ь' => '', 'Ы' => 'Y', 'Ъ' => '',
            'Э' => 'E', 'Ю' => 'Yu', 'Я' => 'Ya',
        );
        return strtr($string, $converter);
    }

    public function str2url($str)
    {
        // переводим в транслит
        $str = $this->rus2translit($str);
        // в нижний регистр
        $str = strtolower($str);
        // заменям все ненужное нам на "-"
        $str = preg_replace('~[^-a-z0-9_]+~u', '-', $str);
        // удаляем начальные и конечные '-'
        $str = trim($str, "-");
        return $str;
    }


}




















