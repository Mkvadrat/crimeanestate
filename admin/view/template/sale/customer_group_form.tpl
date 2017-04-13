<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/customer.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <h2><?php echo $text_group; ?></h2>
        <table class="form">
          <tr>
            <td style="width: 250px;"><span class="required">*</span> <?php echo $entry_name; ?></td>
            <td><?php foreach ($languages as $language) { ?>
              <input type="text" name="customer_group_description[<?php echo $language['language_id']; ?>][name]" value="<?php echo isset($customer_group_description[$language['language_id']]) ? $customer_group_description[$language['language_id']]['name'] : ''; ?>" />
              <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /><br />
              <?php if (isset($error_name[$language['language_id']])) { ?>
              <span class="error"><?php echo $error_name[$language['language_id']]; ?></span><br />
              <?php } ?>
              <?php } ?></td>
          </tr>
          <?php foreach ($languages as $language) { ?>
          <tr>
            <td><?php echo $entry_description; ?></td>
            <td><textarea name="customer_group_description[<?php echo $language['language_id']; ?>][description]" cols="40" rows="5"><?php echo isset($customer_group_description[$language['language_id']]) ? $customer_group_description[$language['language_id']]['description'] : ''; ?></textarea>
              <img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" align="top" /></td>
          </tr>
          <?php } ?>
		</table>
		<h2><?php echo $text_basic_data; ?></h2>
        <table class="form">
          <tr>
            <td style="width: 250px;"><?php echo $entry_approval; ?></td>
            <td width="250"><?php if ($approval) { ?>
              <input type="radio" name="approval" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="approval" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="approval" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="approval" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_approval; ?></td>
          </tr>
		  <tr>
            <td><?php echo $entry_telephone_display; ?></td>
            <td><?php if ($telephone_display) { ?>
              <input type="radio" name="telephone_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="telephone_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="telephone_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="telephone_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_telephone_display; ?></td>
          </tr>
		  <tr>
            <td><?php echo $entry_fax_display; ?></td>
            <td><?php if ($fax_display) { ?>
              <input type="radio" name="fax_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="fax_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="fax_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="fax_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_fax_display; ?></td>
          </tr>
		</table>
		<h2><?php echo $text_address_display; ?></h2>
        <table class="form">
		  <tr>
            <td style="width: 250px;"><?php echo $entry_address_display; ?></td>
            <td width="250"><?php if ($address_display) { ?>
              <input type="radio" name="address_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="address_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="address_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="address_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_address_display; ?></td>
          </tr>
		  <tr>
            <td><?php echo $entry_company_display; ?></td>
            <td><?php if ($company_display) { ?>
              <input type="radio" name="company_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="company_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="company_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="company_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_company_display; ?></td>
          </tr>
		  <tr>
            <td><?php echo $entry_address_2_display; ?></td>
            <td><?php if ($address_2_display) { ?>
              <input type="radio" name="address_2_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="address_2_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="address_2_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="address_2_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_address_2_display; ?></td>
          </tr>
		</table>
		<h2><?php echo $text_additional; ?></h2>
        <table class="form">
		  <tr>
            <td style="width: 250px;"><?php echo $entry_additional_display; ?></td>
            <td width="250"><?php if ($additional_display) { ?>
              <input type="radio" name="additional_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="additional_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="additional_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="additional_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_additional_display; ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_company_id_display; ?></td>
            <td><?php if ($company_id_display) { ?>
              <input type="radio" name="company_id_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="company_id_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="company_id_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="company_id_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_company_id_display; ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_company_id_required; ?></td>
            <td><?php if ($company_id_required) { ?>
              <input type="radio" name="company_id_required" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="company_id_required" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="company_id_required" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="company_id_required" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_company_id_required; ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_tax_id_display; ?></td>
            <td><?php if ($tax_id_display) { ?>
              <input type="radio" name="tax_id_display" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="tax_id_display" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="tax_id_display" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="tax_id_display" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_tax_id_display; ?></td>
          </tr>
          <tr>
            <td><?php echo $entry_tax_id_required; ?></td>
            <td><?php if ($tax_id_required) { ?>
              <input type="radio" name="tax_id_required" value="1" checked="checked" />
              <?php echo $text_yes; ?>
              <input type="radio" name="tax_id_required" value="0" />
              <?php echo $text_no; ?>
              <?php } else { ?>
              <input type="radio" name="tax_id_required" value="1" />
              <?php echo $text_yes; ?>
              <input type="radio" name="tax_id_required" value="0" checked="checked" />
              <?php echo $text_no; ?>
              <?php } ?></td>
			<td><?php echo $info_tax_id_required; ?></td>
          </tr>
		</table>
		<h2><?php echo $text_sort; ?></h2>
        <table class="form">
          <tr>
            <td style="width: 250px;"><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="sort_order" value="<?php echo $sort_order; ?>" size="1" /></td>
          </tr>
		</table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>