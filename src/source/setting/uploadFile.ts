import multer from 'multer'
import mimeTypes from 'mime-types'

function uploadFile() {
    const storage = multer.diskStorage({
        destination: '/home/app/build/public/uploads/',
        filename: function (__req, file, cb) {
            let nombre = file.originalname.replace(/ /g, "");
            nombre = nombre.slice(0, nombre.lastIndexOf('.'));
            let extension = mimeTypes.extension(file.mimetype);
            cb(null, `${nombre}.${extension}`);
        }
    })
    const upload = multer({ storage: storage }).single('file');

    return upload;
}

export default uploadFile();
