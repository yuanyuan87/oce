var F_PUSH_NEWS = 0x01;
var F_PUSH_MINI = 0x02;
var F_PUSH_IM = 0x04;
var F_PUSH_CLASS = 0x08;
var F_PUSH_MINI_GROUP = 0x10;

function GetStypeIdsHtml(default_value) {
  $.ajax('/get-stype-ids', {
    async : false,
    success : function(text){
      ids = $.parseJSON(text);
    },
    error : function(){
      alert('/get-stype-ids 出错');
    }
  });

  var html = '<option value="' + default_value + '">' + default_value + '</option>';
  for(var i = 0; i < ids.length; ++i) {
    html += '<option value="' + ids[i] + '">' + ids[i] + '</option>';
  }

  if (typeof(g_old_feed_list) != 'undefined') {
    for(var id in g_old_feed_list) {
      html += '<option value="' + id + '">' + id + '(老版本)</option>';
    }
  }

  return html;
}

var FeedConfigView = function(stype) {
  this.stype_ = isNaN(stype) ? -1 : stype;
  this.dom_ = $('<table width="1000" border="0" class="t1">' +
          '<tr>' +
            '<th colspan="4">Feed配置信息 &nbsp; <a id="save-config" style="float:right;" href="#nogo">保存</a></th>' +
          '</tr>' +
          '<tr>' +
            '<td style="width:110px;">类型（TYPE）：</td>' +
            '<td><input id="type_id" size="4" disabled maxlength="3"/></td>' +
            '<td>小类型（STYPE）：</td>' +
            '<td><input id="stype_id" size="6" maxlength="5"/></td>' +
          '</tr>' +
          '<tr>' +
            '<td>业务类型描述：</td>' +
            '<td colspan="3"><input size="120" type="text" id="stype-desc"/>' +
          '</tr>' +
          '<tr>' +
            '<td>权重（Weight）：</td>' +
            '<td><select id="stype_weight">' +
                '<option>1</option>' +
                '<option>2</option>' +
                '<option>3</option>' +
                '<option>4</option>' +
                '<option>5</option>' +
                '<option>6</option>' +
                '<option>7</option>' +
                '<option>8</option>' +
                '<option>9</option>' +
                '<option>10</option>' +
                '<option>11</option>' +
                '<option>12</option>' +
                '<option>13</option>' +
                '<option>14</option>' +
                '<option>15</option>' +
                '<option>16</option>' +
                '<option>17</option>' +
                '<option>18</option>' +
                '<option>19</option>' +
                '<option>20</option>' +
              '</select>' +
            '</td>' +
            '<td>父小类型（PType）：</td>' +
            '<td><select id="ptype_id" style="width:70px;">' +
              '<option>0</option>' +
            '</select></td>' +
          '</tr>' +
          '<tr>' +
            '<td>持久化本体：</td>' +
            '<td>save:' +
            '<input name="SaveContent" type="radio" value="1" />&nbsp;&nbsp; not save:<input name="SaveContent" type="radio" value="0" checked="checked" /></td>' +
            '<td>持久化FeedDB：</td>' +
            '<td>save:' +
            '<input name="SaveFeedDB" type="radio" value="1" />&nbsp;&nbsp; not save:<input name="SaveFeedDB" type="radio" value="0" checked="checked" /></td>' +
          '</tr>' +
          '<tr>' +
            '<td>NewsFeed合并策略：</td>' +
            '<td>' +
               'append: <input name="NewsMergeType" type="radio" value="2" />' +
               '&nbsp; replace: <input name="NewsMergeType" type="radio" value="1" checked="checked" /></td>' +
            '<td>MiniFeed合并策略：</td>' +
            '<td>append:<input name="MiniMergeType" type="radio" value="2" />' +
              '&nbsp; replace: <input name="MiniMergeType" type="radio" value="1" checked="checked" />' +
            '</td>' +
          '</tr>' +
          '<tr>' +
            '<td>推送策略：</td>' +
            '<td colspan="3">NewsFeed:<input type="checkbox" id="PushPolicy_news"/>&nbsp;&nbsp; MiniFeed:<input id="PushPolicy_mini" type="checkbox"/>&nbsp;&nbsp; IM:<input id="PushPolicy_IM" type="checkbox"/>' +
              '&nbsp;&nbsp; Class:' +
              '<input id="PushPolicy_class" type="checkbox"/>&nbsp;&nbsp; MiniGroup:<input id="PushPolicy_mini_group" type="checkbox"/></td>' +
          '</tr>' +
          '<tr>' +
            '<td>分发表达式自定义：</td>' +
            '<td>自定义: <input name="CustomExpr" type="radio" value="1"/>' +
              '&nbsp;&nbsp;配置: <input name="CustomExpr" type="radio" value="0" checked="checked" /></td>' +
            '<td>合并后是否更新时间：</td>' +
            '<td>update:' +
              '<input name="UpdateTimeOnMerge" type="radio" value="1" />' +
              '&nbsp;&nbsp; not update:' +
            '<input name="UpdateTimeOnMerge" type="radio" value="0" checked="checked" /></td>' +
          '</tr>' +
          '<tr>' +
            '<td>保存时长：</td>' +
            '<td><input name="Lifetime" value="30" size="5" maxlength="5"/> 天（-1表示永久保存）</td>' +
            '<td>每天发送配额：</td>' +
            '<td><input name="DailyQuota" value="10000" size="9" maxlength="9"/> 条（-1表示不限制）</td>' +
          '</tr>' +
        '</table>');
  var T = this;
  $('#save-config', this.dom_).click(
    function() {
      T.Save();
    }
  );

  $('input#stype_id', this.dom_).change(
    function() {
      var stype_id = parseInt($(this).val());
      if (isNaN(stype_id) || stype_id <= 100) {
        alert('stype值必须是大于100的整数值');
        return;
      }
      var ptype = $('#ptype_id', this.dom_).val();
      $('#ptype_id', this.dom_).html(GetStypeIdsHtml(ptype));
      $('#ptype_id').prepend($('<option value="' + stype_id + '">' + stype_id + '</option>')); 

      console.log($(this).val());
      $('input#type_id', T.dom_).val(stype_id - stype_id % 100);
    }
  );
}

FeedConfigView.prototype = {
  "AppendToNode" : function(node) {
    node.append(this.dom_);
  },

  "Load" : function() {
    $('#ptype_id', this.dom_).html(GetStypeIdsHtml('0'));
    if(this.stype_ <= 0) {
      return;
    }
    $('input#type_id', this.dom_).val(this.stype_ - this.stype_ % 100).attr('disabled', true);
    $('input#stype_id', this.dom_).val(this.stype_).attr('disabled', true);
    var T = this;
    $.ajax('/get-feed-config?stype=' + this.stype_, {
      'success' : function(text){
         var o = $.parseJSON(text);
         $('#stype-desc', T.dom_).val(o.desc);
         $('#stype_weight', T.dom_).val(o.weight);
         $('#ptype_id', T.dom_).val(o.ptype);

         $("input[name='SaveContent'][value='" + o.save_content + "']", T.dom_).attr("checked", true);
         $("input[name='SaveFeedDB'][value='" + o.save_feed_db + "']", T.dom_).attr("checked", true);
         $("input[name='NewsMergeType'][value='" + o.news_merge_type + "']", T.dom_).attr("checked", true);
         $("input[name='MiniMergeType'][value='" + o.mini_merge_type + "']", T.dom_).attr("checked", true);

         $("input:checkbox#PushPolicy_news", T.dom_).attr("checked", o.push_flags & F_PUSH_NEWS);
         $("input:checkbox#PushPolicy_mini", T.dom_).attr("checked", o.push_flags & F_PUSH_MINI);
         $("input:checkbox#PushPolicy_IM", T.dom_).attr("checked", o.push_flags & F_PUSH_IM);
         $("input:checkbox#PushPolicy_class", T.dom_).attr("checked", o.push_flags & F_PUSH_CLASS);
         $("input:checkbox#PushPolicy_mini_group", T.dom_).attr("checked", o.push_flags & F_PUSH_MINI_GROUP);

         $("input[name='CustomExpr'][value='" + o.custom_expr + "']", T.dom_).attr("checked", true);
         $("input[name='UpdateTimeOnMerge'][value='" + o.update_time_on_merge + "']", T.dom_).attr("checked", true);
         $("input[name='Lifetime']", T.dom_).val(o.lifetime);
         $("input[name='DailyQuota']", T.dom_).val(o.daily_quota);

         $("#MiniMergeBy", T.dom_).val(o.mini_merge_by);
         $("#NewsMergeBy", T.dom_).val(o.news_merge_by);
         $("#SourceBy", T.dom_).val(o.source_by);
         $("#PSourceBy", T.dom_).val(o.psource_by);
         $("#ActorBy", T.dom_).val(o.actor_by);
         $("#ToGroupBy", T.dom_).val(o.togroup_by);
         $("#DispatchExpr", T.dom_).val(decodeURIComponent(o.dispatch_expr));
      },
      'error' : function(){
        alert('加载新鲜事类型 ' + T.stype_ + ' 配置信息失败');
        $('#save-config', T.dom_).unbind('click').click(
          function() {
            alert('加载失败，禁止保存');
          }
        );
      }
    });
  }, 
  Save : function(jump_to_edit, apply_id, create_new) {
    var url='/save-feed-config?';
    var type_id = parseInt($('input#type_id', this.dom_).val());
    if (isNaN(type_id) || type_id <= 0) {
      alert('请指定正确的type值');
      return;
    }
    url += 'type=' + type_id;
    var stype_id = parseInt($('input#stype_id', this.dom_).val());
    if (isNaN(stype_id) || stype_id <= 0) {
      alert('请指定正确的stype值');
      return;
    }

    if (create_new) {
      if (g_old_feed_list[stype_id]) {
        if(!confirm('类型 "' + stype_id + g_old_feed_list[stype_id] + '" 在旧版新鲜事中已经存在，确定要在创建新版吗?')) {
          return false;
        }
      }
    }

    url += '&stype=' + stype_id;
    url += '&is_new=' + (this.stype_ != stype_id ? 1 : 0);
    if ((stype_id - stype_id % 100) != type_id) {
      alert('type ' + type_id + '和stype ' + stype_id + ' 值不匹配');
      return;
    }

    url += '&title=' + $('#stype-desc', this.dom_).val();
    url += '&weight=' + $('#stype_weight', this.dom_).val();
    url += '&ptype=' + $('#ptype_id', this.dom_).val();
    url += '&save_content=' + $("input[name='SaveContent']:checked", this.dom_).val();
    url += '&save_feed_db=' + $("input[name='SaveFeedDB']:checked", this.dom_).val();
    url += '&news_merge_type=' + $("input[name='NewsMergeType']:checked", this.dom_).val();
    url += '&mini_merge_type=' + $("input[name='MiniMergeType']:checked", this.dom_).val();

    var push_flags = 0;
    if ($("input:checkbox#PushPolicy_news", this.dom_).attr("checked")) {
      push_flags |= 0x01;
    }
    if ($("input:checkbox#PushPolicy_mini", this.dom_).attr("checked")) {
      push_flags |= 0x02;
    }
    if ($("input:checkbox#PushPolicy_IM", this.dom_).attr("checked")) {
      push_flags |= 0x04;
    }
    if ($("input:checkbox#PushPolicy_class", this.dom_).attr("checked")) {
      push_flags |= 0x08;
    }
    if ($("input:checkbox#PushPolicy_mini_group", this.dom_).attr("checked")) {
      push_flags |= 0x10;
    }
    url += '&push_flags=' + push_flags;
    url += '&custom_expr=' + $("input[name='CustomExpr']:checked", this.dom_).val();
    url += '&update_time_on_merge=' + $("input[name='UpdateTimeOnMerge']:checked", this.dom_).val();
    url += '&lifetime=' + $("input[name='Lifetime']", this.dom_).val();
    url += '&daily_quota=' + $("input[name='DailyQuota']", this.dom_).val();
    if (apply_id > 0) {
      url += '&apply_id=' + apply_id;
    }
    $.ajax(url, {
      'success' : function(text){
        var o = $.parseJSON(text);
        if (o.status == 0) {
          alert('保存成功');
          if (jump_to_edit) {
            window.location = '/feed-config-edit?stype=' + stype_id;
          }
        } else {
          alert(o.desc);
        }
      },
      'error' : function(){
        alert('保存失败');
      }
    });
  },
  HideSave : function() {
    $('#save-config', this.dom_).css('display', 'none');
  },
  "Disable" : function() {
    $('input, select', this.dom_).each(
      function() {
        $(this).attr('disabled', 'true');
      }
    );
    this.HideSave();
  }
}

var FeedKeyView = function(stype, version, using_seq_id, test_seq_id, status, readonly) {
  this.stype_ = stype;
  this.top_key_list_ = []
  this.version_ = version;
  this.using_seq_id_ = using_seq_id;
  // alert(using_seq_id + ' - ' +  test_seq_id + ' - ' + status);
  this.dom_ = $('<div><div id="panel" style="margin-left:0px; width:998px; line-height:24px; border:1px solid #CAD9EA;border-top:0;">'
                 + '<span id="toggle-span" class="toggle-span folded"></span> <span id="version-span">版本:<span style="color:red;">' + version + '</span></span>'
                 + ' <span id="status-span">&nbsp; 状态: <select id="version-status" disabled="true"><option value="0">disabled</option>'
                 +    '<option value="1">test</option><option value="2">read only</option><option value="3">dispatching</option>' 
                 + '</select></span>' 
                 + ' <span id="seqs-span">&nbsp; 线上模板序号:<span id="using-seq-id" style="color:red;">' + using_seq_id + '</span>' 
                 + ' &nbsp; 测试模板序号:<span id="test-seq-id" style="color:red;">' + test_seq_id + '</span></span>' 
                 
                 + ' <span class="edit-keys-panel">&nbsp; <a href="#nogo" id="validate-keys">检查合法性</a> &nbsp; <a href="#nogo" id="save-keys">保存</a></span>'

                 + ' &nbsp; <a style="display:none;" href="/feed-keys-edit?stype=' + stype + '&version='+ version + '" id="all-seqs">编辑</a>'
                 + ' &nbsp; <a href="#nogo" id="remove_schema_version">删除</a>'
                 + ' &nbsp; <a id="generate-java-code" href="#nogo">生成java代码</a>'
               + '</div>' +
      '<div><table width="1000" id="mapping-table" border="0" class="t1">' +
          '<tbody><tr>' +
              '<th colspan="3">Feed必填字段设置</th>' +
          '</tr>' +
          '<tr>' +
            '<th>KEY</th>' +
            '<th width="260">VALUE</th>' +
            '<th>说明</th>' +
          '</tr>' +
          '<tr>' +
            '<td>MiniMergeBy</td>' +
            '<td><select id="MiniMergeBy" class="key-mapping">' +
              '<option value="">(不去重)</option>' +
            '</select></td>' +
            '<td>MiniFeed中将按此设置进行去重合并操作</td>' +
          '</tr>' +
          '<tr>' +
            '<td>NewsMergeBy</td>' +
            '<td><select id="NewsMergeBy" class="key-mapping">' +
              '<option value="">(不去重)</option>' +
            '</select></td>' +
            '<td>NewsFeed中将按此设置进行去重合并操作</td>' +
          '</tr>' +
          '<tr>' +
            '<td>SourceBy</td>' +
            '<td><select id="SourceBy" class="key-mapping">' +
            '</select></td>' +
            '<td>产生Feed的业务的流水号，如发日志新鲜事时Source为日志表中的自增ID，即Blogid</td>' +
          '</tr>' +
          '<tr>' +
            '<td>PSourceBy</td>' +
            '<td><select id="PSourceBy" class="key-mapping">' +
            '</select></td>' +
            '<td>用于分享，照片上转等具有父子关系的新鲜事发送，如分享日志产生的Feed，PSource应该是日志业务的流水号; 上转照片产生的Feed的PSource为所在像册的ID，主要用于批量删除</td>' +
          '</tr>' +
          '<tr>' +
            '<td>ActorBy</td>' +
            '<td><select id="ActorBy" class="key-mapping">' +
            '</select></td>' +
            '<td>触发Feed的人的UID</td>' +
          '</tr>' +
          '<tr>' +
            '<td>ToGroupBy</td>' +
            '<td><select id="ToGroupBy" class="key-mapping">' +
              '<option value="">(不发给小群)</option>' +
            '</select></td>' +
            '<td>小群的id</td>' +
          '</tr>' +
          '<tr>' +
            '<td>分发表达式</td>' +
            '<td><input id="DispatchExpr" value="" size="32"/></td>' +
            '<td>由分发表达式计算出新鲜事分发给哪些用户(仅当使用"配置"分发表达式时有效)</td>' +
          '</tr>' +
        '</tbody></table></div>' 
             + '<table id="key-list-header" width="1000" border="0" class="t1">'
               + '<tr>'
                 + '<th width="200px">KEY (保留顶层字段名: <span style="color:red;">id, type,  stype,  minimerge,  newsmerge,  source,  psource,  actor, expr</span>) <input type="text" id="add-key" title="新建顶层key" class="add-child"> </th>'
                 + '<th width="260px">描述</th>'
                 + '<th width="120px">数据类型</th>'
                 + '<th width="60px">节点循环</th>'
                 + '<th width="60px">可选字段</th>'
                 + '<th>操作</th>'
               + '</tr>'
             + '</table>'
             + '<div class="key-list-container">'
               + '<ol id="key-list" style="list-style:none;padding:0;margin:0;"></ol>'
             + '</div></div>');

  var T = this;

  $('#version-status', this.dom_).val(status);
  $('#add-key', this.dom_).click(
    function() {
      T.KeyListAdd('', '', '');
    }
  );

  $('#remove_schema_version', this.dom_).click(
    function() {
      if(!confirm('确定删除版本' + T.version_ + '吗?')) {
        return;
      }
      // T.KeyListAdd('', '', '');
      $.ajax('/remove-data-version?stype=' + T.stype_ + '&version=' + T.version_, {
        success : function(text) {
          alert(text);
        },
        error : function() {
          alert('删除版本 ' + T.version_ + ' 失败');
        }
      });
    }
  );

  $('#save-keys', this.dom_).click(
    function() {
      if(!T.ValidateKeys()) {
        alert('数据格式不合法');
        return;
      }
      var url='/save-version-keys?'
        + 'stype=' + T.stype_
        + '&version=' + T.version_;

      url += '&mini_merge_by=' + $('#MiniMergeBy', T.dom_).val();
      url += '&news_merge_by=' + $('#NewsMergeBy', T.dom_).val();
      url += '&source_by=' + $('#SourceBy', T.dom_).val();
      url += '&psource_by=' + $('#PSourceBy', T.dom_).val();
      url += '&actor_by=' + $('#ActorBy', T.dom_).val();
      url += '&togroup_by=' + $('#ToGroupBy', T.dom_).val();
      url += '&dispatch_expr=' + encodeURIComponent($('#DispatchExpr', T.dom_).val());

      var keys_xml = T.GetKeysXml();
      if(!T.ValidateXmlLoop(keys_xml)) {
        return;
      }

      $.ajax(url, {
        'data' : 'kl=' + encodeURIComponent(T.GetKeysXml()),
        'type' : 'POST',
        'success' : function(text){
          alert(text);
        },
        'error' : function(){
          alert('保存出错');
        }
      });
    }
  );

  $('#validate-keys', this.dom_).click(
    function() {
      if(T.ValidateKeys()) {
        alert('Feed 数据验证通过');
      }
    }
  );
  
  $('#generate-java-code', this.dom_).click(
    function() {
      T.GenerateJavaCode();
    }
  );

  var T = this;
  $('#toggle-span', this.dom_).click(
    function() {
      if ($(this).hasClass('folded')) {
        T.ShowMapping(true);
        T.ShowKeys(true);
        $(this).removeClass('folded').addClass('expanded')
      } else {
        T.ShowMapping(false);
        T.ShowKeys(false);
        $(this).removeClass('expanded').addClass('folded')
      }
    }
  );

  $.ajax({
    'url': '/get-stype-version-info?stype=' + stype + '&version=' + version,
    'success': function(T) {
      var This = T;
      return function(text) {
        var o = $.parseJSON(text);
        This.XmlKeyListAdd($(o.keys_xml));
        This.FillTopKeys(o);
        This.UpdateOptionalCheckbox(); 
        This.stype_comment_ = o.stype_comment;

        if (readonly) {
          This.Disable(); 
        }
      };
    }(this)
  });
}

FeedKeyView.prototype.GenerateJavaCode = function() {
  var keys_xml = this.GetKeysXml();
  if(!this.ValidateXmlLoop(keys_xml)) {
    return;
  }
  var parser = new SchemaParser();
  parser.ParseSchema(this.stype_, this.version_, keys_xml, this.is_custom_expr_);
  var hdf = parser.GetHdfMap();
  hdf += ";FeedStruct.comment=" + encodeURIComponent(this.stype_comment_);

  $.ajax('/generate-code?lang=java&stype=' + this.stype_ + '&version=' + this.version_, {
    type: 'POST',
    data: 'hdf=' + encodeURIComponent(encodeURIComponent(hdf)), 
    context: document.body,
    success: function(text) {
      alert('生成代码成功，点确定后下载代码文件');
      window.location = text;
    },
    error: function(){
      alert('生成代码失败');
    }
  });
}

FeedKeyView.prototype.ValidateXmlLoop = function(keys_xml) {
  if (!keys_xml || keys_xml.length <= 0) {
    return false;
  }
  function HasLoopAncestor(node) {
    var p = node;
    console.log('parent = ' + p.parent().parent().length);
    // return false;
    p = p.parent()
    while(p.length > 0) {
      console.log('parent = ' + p);
      if (p.attr('is_loop') == "1") {
        return true;
      }
      p = p.parent();
    }
    return false;
  }

  function CheckChildren(dom) {
    var childs = dom.children();
    for(var i = 0; i < childs.length; ++i) {
      var n = $(childs[i]);
      if (n.attr('is_loop') == "1") {
        if (HasLoopAncestor(n)) {
          alert('循环节点 ' + n.attr('name') + ' 不能有可循环的上层节点');
          return false;
        }
      }
      if (n.children().length > 0) {
        if(!CheckChildren(n)) {
          return false;
        }
      }
    }

    return true;
  }

  return CheckChildren($(keys_xml));
}

FeedKeyView.prototype.ValidateKeys = function() {
  var top_keys = this.GetTopKeys();
  function FindKey(key) {
    for(var i = 0; i < top_keys.length; ++i) {
      if (key == top_keys[i]) {
        return true;
      }
    }
    return false;
  }

  var nodes = $('select', $('#mapping-table', this.dom));

  for(var i = 0; i < nodes.length; ++i) {
    var k = $(nodes[i]).val();
    if (k && k.length > 0 && !FindKey($(nodes[i]).val())) {
      alert('映射字段不合法:' + k);
      return false;
    }
  }
  return true;
}

FeedKeyView.prototype.ShowMapping = function(b) {
  $('#mapping-table', this.dom_).css('display', b ? '' : 'none');
}

FeedKeyView.prototype.ShowKeys = function(b) {
  $('#key-list-header', this.dom_).css('display', b ? '' : 'none');
  $('div.key-list-container', this.dom_).css('display', b ? '' : 'none');
}

FeedKeyView.prototype.UpdateOptionalCheckbox = function() {
  $('span.node-optional input:checkbox', this.dom_).css('visibility', 'visible');
  $('#key-list li', this.dom_).each(
    function() {
      var is_loop = $('> div > .node-loop > input:checkbox', $(this)).attr('checked');
      if ($(this).hasClass('multi') && is_loop) {
        $('ol span.node-optional input:checkbox', $(this)).css('visibility', 'hidden');
        // $('ol span.node-optional input:checkbox', $(this)).hide();
      }
      if ($(this).hasClass('multi') && !is_loop) {
        $('> div > span.node-optional input:checkbox', $(this)).css('visibility', 'hidden');
        // $('> div > span.node-optional input:checkbox', $(this)).hide();
      }
    }
  );
}

FeedKeyView.prototype.UpdateTopKeys = function() {
  this.UpdateOptionalCheckbox();
 
  var keys = this.GetTopKeys();
  var html = '';
  for(var i = 0; i < keys.length; ++ i) {
    html += '<option value="' + keys[i] + '">' + keys[i] + '</option>';
  }
  $('select', $('#mapping-table', this.dom)).each(
    function() {
      var val = $(this).val();
      $(this).html(html).val(val);
    }
  );

  $('#MiniMergeBy', this.dom_).prepend($('<option value="">(不去重)</option>'));
  $('#NewsMergeBy', this.dom_).prepend($('<option value="">(不去重)</option>'));
}

FeedKeyView.prototype.FillTopKeys = function(ver_info) {
  var keys = this.GetTopKeys();
  for(var i = 0; i < keys.length; ++ i) {
    $('select.key-mapping', this.dom_).each(
        function() {
          $(this).append('<option value="' + keys[i] + '">' + keys[i] + '</option>');
        }
      );
  }
  var o = ver_info;
  $('#MiniMergeBy', this.dom_).val(o.mini_merge_by);
  $('#NewsMergeBy', this.dom_).val(o.news_merge_by);
  $('#SourceBy', this.dom_).val(o.source_by);
  $('#PSourceBy', this.dom_).val(o.psource_by);
  $('#ActorBy', this.dom_).val(o.actor_by);
  $('#ToGroupBy', this.dom_).val(o.togroup_by);
  if (o.is_custom_expr) {
    this.is_custom_expr_ = true;
    $('#DispatchExpr', this.dom_).attr('disabled', true).val("");
  } else {
    $('#DispatchExpr', this.dom_).val(decodeURIComponent(o.dispatch_expr));
  }
}

FeedKeyView.prototype.XmlKeyListAdd = function(xml_dom) {
  var child = xml_dom.children('key');
  var T = this;
  child.each(
    function() {
      var t = $(this);
      var root = T.KeyListAdd(t.attr('name'), t.attr('comment'), t.attr('type'), null, t.attr('is_loop'), t.attr('optional'));

      var kids = t.children('key');
      if (kids && kids.length) {
        $('select[name=DataType]', root).append($('<option value="node">node</option>')).val('node').attr('disabled',true);
        T.XmlKeyListAddChild(root, kids);
      } else {
        if (t.attr('type') == 'number' && t.attr('is_loop') != '1') {
          T.top_key_list_[T.top_key_list_.length] = t.attr('name');
        }
      }
    }
  );
  this.top_key_ready_ = true;
}

FeedKeyView.prototype.XmlKeyListAddChild = function(root, kids) {
  // var child = xml_dom.children(':first-child').children('key');
  var T = this;
  kids.each(
    function() {
      var t = $(this);
      var li = T.KeyListAddChild(root, t.attr('name'), t.attr('comment'), 
          t.attr('type'), null, t.attr('is_loop'), t.attr('optional'));

      var kids = t.children('key');
      if (kids && kids.length) {
        // $('select[name=DataType]', li).append($('<option value="node">node</option>')).val('node').attr('disabled',true);
        T.XmlKeyListAddChild(li, kids);
      }
    }
  );
}

FeedKeyView.prototype.KeyListAddChild = function(root, key, note, data_type, kids, is_loop, optional) {
  var T = this;
  if (root.hasClass('multi')) {
    root.removeClass('plus');
  } else {
    root.addClass('multi');
    $('select[name=DataType]', root).append($('<option value="node">node</option>')).val('node').attr('disabled',true);
    root.click( function() {
        var t = $(this);
        if (!t.hasClass('multi'))
          return;
        if (t.hasClass('plus')) {
          t.removeClass('plus');
          t.addClass('minus');
          $('ol', t).show();
        } else {
          t.removeClass('minus');
          $('ol', t).hide();
          t.addClass('plus');
        }
      }
    );
  }
  root.addClass('minus');
  var ol = $($('ol', root).get(0));
  if (ol.length <= 0) {
    ol = $('<ol style="margin:3px 0 3px 1px; padding:0;list-style:none;"></ol>');
    root.append(ol);
  }
  var li = $('<li><input type="text" class="key" value="' + key + '"/><div style="float:right; width:759px;"><input type="text" class="note"/>' +
      '<select name="DataType"><option>string</option><option>number</option><option>link</option><option>headurl</option></select>' + 
      '<span class="node-loop"><input type="checkbox"/></span><span class="node-optional"><input type="checkbox"/></span><input type="text" class="add-child"/><input type="text" class="remove-child"/></div></li>');
  $('input.note', li).val(decodeURIComponent(note));
  $('select[name=DataType]', li).val(data_type).change(
    function() {
      T.UpdateTopKeys();
    }
  );

  $('.node-loop input:checkbox', li).attr('checked', is_loop);
  $('.node-optional input:checkbox', li).attr('checked', optional);
  $('.node-loop input:checkbox', li).change(
    function() {
      T.UpdateTopKeys();
    }
  );

  li.children().click(
    function(e) {
      e.cancelBubble = true;
      e.stopPropagation && e.stopPropagation();
    }
  );

  li.click(
    function(e) {
      e.cancelBubble = true;
      e.stopPropagation && e.stopPropagation();
    }
  );
  $('input.add-child', li).click(
    function(e) {
      T.KeyListAddChild(li, '', '', '');
    }
  );
  $('input.remove-child', li).click(
    function(e) {
      if(!confirm('确定删除该key吗?')) {
        return;
      }
      var li = $(this).parent().parent()
      var ol = li.parent();
      li.remove();
      if ($('li', ol).length <= 0) {
        var r = ol.parent();
        r.removeClass('multi');
        r.removeClass('plus');
        r.removeClass('minus');

        $('option[value=node]', r).remove();
        $('select[name=DataType]', r).val('string').attr('disabled',false);;
        ol.remove();
      }
    }
  );

  if (kids && kids.length) {
    for(var i = 0; i < kids.length; ++i) {
      this.KeyListAddChild(li, kids[i].key, kids[i].note, kids[i].data_type, kids[i].kids);
    }
  }
  ol.append(li);
  ol.show();
  return li;
}

FeedKeyView.prototype.KeyListAdd = function(key, note, data_type, kids, is_loop, optional) {
  var n = $('<li class="feed-key"><input type="text" class="key" value="' + key + '"/><div style="float:right; width:759px;"><input type="text" class="note"/>'
        + '<select name="DataType"><option>string</option><option>number</option><option>link</option><option>headurl</option></select>'
        + '<span class="node-loop"><input type="checkbox"/></span><span class="node-optional"><input type="checkbox"/></span><input type="text" class="add-child"/>'
        + '<input type="text" class="remove-child" href="#nogo"/></div></li>');
  var T = this;
  $('input.note', n).val(decodeURIComponent(note));
  $('select[name=DataType]', n).val(data_type).change(
    function() {
      T.UpdateTopKeys();
    }
  );
  $('.node-loop input:checkbox', n).attr('checked', is_loop);
  $('.node-optional input:checkbox', n).attr('checked', optional);

  $('input.add-child', n).click(
    function(e) {
      T.KeyListAddChild(n, '', '', '') ;
    }
  );
  $('input.remove-child', n).click(
    function(e) {
      if(!confirm('确定删除该key吗?')) {
        return;
      }
      $(this).parent().parent().remove();
    }
  );

  $('> input.key', n).change(
    function() {
      var k = $(this).val();
      if (T.IsReservedKey(k)) {
        alert('不能使用保留字段名:' + k);
        $(this).val('');
      }
    }
  );

  n.children().click(
    function(e) {
      e.cancelBubble = true;
      e.stopPropagation && e.stopPropagation();
    }
  );

  $('span.node-loop > input:checkbox', n).change(
    function() {
      T.UpdateTopKeys();
    }
  );

  if (kids && kids.length) {
    for(var i = 0; i < kids.length; ++i) {
      this.KeyListAddChild(n, kids[i].key, kids[i].note, kids[i].data_type, kids[i].kids);
    }
  }
  $('#key-list', this.dom_).append(n);

  return n;
}

FeedKeyView.prototype.AppendToBody = function() {
  $(document.body).append(this.dom_);
}
FeedKeyView.prototype.AppendToNode = function(node) {
  node.append(this.dom_);
}

FeedKeyView.prototype.Disable = function() {
  $('span.edit-keys-panel',this.dom_).css('display', 'none');
  $('#add-key', this.dom_).css('display', 'none');
  $('input, select', this.dom_).attr('disabled', true);
  $('#key-list input.add-child, #key-list input.remove-child', this.dom_).hide();
  $('#all-seqs', this.dom_).css('display', 'inline');
  $('#remove_schema_version', this.dom_).css('display', 'inline');
}

FeedKeyView.prototype.HideToggle= function() {
  $('#toggle-span', this.dom_).css('display', 'none');
}

FeedKeyView.prototype.HideVersion = function() {
  $('#version-span', this.dom_).css('display', 'none');
}
FeedKeyView.prototype.HideStatus = function() {
  $('#status-span', this.dom_).css('display', 'none');
}
FeedKeyView.prototype.HideSeqs = function() {
  $('#seqs-span', this.dom_).css('display', 'none');
}
FeedKeyView.prototype.HideAllPanel = function() {
  $('#panel', this.dom_).css('display', 'none');
}

// 返回顶层的数据，且数据类型必须是number
FeedKeyView.prototype.GetTopKeys = function(root) {
  var top_keys = [];
  function GetKeys(ol, prefix) {
    $('> li', ol).each(
      function() {
        // if ($('> div input:checkbox', $(this)).attr('checked')) {
        //   return;
        // }
        var node_type = $('> div > select', $(this)).val();
        var node_name = $('> input.key', $(this)).val();
        if (prefix && prefix.length > 0) {
          node_name = prefix + '.' + node_name;
        }

        if ($('> div .node-loop input:checkbox', $(this)).attr('checked')) {
          node_name += ".0";
        }

        if (node_type == 'number') {
          top_keys[top_keys.length] = node_name;
        } else if (node_type == 'node') {
          GetKeys($('> ol', $(this)), node_name);
        }
      }
    );
  }

  GetKeys($('#key-list', this.dom_));

  return top_keys;
}

FeedKeyView.prototype.IsReservedKey = function(key) {
  var rsv = ['id', 'type', 'stype', 'minimerge', 'newsmerge', 'source', 'psource', 'actor', 'expr'];
  var lower_key = key.toLowerCase();
  for(var i = 0; i < rsv.length; ++i) {
    if (lower_key == rsv[i]) {
      return true;
    }
  }
  return false;
}

FeedKeyView.prototype.GetKeysXml = function(root) {
  var is_root_node = false;
  if(!root) {
    is_root_node = true;
    root = $("#key-list", this.dom_);
  }
  var T = this;
  var nodes = $("li", root);
  var i = 0;
  var xml = is_root_node ? '<key name="f" comment="root" type="node">' : '';
  var keys = $('input.key', root);
  for(var i = 0; i < keys.length; ++i) {
    var key = $(keys[i]).val();
    if (!key || key.length < 0) {
      alert('字段名不能为空');
      return '';
    }
    if (!/^[a-zA-Z][a-zA-Z0-9]*$/.test(key)) {
      alert('字段' + key + '命名不合法, 字段名必须由字母或数字组成, 且以字母开头');
      return '';
    }
  }
      
  var notes = $('input.note', root);
  for(var i = 0; i < notes.length; ++i) {
    var note = $(notes[i]).val();
    if (!note || note.length < 0) {
      alert('字段' + key + ' 描述不能为空');
      return '';
    }
  }

  nodes.each(
    function() {
      var n = $(this);
      if (!(n.parent().get(0) === root.get(0))) {
        return;
      }

      var key = $('input.key', n).val();
      var note = $('input.note', n).val();
      xml += '<key';
      if ($('> div .node-loop input:checkbox', n).attr('checked')) {
        xml += ' is_loop="1"';
      }
      var checkbox_optional =  $('> div .node-optional input:checkbox', n);
      if (checkbox_optional.css('visibility') != 'hidden' && checkbox_optional.attr('checked')) {
        xml += ' optional="1"';
      }
      xml += ' name="' + key + '"';
      xml += ' comment="' + encodeURIComponent(note) + '"';
      xml += ' type="' + $('select[name=DataType]', n).val() + '">';

      if (n.hasClass('multi')) {
        var kids = T.GetKeysXml($('ol', n));
        if (kids.length > 0) {
          xml += kids;
        }
      }
      xml += '</key>';
      ++i;
    }
  );
  if (is_root_node) {
    xml += '</key>';
  }
  return xml;
}

var TplListItem = function(view, status, view_desc, tpl_content) {
  // var view_desc = $('#add-template-view option[value="' + view + '"]').text();
  this.view_ = view;
  this.dom_ = $('<tr height="2"><td><span id="toggle-span" class="toggle-span folded"></span>' 
              + ' View类型:<span class="view-desc">' + view_desc + '</span>'
              + ' | 状态<a id="tpl-status-edit" href="#nogo">(修改)</a>:<select disabled="true" id="tpl-view-status"><option value="0">测试模板</option><option value="1">线上模板</option></select>'
              + '</td>'
              +'<td width="400"> <a href="#nogo" id="validate-template">检查ClearSilver语法</a> &nbsp; <a style="font-size:120%;font-weight:bold;" href="#nogo" id="save-template">保存</a> &nbsp; <a style="margin-left:170px;"href="#nogo" id="remove-template">删除</a> </td></tr>');
  this.tpl_ = $('<tr class="expanded-row" style="display:none;"><td colspan="2"><textarea width="80%" rows="25">' + decodeURIComponent(tpl_content) + '</textarea><ul style="margin-left:80%;padding-left:2px;list-style:circle;"><a href="http://www.clearsilver.net/docs/man_templates.hdf" target="_blank">clearsilver模板语言文档</a><br/> <br/><b>默认变量</b><li>新鲜事id : &lt?cs var:id ?&gt </li>' 
              + '<li>新鲜事小类型 : &lt?cs var:stype ?&gt </li>'
              + '<li>source值 : &lt?cs var:source ?&gt </li>'
              + '<li>在列表中的位置: &lt?cs var:feedIndex ?&gt </li>'
              + '<li>是否是newsfeed : &lt?cs var:isNewsFeed ?&gt </li>'
              + '<li>是否是自己的新鲜事 : &lt?cs var:isSelf ?&gt </li>'
              + '<li>当前用户id : &lt?cs var:userID ?&gt </li>'
              + '<li>当前用户name : &lt?cs var:userName ?&gt </li>'
              + '<li>自己点赞的次数: &lt?cs var:selfzancount ?&gt </li>'
              + '<li>所有人点赞的次数: &lt?cs var:totalzancount ?&gt </li>'
              + '<li>统计信息: &lt?cs var:vType ?&gt </li></ul>'
              + '<ul style="margin-left:80%;padding-left:2px;list-style:circle;"><b>include文件内容(utf8编码)</b>'
              + '<li><a href="/include-AVATAR.txt" target="_blank">AVATAR</a> : 头像等信息</li>' 
              + '<li><a href="/include-SOURCE.txt" target="_blank">SOURCE</a> : 新鲜事发布来源信息</li>' 
              + '<li><a href="/include-TOOLBAR.txt" target="_blank">TOOLBAR</a> : 删除/关注/忽略等按钮</li>' 
              + '<li><a href="/include-SIMILAR.txt" target="_blank">SIMILAR</a> : 查看相似新鲜事链接</li>' 
              + '<li><a href="/include-REPLY.txt" target="_blank">REPLY</a> : 新鲜事回复</li>' 
              + '</ul>'
              + '</td></tr>');
  var T = this;
  $('#toggle-span', this.dom_).click(
    function() {
      if ($(this).hasClass('folded')) {
        T.tpl_.css('display', '');
        $(this).removeClass('folded').addClass('expanded')
      } else {
        T.tpl_.css('display', 'none');
        $(this).removeClass('expanded').addClass('folded')
      }
    }
  );
  
  $('#tpl-view-status', T.dom_).val(status);
  $('#tpl-status-edit', this.dom_).click(
    function() {
      if (!confirm("该操作会影响到线上新鲜事。确定要" + $(this).html() + "吗?")) {
        return;
      }
      if ($(this).html() == '保存') {
        $.ajax('/update-tpl-view-status?tpl_id=' + g_tpl_id + '&view=' + T.view_ + '&status=' + $('#tpl-view-status', T.dom_).val(), {
          'success' : function(text){
            alert(text);
            $(this).html('修改');
            $('#tpl-view-status', T.dom_).attr('disabled', true);
          },
          'error' : function() {
            alert('保存失败');
          }
        });
      } else {
        $(this).html('保存');
        $('#tpl-view-status', T.dom_).attr('disabled', false);
      }
    }
  );

  $('#validate-template', this.dom_).click(
    function() {
      var view_type = view;
      var textarea = $('textarea', T.tpl_);
      return function() {
        var stype_id = $('#edit-tpl span.stype_id').text();
        var version = $('#edit-tpl span.stype_version').text();
        var tpl = textarea.val();
        var url = '/validate-tpl?stype=' + stype_id + '&version=' + version;
        $.ajax(url, {
          type: 'POST',
          data: 'tpl=' + encodeURIComponent(encodeURIComponent(tpl)), 
          context: document.body,
          success: function(msg){
            alert(decodeURIComponent(msg));
          },
          error: function(){
            alert('验证出错');
          }
        });
      };
    }()
  );
  $('#save-template', this.dom_).click(
    function() {
      var view_type = view;
      var textarea = $('textarea', T.tpl_);
      return function() {
        var stype_id = $('#edit-tpl span.stype_id').text();
        var version = $('#edit-tpl span.stype_version').text();
        var tpl = textarea.val();
        var url = '/save-tpl?tpl_id=' + g_tpl_id
            + '&view=' + view_type;
        // alert(textarea.val());
        $.ajax(url, {
          type: 'POST',
          data: 'tpl=' + encodeURIComponent(encodeURIComponent(tpl)), 
          context: document.body,
          success: function(msg){
            alert(msg);
          },
          error: function(){
            alert('保存出错');
          }
        });
      };
    }()
  );

  $('#remove-template', this.dom_).click(
    function() {
      var view_type = view;
      return function() {
        if (!confirm('确定删除该模板吗?')) {
          return;
        }
        var stype_id = $('#edit-tpl span.stype_id').text();
        var version = $('#edit-tpl span.stype_version').text();
        var url = '/remove-tpl?tpl_id=' + g_tpl_id + '&view=' + view_type;
        $.ajax(url, {
          context: $(this).parent().parent(),
          success: function(msg){
            alert(msg);
            $(this).remove();
            var option = $('<option value="' + view_type + '">' + $('span.view-desc', $(this)).text() + '</option>');
            $("#add-template-view").append(option);
          },
          error: function(){
            alert('删除模板失败');
          }
        });
      };
    }()
  );
}

TplListItem.prototype.AddToList = function() {
  $("#add-template-view option[value='" + this.view_ + "']").remove();

  if($('#tpl-list').length <= 0) {
    var n = $('<br/><table width="1000" id="tpl-list"></table>');
    $(document.body).append(n);
  }
  $('#tpl-list').append(this.dom_);
  $('#tpl-list').append(this.tpl_);
}
TplListItem.prototype.Readonly = function() {
  $('textarea', this.tpl_).attr('readonly', 'readonly');
  $('#remove-template, #save-template', this.dom_).css('display', 'none');
}
TplListItem.prototype.HideEditStatus = function() {
  $('#tpl-status-edit', this.dom_).hide();
}

var UserApplyView = function(apply_id) {
  this.apply_id_ = (!isNaN(apply_id) && apply_id > 0) ? apply_id : 0;
  this.dom_ = $('<div><table id="apply-table" width="1200" border="1" class="t1">' +
          '<tr>' +
            '<th colspan="2" style="font-size:20px;">新鲜事申请流程单</th>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">产品：</td>' +
            '<td width="30"><input id="pm-names" type="text"/>例：张三,李四,王五</td>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">产品Email：</td>' +
            '<td width="30">' +
                '<input id="pm-emails" size="50" type="text"/><span class="flag no-mark"></span>' +
                '例：xxx@renren-inc.com,ooo@renren-inc.com(只接受renren-inc.com域名)' +
            '</td>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">开发：</td>' +
            '<td width="30"><input id="dev-names" type="text"/>例：张三,李四,王五</td>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">开发Email：：</td>' +
            '<td width="30">' +
              '<input id="dev-emails" size="50" type="text"/><span class="flag no-mark"></span>' +
              '例：xxx@renren-inc.com,ooo@renren-inc.com(只接受renren-inc.com域名)' +
            '</td>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">申请类型：</td>' +
            '<td><select id="apply_type">' +
                '<option value="1">新建新鲜事类型</option>' +
                '<option value="2">修改新鲜事类型数据格式</option>' +
                '<option value="3">修改新鲜事类型渲染模板</option>' +
             '</td>' +
          '</tr>' +
          '<tr>' +
            '<td>新鲜事类型ID：</td>' +
            '<td colspan="3"><input size="120" type="text" id="feed_stype"/>(不确定请填0)' +
          '</tr>' +
          '<tr>' +
            '<td width="30">新鲜事描述：</td>' +
            '<td width="30"><input id="stype-desc" type="text"/> 例：用户发日志时产生的日志新鲜事, 如果有stype，请指定</td>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">申请描述：</td>' +
            '<td width="30"><textarea id="apply-desc" rows="5" cols="60"></textarea></td>' +
          '</tr>' +
          '<tr>' +
            '<td width="30">是否发NewsFeed？</td>' +
            '<td width="30"><input type="checkbox" id="PushPolicy_news"/></td>' +
          '</tr>' +
           '<tr>' +
            '<td width="30">是否发MiniFeed？</td>' +
            '<td width="30"><input id="PushPolicy_mini" type="checkbox"/></td>' +
          '</tr>' +
           '<tr>' +
             '<td width="30">NewsFeed如何合并或去重？</td>' +
             '<td width="30"><input id="news-merge-desc" size="100" type="text"/></td>' +
          '</tr>' +
           '<tr>' +
             '<td width="30">MiniFeed如何合并或去重？</td>' +
             '<td width="30"><input id="mini-merge-desc" size="100" type="text"/></td>' +
          '</tr>' +
           '<tr>' +
            '<td colspan="2" align="right"><input id="apply-submit" type="button" value="提交申请"/></td>' +
          '</tr>' +
        '</table></div>');
  var email_pat = /^([_a-z0-9.]+@renren-inc[.]com,)*[_a-z0-9.]+@renren-inc\.com$/;
  function ValidateMails(node) {
    var text = node.val();
    console.log(text);
    if(email_pat.test(text)) {
      node.next().addClass('yes-mark').removeClass('no-mark');
    } else {
      node.next().addClass('no-mark').removeClass('yes-mark');
    }
  }

  $('#pm-emails, #dev-emails', this.dom_).keyup(
    function() {
      ValidateMails($(this));
    }
  );

  $('#pm-emails, #dev-emails', this.dom_).each(
    function() {
      ValidateMails($(this));
    }
  );
  var T = this;
  if (!isNaN(apply_id) && apply_id > 0) {
    $.ajax('/get-user-apply-item?apply_id=' + apply_id, {
      'type' : 'GET',
      'async' : false,
      'success' : function(text) {
        var o = $.parseJSON(text);
        if (!o.apply_id) {
          alert('该申请id不存在');
          return;
        }
        var d = T.dom_;
        $('#pm-names', d).val(o.pm_names);
        $('#pm-emails', d).val(o.pm_emails);
        $('#dev-names', d).val(o.dev_names);
        $('#dev-emails', d).val(o.dev_emails);
        $('#feed_stype', d).val(o.feed_stype);
        $('#stype-desc', d).val(o.feed_desc);
        $('#apply-desc', d).val(o.apply_desc);
        $("input:checkbox#PushPolicy_news", d).attr("checked", o.push_news);
        $("input:checkbox#PushPolicy_mini", d).attr("checked", o.push_mini);
        $('#news-merge-desc', d).val(o.news_merge_desc);
        $('#mini-merge-desc', d).val(o.mini_merge_desc);
        $('#lifetime', d).val(o.lifetime);
      },
      'error' : function() {
        alert('加载申请信息出错');
      }
    });
  }

  $('#apply-submit', this.dom_).click(
    function() {
      if ($('#pm-names', this.dom_).val().length <= 0) {
        alert('产品名字字段不能为空');
        return;
      }
      var data = 'pm_names=' + encodeURIComponent($('#pm-names', this.dom_).val());
      if (T.apply_id_ > 0) {
        data += '&apply_id=' + T.apply_id_;
      }

      var pm_emails = $('#pm-emails', this.dom_).val();
      if (pm_emails.length <=0 || !email_pat.test(pm_emails)) {
        alert('产品email字段不合法');
        return;
      }
      data += '&pm_emails=' + pm_emails;

      if ($('#dev-names', this.dom_).val().length <= 0) {
        alert('开发名字字段不能为空');
        return;
      }
      data += '&dev_names=' + encodeURIComponent($('#dev-names', this.dom_).val());

      var dev_emails = $('#dev-emails', this.dom_).val();
      if (dev_emails.length <=0 || !email_pat.test(dev_emails)) {
        alert('开发email字段不合法');
        return;
      }
      data += '&dev_emails=' + dev_emails;

      var feed_stype = $('#feed_stype', this.dom_).val();
      if (isNaN(parseInt(feed_stype))) {
         alert('类型ID字段不合法');
         return;
      }
      data += '&feed_stype=' + feed_stype;

      var feed_desc = $('#stype-desc', this.dom_).val();
      if (feed_desc.length <= 0) {
        alert('新鲜事描述字段不能为空');
        return;
      }
      data += '&feed_desc=' + encodeURIComponent(feed_desc);

      data += '&apply_type=' + $("#apply_type", this.dom_).val();

      var apply_desc = $('#apply-desc', this.dom_).val();
      if (apply_desc.length <= 0) {
        alert('申请描述字段不能为空');
        return;
      }
      data += '&apply_desc=' + encodeURIComponent(apply_desc);

      data += '&push_news=' + ($("input:checkbox#PushPolicy_news", this.dom_).attr("checked") ? 1 : 0);
      data += '&push_mini=' + ($("input:checkbox#PushPolicy_mini", this.dom_).attr("checked") ? 1 : 0);

      var news_merge_desc = $('#news-merge-desc', this.dom_).val();
      if (news_merge_desc.length <= 0) {
        alert('NewsFeed合并策略描述不能为空');
        return;
      }
      data += '&news_merge_desc=' + encodeURIComponent(news_merge_desc);

      var mini_merge_desc = $('#mini-merge-desc', this.dom_).val();
      if (mini_merge_desc.length <= 0) {
        alert('MiniFeed合并策略描述不能为空');
        return;
      }
      data += '&mini_merge_desc=' + encodeURIComponent(mini_merge_desc);

      $.ajax('/user-apply-submit', {
        'type' : 'POST',
        'data' : data,
        'success' : function(text) {
          alert(text);
          if (T.apply_id_ <= 0) {
            window.location = '/feed-list';
          }
        },
        'error' : function() {
          alert('提交出错');
        }
      });
    }
  );
}

UserApplyView.prototype.AppendToNode = function(node) {
  node.append(this.dom_);
}

UserApplyView.prototype.Disable = function() {
  var t = $('#apply-table', this.com_);
  $('input, select, textarea, submit', t).attr('readonly', 'readonly');
  $('select', t).attr('disabled', 'true');
  $('#apply-submit', this.com_).parent().hide();
}

var SchemaParser = function() {
  var non_loop_nodes = [], loop_nodes = [];
  function GetNodePath(nodes, sep) {
    var ret = '';
    for(var i = 0; i < nodes.length; ++i) {
      if (i > 0) {
        ret += sep;
      }
      ret += nodes[i];
    }

    return ret;
  }

  function GetPathValue() {
    var value;
    if (loop_nodes.length > 0) {
      value = GetNodePath(loop_nodes, '.');
    } else {
      value = GetNodePath(non_loop_nodes, '.');
    }
    return value;
  }

  function GetFullKey(key, firstnode) {
    var prefix;
    if (loop_nodes.length > 0) {
      // prefix = 'loop.' + GetNodePath(non_loop_nodes, '_') + '.' + GetNodePath(non_loop_nodes, '_') + '_' + GetNodePath(loop_nodes, '_');
      prefix = 'loop.' + GetNodePath(non_loop_nodes, '_') + '.' + GetNodePath(loop_nodes, '_');
    } else {
      prefix = (firstnode ? firstnode : 'keys.') + GetNodePath(non_loop_nodes, '_');
    }

    return prefix + '.' + key;
  }

  var hdf_map_ = '';
  this.GetHdfMap = function() {
    return hdf_map_;
  }

  function AddHdfMap(item) {
    if (hdf_map_.length > 0) {
      hdf_map_ += ';';
    }
    hdf_map_ += item;
  }

  function DoParse(node, looping) {
    var childs = node.children();
    if (looping) {
      loop_nodes.push(node.attr("name"));
    } else {
      if (node.attr("name") != "f") {
        non_loop_nodes.push(node.attr("name"));
      }
    }
    // console.log("looping = " + looping);
    var current_looping = (node.attr("is_loop") == "1");

    if (childs.length > 0) {
      if (current_looping) {
        AddHdfMap("FeedStruct." + GetFullKey("name", "loop.") + "=" + GetPathValue());
        AddHdfMap("FeedStruct." + GetFullKey("type", "loop.") + "=node");
        AddHdfMap("FeedStruct." + GetFullKey("comment", "loop.") + "=" + node.attr("comment"));
        var opt = parseInt(node.attr("optional")) ? 'true' : 'false';
        AddHdfMap("FeedStruct." + GetFullKey("optional", "loop.") + "=" + opt);

        console.log("FeedStruct." + GetFullKey("name", "loop.") + "=" + GetPathValue());
        console.log("FeedStruct." + GetFullKey("type", "loop.") + "=" + "node");
        console.log("FeedStruct." + GetFullKey("comment", "loop.") + "=" + node.attr("comment"));
        console.log("FeedStruct." + GetFullKey("optional", "loop.") + "=" + opt);
        console.log('');
      }

      for(var i = 0; i < childs.length; ++i) {
        DoParse($(childs[i]), current_looping || looping);
      }
    } else {
      var firstnode;
      if (current_looping) {
        firstnode = "loop.";
      }
      AddHdfMap("FeedStruct." + GetFullKey("name", firstnode) + "=" + GetPathValue());
      AddHdfMap("FeedStruct." + GetFullKey("type", firstnode) + "=" + node.attr("type"));
      AddHdfMap("FeedStruct." + GetFullKey("comment", firstnode) + '=' + node.attr("comment"));
      var opt = parseInt(node.attr("optional")) ? 'true' : 'false';
      AddHdfMap("FeedStruct." + GetFullKey("optional", firstnode) + '=' + opt);

      console.log("FeedStruct." + GetFullKey("name", firstnode) + "=" + GetPathValue());
      console.log("FeedStruct." + GetFullKey("type", firstnode) + "=" + node.attr("type"));
      console.log("FeedStruct." + GetFullKey("comment", firstnode) + '=' + node.attr("comment"));
      console.log("FeedStruct." + GetFullKey("optional", firstnode) + '=' + opt);
      console.log('');
    }

    if (looping) {
      loop_nodes.pop();
    } else {
      if (node.attr("name") != "f") {
        non_loop_nodes.pop();
      }
    }
  }

  this.ParseSchema = function(stype, version, xml, custom_expr) {
    hdf_map_ = "FeedStruct.stype=" + stype + ";FeedStruct.version=" + version + ";";
    hdf_map_ += "FeedStruct.is_custom_expr=" + (custom_expr ? 'true;':'false;');
    DoParse($('<key name="f" comment="feedroot" type="node">' + xml + '</key>'));
  }
}


