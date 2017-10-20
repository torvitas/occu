/**
 * devicetype.js
 **/
 
/**
 * Ger�tetyp.
 **/
DeviceType = Class.create({
 
  initialize: function(id)
  {
    this.id          = id;
    this.name        = id;
    this.description = DEV_getDescription(id);
  },
  
  isDeletable: function()
  {
    return DeviceTypeList.isDeletable(this);
  },
  
  /**
   * Liefert den HTML-Code eines Thumbnails f�r das Ger�t.
   **/
  getThumbnailHTML: function(formName)
  { 
    return DeviceTypeList.getThumbnailHTML(this.id, formName);
  },
  
  /**
   * Liefert den HTML-Code eines Bildes f�r das Ger�t.
   **/
  getImageHTML: function(formName)
  {
    return DeviceTypeList.getImageHTML(this.id, formName);
  }
  
});