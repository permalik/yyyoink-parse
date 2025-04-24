module ParseCapture where

import qualified System.Environment as Env

runParseCapture :: IO ()
runParseCapture =
  handleArgs
    >>= \fnameOrError ->
      case fnameOrError of
        Left err ->
          putStrLn $ "Error processing: " <> err
        Right fname ->
          readFile fname >>= putStrLn

handleArgs :: IO (Either String FilePath)
handleArgs =
  parseArgs <$> Env.getArgs
  where
    parseArgs argumentList =
      case argumentList of
        [fname] -> Right fname
        [] -> Left "Failed: Must input filename"
        _ -> Left "Failed: Cannot input multiple files"
