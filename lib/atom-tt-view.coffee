{View} = require 'space-pen'
{TextEditorView} = require 'atom-space-pen-views'

module.exports =
class MyView extends View
  @content: ->
    @raw """
    <div class='block bordered'>
        <atom-text-editor gutter-hidden class="source-lang">
          Quick overview tab of open files. Similar to Mac OSX expose / mission control, Group, tab, Firefox, Safari and Chrome the browse tab, etc.
          Shows the active tab, the panel and preview.
          Text editor preview taken from the Minimap, if present, otherwise any icon file is used.
          Shows file icons in tabs if the file has an icon pack installed.
        </atom-text-editor>
        <div class="block controls-wrapper">
          <div class='block controls'>
            <div class='select-list popover-list inline-block lang-from'>
                <atom-text-editor mini>English</atom-text-editor>
                <ol class='list-group' style="display:none;">
                    <li class='selected'>one</li>
                    <li>two</li>
                    <li>three</li>
                </ol>
            </div>
            <button class='inline-block btn btn-lg icon icon-sync lang-switch' style=""></button>
            <div class='select-list popover-list inline-block lang-to'>
                <atom-text-editor mini>Russian</atom-text-editor>
                <ol class='list-group' style="display:none;">
                    <li class='selected'>one</li>
                    <li>two</li>
                    <li>three</li>
                </ol>
            </div>
            <button class='inline-block btn btn-lg translate'>Translate</button>
          </div>
        </div>
        <div class="example">
            Быстрая вкладка обзор открытых файлов. Похожие на Mac OSX с разоблачением / управления полетами, Группа вкладке Firefox, Safari и Chrome вкладку обзор и др.
            Показывает активные вкладки, панели и превью.
            Текстовый редактор предварительного просмотра взяты из Миникарте, если они присутствуют, иначе любой значок файла используется.
            Показывает значки файлов во вкладках, если файл-значок пакет установлен.
        </div>
    </div>
   """
