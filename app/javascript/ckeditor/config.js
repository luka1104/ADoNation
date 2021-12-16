
CKEDITOR.editorConfig = function (config) {
  config.toolbar_mini = [
    {
      name: 'paragraph',
      groups: ['list', 'indent', 'blocks', 'align', 'bidi'],
      items: [
        'NumberedList', 'BulletedList',
        '-',
        'Outdent', 'Indent',
        '-',
        'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'
      ]
    },
    {
      name: 'links',
      items: [
        'Link', 'Unlink'
      ]
    },
    {
      name: 'basicstyles',
      groups: ['basicstyles', 'cleanup'],
      items: [
        'Bold', 'Italic', 'Underline', 'Strike', 'Subscript', 'Superscript',
        '-',
        'RemoveFormat'
      ]
    },
    {
      name: 'insert',
      items: [
        'Image', 'Table', 'HorizontalRule'
      ]
    }
  ];

  // toolbar_mini が読み込まれる
  config.toolbar = "mini";

  // 高さを指定
  config.height = '1000px';
};