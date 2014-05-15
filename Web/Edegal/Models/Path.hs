module Web.Edegal.Models.Path (Path, Slug, append) where


type Path = String
type Slug = String


append :: Path -> Slug -> Path
append "/"  slug = "/" ++ slug
append path slug = path ++ "/" ++ slug 