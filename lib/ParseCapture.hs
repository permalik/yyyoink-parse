module ParseCapture where

import qualified Control.Exception as Exception
import qualified System.Environment as Env
import qualified System.IO.Error as IOError

runParseCapture :: IO ()
runParseCapture =
  Exception.catch
    ( handleArgs
        >>= \arg ->
          case arg of
            Left err ->
              putStrLn $ "Error processing: " <> err
            Right fname ->
              readFile fname >>= putStrLn
    )
    handleErr
  where
    handleErr :: IOError -> IO ()
    handleErr e = putStrLn "An error occurred: " >> print e

handleArgs :: IO (Either String FilePath)
handleArgs =
  parseArgs <$> Env.getArgs
  where
    parseArgs argumentList =
      case argumentList of
        [fname] -> Right fname
        [] -> Left "Failed: Must input filename"
        _ -> Left "Failed: Cannot input multiple files"

eitherToErr :: (Show a) => Either a b -> IO b
eitherToErr (Right a) = return a
eitherToErr (Left e) =
  Exception.throwIO . IOError.userError $ show e
