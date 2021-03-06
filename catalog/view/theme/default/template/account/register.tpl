<?php echo $header; ?>

<?php //echo $column_left; ?><?php //echo $column_right; ?>
<?php echo $content_top; ?>
<div class="content">
<div class="conteiner article-container">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <?php if ($error_warning) { ?>
  <div class="warning error-message"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="border">
  <p><?php echo $text_account_already; ?></p>
  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
    <table class="group">
	  <tr style="display: <?php echo (count($customer_groups) > 1 ? 'table-row' : 'none'); ?>;">
	    <td>
	      <h2><?php echo $text_customer_groups; ?></h2>
          <div class="content">
			<p><?php echo $text_note_groups; ?></p>
			<table class="form"> 
			  <tr>
                <td><?php echo $entry_account; ?></td>
				<td><select name="customer_group_id">
				  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
                  <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                  </select></td>
              </tr>  
			</table>
		  </div>	
		</td>
      </tr>  
    </table>
    <h2><?php echo $text_your_details; ?></h2>
    <div class="content">
      <table class="form">      
        <tr>
          <td><span class="required">*</span> <?php echo $entry_firstname; ?></td>
          <td><input type="text" name="firstname" value="<?php echo $firstname; ?>" />
            <?php if ($error_firstname) { ?>
            <span class="error"><?php echo $error_firstname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_lastname; ?></td>
          <td><input type="text" name="lastname" value="<?php echo $lastname; ?>" />
            <?php if ($error_lastname) { ?>
            <span class="error"><?php echo $error_lastname; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_email; ?></td>
          <td><input type="text" name="email" value="<?php echo $email; ?>" />
            <?php if ($error_email) { ?>
            <span class="error"><?php echo $error_email; ?></span>
            <?php } ?></td>
        </tr>
        <tr id="telephone-display">
          <td><span class="required">*</span> <?php echo $entry_telephone; ?></td>
          <td><input type="text" name="telephone" value="<?php echo $telephone; ?>" />
            <?php if ($error_telephone) { ?>
            <span class="error"><?php echo $error_telephone; ?></span>
            <?php } ?></td>
        </tr>
        <tr id="fax-display">
		  <td><?php echo $entry_fax; ?></td>
          <td><input type="text" name="fax" value="<?php echo $fax; ?>" /></td>
        </tr>
      </table>
    </div>
	<table class="group">
	  <tr id="address-display">
	    <td>
	      <h2><?php echo $text_your_address; ?></h2>
			<div class="content">
			  <table class="form">
				<tr id="company-display">
				  <td><?php echo $entry_company; ?></td>
				  <td><input type="text" name="company" value="<?php echo $company; ?>" /></td>
				</tr>       
				<tr>
				  <td><span class="required">*</span> <?php echo $entry_address_1; ?></td>
				  <td><input type="text" name="address_1" value="<?php echo $address_1; ?>" />
					<?php if ($error_address_1) { ?>
					<span class="error"><?php echo $error_address_1; ?></span>
					<?php } ?></td>
				</tr>
				<tr id="address-2-display">
				  <td><?php echo $entry_address_2; ?></td>
				  <td><input type="text" name="address_2" value="<?php echo $address_2; ?>" /></td>
				</tr>
				<tr>
				  <td><span class="required">*</span> <?php echo $entry_city; ?></td>
				  <td><input type="text" name="city" value="<?php echo $city; ?>" />
					<?php if ($error_city) { ?>
					<span class="error"><?php echo $error_city; ?></span>
					<?php } ?></td>
				</tr>
				<tr>
				  <td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
				  <td><input type="text" name="postcode" value="<?php echo $postcode; ?>" />
					<?php if ($error_postcode) { ?>
					<span class="error"><?php echo $error_postcode; ?></span>
					<?php } ?></td>
				</tr>
				<tr>
				  <td><span class="required">*</span> <?php echo $entry_country; ?></td>
				  <td><select name="country_id">
					  <option value=""><?php echo $text_select; ?></option>
					  <?php foreach ($countries as $country) { ?>
					  <?php if ($country['country_id'] == $country_id) { ?>
					  <option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
					  <?php } else { ?>
					  <option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
					  <?php } ?>
					  <?php } ?>
					</select>
					<?php if ($error_country) { ?>
					<span class="error"><?php echo $error_country; ?></span>
					<?php } ?></td>
				</tr>
				<tr>
				  <td><span class="required">*</span> <?php echo $entry_zone; ?></td>
				  <td><select name="zone_id">
					</select>
					<?php if ($error_zone) { ?>
					<span class="error"><?php echo $error_zone; ?></span>
					<?php } ?></td>
				</tr>
			  </table>
		   </div>
		 </td>
      </tr>  
    </table>
	
	<table class="group">
	  <tr id="additional-display">
	    <td>
	      <h2><?php echo $text_additional; ?></h2>
          <div class="content">
			<table class="form"> 
			  <tr id="company-id-display">
			    <td><span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?></td>
			    <td><input type="text" name="company_id" value="<?php echo $company_id; ?>" />
				  <?php if ($error_company_id) { ?>
				  <span class="error"><?php echo $error_company_id; ?></span>
				  <?php } ?></td>
			  </tr>
			  <tr id="tax-id-display">
			    <td><span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?></td>
			    <td><input type="text" name="tax_id" value="<?php echo $tax_id; ?>" />
				  <?php if ($error_tax_id) { ?>
				  <span class="error"><?php echo $error_tax_id; ?></span>
				  <?php } ?></td>
			  </tr>
			</table>
		  </div>	
		</td>
      </tr>  
    </table>
    <h2><?php echo $text_your_password; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><span class="required">*</span> <?php echo $entry_password; ?></td>
          <td><input type="password" name="password" value="<?php echo $password; ?>" />
            <?php if ($error_password) { ?>
            <span class="error"><?php echo $error_password; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_confirm; ?></td>
          <td><input type="password" name="confirm" value="<?php echo $confirm; ?>" />
            <?php if ($error_confirm) { ?>
            <span class="error"><?php echo $error_confirm; ?></span>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <h2><?php echo $text_newsletter; ?></h2>
    <div class="content">
      <table class="form">
        <tr>
          <td><?php echo $entry_newsletter; ?></td>
          <td><?php if ($newsletter) { ?>
            <input type="radio" name="newsletter" value="1" checked="checked" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" />
            <?php echo $text_no; ?>
            <?php } else { ?>
            <input type="radio" name="newsletter" value="1" />
            <?php echo $text_yes; ?>
            <input type="radio" name="newsletter" value="0" checked="checked" />
            <?php echo $text_no; ?>
            <?php } ?></td>
        </tr>
      </table>
    </div>
    <?php if ($text_agree) { ?>
    <div class="buttons">
      <div class="right"><?php echo $text_agree; ?>
        <?php if ($agree) { ?>
        <input type="checkbox" name="agree" value="1" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="agree" value="1" />
        <?php } ?>
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
    <?php } else { ?>
    <div class="buttons">
      <div class="right">
        <input type="submit" value="<?php echo $button_continue; ?>" class="button" />
      </div>
    </div>
    <?php } ?>
  </form>
  </div>
</div>
</div>
  <?php echo $content_bottom; ?>
<script type="text/javascript"><!--
jQuery('select[name=\'customer_group_id\']').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['telephone_display'] = '<?php echo $customer_group['telephone_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['fax_display'] = '<?php echo $customer_group['fax_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['address_display'] = '<?php echo $customer_group['address_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_display'] = '<?php echo $customer_group['company_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['address_2_display'] = '<?php echo $customer_group['address_2_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['additional_display'] = '<?php echo $customer_group['additional_display']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['telephone_display'] == '1') {
			jQuery('#telephone-display').show();
		} else {
			jQuery('#telephone-display').hide();
		}
		
		if (customer_group[this.value]['fax_display'] == '1') {
			jQuery('#fax-display').show();
		} else {
			jQuery('#fax-display').hide();
		}
		
		if (customer_group[this.value]['address_display'] == '1') {
			jQuery('#address-display').show();
		} else {
			jQuery('#address-display').hide();
		}
		
		if (customer_group[this.value]['company_display'] == '1') {
			jQuery('#company-display').show();
		} else {
			jQuery('#company-display').hide();
		}
		
		if (customer_group[this.value]['company_id_display'] == '1') {
			jQuery('#company-id-display').show();
		} else {
			jQuery('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			jQuery('#company-id-required').show();
		} else {
			jQuery('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			jQuery('#tax-id-display').show();
		} else {
			jQuery('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			jQuery('#tax-id-required').show();
		} else {
			jQuery('#tax-id-required').hide();
		}	
		
		if (customer_group[this.value]['address_2_display'] == '1') {
			jQuery('#address-2-display').show();
		} else {
			jQuery('#address-2-display').hide();
		}	
		
		if (customer_group[this.value]['additional_display'] == '1') {
			jQuery('#additional-display').show();
		} else {
			jQuery('#additional-display').hide();
		}	
		
	}
});

jQuery('select[name=\'customer_group_id\']').trigger('change');
//--></script>   
<script type="text/javascript"><!--
jQuery('select[name=\'country_id\']').bind('change', function() {
	jQuery.ajax({
		url: 'index.php?route=account/register/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			jQuery('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			jQuery('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				jQuery('#postcode-required').show();
			} else {
				jQuery('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			jQuery('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

jQuery('select[name=\'country_id\']').trigger('change');
//--></script>
<script type="text/javascript"><!--
jQuery('.colorbox').colorbox({
	width: 640,
	height: 480
});
//--></script> 
<?php echo $footer; ?>