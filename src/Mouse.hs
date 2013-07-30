{-# LANGUAGE CPP, PackageImports #-}

import Control.Monad (void)

#ifdef CABAL
import qualified "threepenny-gui" Graphics.UI.Threepenny as UI
import "threepenny-gui" Graphics.UI.Threepenny.Core
#else
import qualified Graphics.UI.Threepenny as UI
import Graphics.UI.Threepenny.Core
#endif

{-----------------------------------------------------------------------------
    Main
------------------------------------------------------------------------------}
main :: IO ()
main = do
    startGUI Config
        { tpPort       = 10000
        , tpCustomHTML = Nothing
        , tpStatic     = ""
        } setup

setup :: Window -> IO ()
setup w = do
    return w # set title "Mouse"
    
    out  <- UI.span # set text "Coordinates: "
    wrap <- UI.div #. "wrap"
        # set style [("width","300px"),("height","300px"),("border","solid black 1px")]
        #+ [element out]
    getBody w #+ [element wrap]
    
    on UI.mousemove wrap $ \xy -> void $ do
        element out # set text ("Coordinates: " ++ show xy)
