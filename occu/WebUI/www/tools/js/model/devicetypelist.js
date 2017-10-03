/**
 * devicetypelist.js
 **/

/**
 * Liste der verf�gbaren Ger�tetypen.
 **/
DeviceTypeList = Singleton.create({
  THUMBNAIL_SIZE: 50,   // Gr��e eines (quadratischen) Thumbnails
  IMAGE_SIZE: 250,   // Gr��e eines (quadratischen) Bildes
  
  /**
   * Liste der nicht l�schbaren Ger�tetypen
   **/
  m_undeletableTypeNames: [
    "HM-CCU-1",
    "HM-RCV-50",
    "HMW-RCV-50",
    "HM-Sec-SD-Team"
  ],
  
  /**
   * Konstruktor
   **/
  initialize: function()
  {
    this.deviceTypes = {};     // verf�gbare Ger�tetypen
    
    for (var i = 0, len = DEV_LIST.length; i < len; i++)
    {
      var deviceType = new DeviceType(DEV_LIST[i]);
      this.deviceTypes[deviceType.id] = deviceType;
    }
  
    this.unknownType = this.deviceTypes["DEVICE"];    
  },
  
  /**
   * Ermittelt, ob ein Ger�t von diesem Typ gel�scht werden kann.
   **/
  isDeletable: function(deviceType)
  {
    return !this.m_undeletableTypeNames.ex_contains(deviceType.name);
  },
  
  /**
   * Erstellt den HTML-Code zu einem Bild bzw. Thumbnail
   **/
  getPictureHTML: function(typeId, formName, size)
  {   
    var wrapper, canvas, jg, result;
    
    wrapper = document.createElement("div");
    Element.setStyle(wrapper, {display: "none"});    
    $("body").appendChild(wrapper);
    
    canvas = document.createElement("div");
    wrapper.appendChild(canvas);
    Element.setStyle(canvas, {
      position: "absolute",
      left:     "0px",
      top:      "0px"      
    });    
    
    jg = new jsGraphics(canvas);
    InitGD(jg, size);
    Draw(jg, typeId, size, formName);
    
    result = wrapper.innerHTML;
    
    Element.remove(wrapper);
    return result;
  },
  
  /**
   * Liefert die Liste aller Ger�tetypen.
   **/
  listDeviceTypes: function()
  {
    return Object.values(this.deviceTypes);
  },
  
  /**
   * Liefert einen Geratetypen anhand seiner Id
   **/
  getDeviceType: function(id)
  {
    var deviceType = this.deviceTypes[id];
    
    if (typeof(deviceType) != "undefined") { return deviceType; }
    else                                   { return this.unknownType; }
  },
  
  /**
   * Liefert den HTML-Code eines Thumbnails
   **/
  getThumbnailHTML: function(typeId, formName)
  {
    return this.getPictureHTML(typeId, formName, this.THUMBNAIL_SIZE);
  },
  
  /**
   * Liefert den HTML-Code eines Bildes
   **/
  getImageHTML: function(typeId, formName)
  {
    return this.getPictureHTML(typeId, formName, this.IMAGE_SIZE);
  }

});
 