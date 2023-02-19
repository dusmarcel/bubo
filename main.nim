import gintro/[gtk4, glib, gobject, gio]

const menuData = """
<interface>
  <menu id="menuModel">
    <section>
      <item>
        <attribute name="label">_Quit</attribute>
        <attribute name="action">app.quit</attribute>
      </item>
    </section>
  </menu>
</interface>"""

proc cbQuit(action: gio.SimpleAction; parameter: glib.Variant; app: gtk4.Application) =
  echo ("Quit!")
  app.quit()

proc activate(app: gtk4.Application) =
  let
    window = newApplicationWindow(app)
    header = newHeaderBar()
    menubutton = newMenuButton()
    builder = newBuilderFromString(menuData)
    menuModel : gio.MenuModel = builder.getMenuModel("menuModel")
    menu = newPopoverMenu(menuModel)
    actionGroup: gio.SimpleActionGroup = newSimpleActionGroup()
    notebook = newNoteBook()
    label = newLabel("Server")
    sw = newScrolledWindow()
    view = newTextView()

  var action = newSimpleAction("quit")
  discard action.connect("activate", cbQuit, app)
  setAccelsForAction(app, "app.quit", "<Control>Q")
  actionGroup.addAction(action)

  menuButton.setPopover(menu)
  menuButton.setIconName("open-menu-symbolic")
  header.packEnd(menuButton)

  window.setTitle("bubo")
  window.setTitlebar(header)
  sw.setChild(view)
  discard notebook.appendPage(sw, label)
  window.setChild(notebook)
  window.insertActionGroup("app", actionGroup)
  window.show

proc main () =
  let app = newApplication("org.keienb.bubo")
  app.connect("activate", activate)
  let status = app.run
  quit(status)

main()