module ParseCapture where

import qualified System.Environment as Env

runParseCapture :: IO ()
runParseCapture = handleArgs >>= print

handleArgs :: IO FilePath
handleArgs = head <$> Env.getArgs
