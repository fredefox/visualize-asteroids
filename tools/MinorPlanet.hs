module MinorPlanet
    ( MinorPlanet(..)
    , Orbit(..)
    ) where

data MinorPlanet = MinorPlanet
    { designation :: String
    , magnitude   :: Float
    , slope       :: Float

    , epoch       :: String
    , epochAnomaly :: Float

    , perihelion  :: Float
    , longitude   :: Float
    , inclination :: Float

    , eccentricity :: Float
    , motion      :: Float
    , majorAxis   :: Float

    , uncertainty :: String -- TODO: Should be wrapped in a data-type

    , reference   :: String
    , observations :: Int
    , oppositions  :: Int

    -- Here the documentation alludes to there being two different cases
    -- multiple- and single-opposition orbits respectively.
    , orbit       :: Orbit
    , rmsResidual :: Float
    , perturb     :: (Maybe String, Maybe String)
    , computer    :: String

    -- Not sure what this means
    , other       :: String

    -- Called "readable designation"
    , name        :: String -- TODO: Name concist of two parts, wrap this
    , lastObs     :: String -- TODO: This is a date-type
    } deriving (Show)

data Orbit
    = SingleOpposition Int
    | MultiOpposition (Int, Int)
      deriving (Show)
