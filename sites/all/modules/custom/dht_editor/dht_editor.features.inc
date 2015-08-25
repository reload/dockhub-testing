<?php
/**
 * @file
 * dht_editor.features.inc
 */

/**
 * Implements hook_ctools_plugin_api().
 */
function dht_editor_ctools_plugin_api($module = NULL, $api = NULL) {
  if ($module == "strongarm" && $api == "strongarm") {
    return array("version" => "1");
  }
}
