module MinorPlanet
    ( MinorPlanet(..)
    , Orbit(..)
    ) where

data MinorPlanet = MinorPlanet
    { designation :: String
    , magnitude   :: String
    , slope       :: String

    , epoch       :: String
    , epochAnomaly :: String

    , perihelion  :: String
    , longitude   :: String
    , inclination :: String

    , eccentricity :: String
    , motion      :: String
    , majorAxis   :: String

    , uncertainty :: String

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
    , name        :: String
    , lastObs     :: String
    } deriving (Show)

data Orbit
    = SingleOpposition Int
    | MultiOpposition (Int, Int)
      deriving (Show)
