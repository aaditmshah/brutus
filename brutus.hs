import System.IO (hSetEcho, hSetBuffering, stdout, stdin, BufferMode(NoBuffering, LineBuffering))
import Data.Map.Strict (fromAscList, findWithDefault)
import System.Environment (getArgs, getProgName)
import System.IO.Error (catchIOError)
import System.Exit (exitSuccess)

type Zipper a = ([a], [a])

zipper :: [a] -> Zipper a
zipper xs = (xs, [])

next :: Zipper a -> Zipper a
next (x:[], xs) = (x:[], xs)
next (x:xs, ys) = (xs, x:ys)

back :: Zipper a -> Zipper a
back (xs, [])   = (xs, [])
back (xs, y:ys) = (y:xs, ys)

cipher :: String -> Int -> String -> String
cipher alphabet shift = map $ \c -> findWithDefault c c alphamap
    where alphamap = fromAscList . zip alphabet $ bs ++ as
          (as, bs) = splitAt shift alphabet

bold :: String -> String
bold text = "\ESC[1m" ++ text ++ "\ESC[0m"

usage :: IO ()
usage = do
    progName <- getProgName
    putStrLn $ "Usage: " ++ bold progName ++ " " ++
        bold "alphabetic" ++ "|" ++ bold "alphanumeric" ++ "|" ++ bold "ascii"

main = getArgs >>= force

force :: [String] -> IO ()
force ["alphabetic"]   = prompt $ ['A'..'Z'] ++ ['a'..'z']
force ["alphanumeric"] = prompt $ ['0'..'9'] ++ ['A'..'Z'] ++ ['a'..'z']
force ["ascii"]        = prompt $ ['!'..'~']
force _                = usage

interactIO :: (String -> IO a) -> IO ()
interactIO f = do
    getLine `catchIOError` (const exitSuccess) >>= f
    interactIO f

prompt :: String -> IO ()
prompt alphabet = hSetBuffering stdout NoBuffering >> interactIO (search $ zipper ciphers)
    where ciphers = map (cipher alphabet) [size-1,size-2..1]
          size = length alphabet

getch :: IO Char
getch = do
    hSetEcho stdout False
    hSetBuffering stdin NoBuffering
    char <- getChar
    hSetBuffering stdin LineBuffering
    hSetEcho stdout True
    return char

search :: Zipper (String -> String) -> String -> IO ()
search zipper line = do
    putStr $ head (fst zipper) line
    char <- getch
    case char of
        '\EOT' -> putStrLn ""
        'f'    -> putStr "\ESC[1G" >> search (back zipper) line
        'j'    -> putStr "\ESC[1G" >> search (next zipper) line
        _      -> putStr "\ESC[1G" >> search zipper line