module Web.Edegal.Models.Path (Path, Slug, append, mkSlug) where


type Path = String
type Slug = String


append :: Path -> Slug -> Path
append "/"  slug = "/" ++ slug
append path slug = path ++ "/" ++ slug


mkSlug :: String -> Slug
mkSlug originalFileName = undefined