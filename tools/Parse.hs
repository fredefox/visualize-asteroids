import MinorPlanet hiding (orbit, perturb)
import qualified MinorPlanet

import Control.Applicative ((<*))
import Control.Monad (forM, replicateM)

import Text.Parsec hiding (token)
import Text.ParserCombinators.Parsec hiding (try, token)

import Data.Either

chars :: Int -> Parser String
chars i = replicateM i anyChar

orbit :: Parser Orbit
orbit = single <|> multi where
    single :: Parser Orbit
    single = do
        f <- chars 4
        anyChar -- char '-'
        t <- chars 4
        return $ MultiOpposition (read f, read t)
    multi  :: Parser Orbit
    multi  = do
        len <- chars 4
        chars 4 --string "days"
        return $ SingleOpposition $ read len

perturb :: Parser (Maybe String, Maybe String)
perturb = do
    coarse <- chars 3
    anyChar
    fine <- chars 3
    return (Just coarse, Just fine)

minorPlanet :: Parser MinorPlanet
minorPlanet = do
    designation <- chars 7
    sp
    magnitude <- fmap read $ chars 5
    sp
    slope <- fmap read $ chars 5
    sp
    epoch <- chars 5
    sp
    epochAnomaly <- fmap read $ chars 9
    sp
    perihelion <- fmap read $ chars 10
    sp
    longitude <- fmap read $ chars 10
    sp
    inclination <- fmap read $ chars 11
    sp
    eccentricity <- fmap read $ chars 9
    sp
    motion <- fmap read $ chars 11
    sp
    majorAxis <- fmap read $ chars 11
    sp
    uncertainty <- chars 2
    sp
    reference <- chars 9
    sp
    observations <- fmap read $ chars 5
    sp
    oppositions <- fmap read $ chars 3
    sp
    orbit <- orbit
    sp
    rmsResidual <- fmap read $ chars 4
    sp
    perturb <- perturb
    sp
    computer <- chars 10
    sp
    other <- chars 4
    sp
    name <- chars 28
    lastObs <- chars 8
    --sp
    return $ MinorPlanet
        { designation = designation
        , magnitude = magnitude
        , slope = slope
        , epoch = epoch
        , epochAnomaly = epochAnomaly
        , perihelion = perihelion
        , longitude = longitude
        , inclination = inclination
        , eccentricity = eccentricity
        , motion = motion
        , majorAxis = majorAxis
        , uncertainty = uncertainty
        , reference = reference
        , observations = observations
        , oppositions = oppositions
        , MinorPlanet.orbit = orbit
        , rmsResidual = rmsResidual
        , MinorPlanet.perturb = perturb
        , computer = computer
        , other = other
        , name = name
        , lastObs = lastObs
        } where
    sp = anyChar

parseMp :: String -> Either ParseError MinorPlanet
parseMp = parse minorPlanet "Minor Planet"

testLine = "00025    7.83  0.15 K156R 162.04401   90.07935  214.21057   21.58878  0.2553056  0.26510854   2.3998655  0 MPO332812  2245  66 1860-2015 0.57 M-v 38h MPCLINUX   0000     (25) Phocaea            20150311"

main = do
    inp <- readFile "../data/meteors"
    let mp   = map parseMp (lines inp)
        mp'  = filter (null . lefts . return) mp
        mp'' = map (\(Right x) -> x) mp'
    return mp
