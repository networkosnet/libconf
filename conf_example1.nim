import conf/defs
import tables

# Link suite

let linkCommands = SuiteDef(commands: @[
  ("name", singleValueArgDef(help="rename after link creation").valueThunk)
])

# Main suite

proc linkCmd(): ArgsDef

let mainCommands = SuiteDef(commands: @[
  ("namespace", singleValueArgDef(help="move to network namespace after link creation").valueThunk),
  ("link", linkCmd.funcThunk)
])

proc linkMatchDevCmd(): ArgsDef =
  @[valueArgDef(name="name", valueType=vtString)]

let linkMatchCommands = SuiteDef(commands: @[
  ("dev", linkMatchDevCmd.funcThunk),
])

proc linkCmd(): ArgsDef =
  @[suiteArgDef(name="link-type",
                suiteDef=linkMatchCommands.valueThunk,
                isCommand=true),
   suiteArgDef(name="body",
               suiteDef=linkCommands.valueThunk)]