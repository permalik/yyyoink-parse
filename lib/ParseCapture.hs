module ParseCapture where

import qualified System.Environment as Env

runParseCapture :: IO ()
runParseCapture =
  handleArgs >>= displayMessage
  where
    displayMessage parsedArgument =
      case parsedArgument of
        Left errMessage ->
          putStrLn $ "Error: " <> errMessage
        Right filename ->
          putStrLn $ "Opening file: " <> filename

handleArgs :: IO (Either String FilePath)
handleArgs =
  parseArgs <$> Env.getArgs
  where
    parseArgs argumentList =
      case argumentList of
        [fname] -> Right fname
        [] -> Left "Failed: Must input filename"
        _ -> Left "Failed: Cannot input multiple files"
