function initialize(){
  var uri = new URI(window.location);

  setup();
  updateCurrentNavigationItem(uri);
  highlightPostFirstPara(uri);
}

function setup(){
  $$('.body > p').each(function(item){
    item.addEvent('click', function(e){
      highlightEl(this);
    });
  });
}

function updateCurrentNavigationItem(uri){

  $$('#navigation a').each(function(item, i){
    if(item.getProperty('href') == uri.get('directory')+uri.get('file'))
    {
      item.addClass('current');
    }
  });

}

function highlightPostFirstPara(uri){
  rx_post = /[0-9]{4}\/[0-9]{2}\/[0-9]{2}/

  if(rx_post.test(uri.get('directory')) && uri.get('data').hl == '1'){
    highlightEl($(document.body).getElement('.body p'));
  }
}

function highlightEl(el){
  el.highlight('#AAA');
}
