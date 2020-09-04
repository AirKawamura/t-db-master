import 'uppy/dist/uppy.min.css'
import Japanese from '@uppy/locales/lib/ja_JP'

import {
  Core,
  Dashboard,
  AwsS3,
} from 'uppy'

function fileUpload(fileInput) {
  const hiddenInput = document.querySelector('.upload-data'),
        formGroup = fileInput.parentNode

  // remove our file input in favour of Uppy's
  formGroup.removeChild(fileInput)

  const uppy = Core({
      autoProceed: true,
      locale: Japanese
    })
    .use(Dashboard, {
      target: '.uppy-dashboard',
      trigger: '.UppyModalOpenerBtnX',
      inline: true,
      replaceTargetContent: true,
      showProgressDetails: true,
      note: '対応形式：pdf, xls, xlsx, doc, docx (1ファイル10MBまで)',
      height: 450,
      browserBackButtonClose: true,
      proudlyDisplayPoweredByUppy: false,
      hideProgressAfterFinish: true,
      disableStatusBar: true,
      locale: {
        strings: {
          browse: '参照',
          dropPaste: 'ここにファイルをドロップするか、\n%{browse}してください',
          uploadComplete: 'アップロードする準備ができました',
        }
      },
    })
    .use(AwsS3, {
      companionUrl: '/', // will call the presign endpoint on `/s3/params`
    })

  uppy.on('upload-success', (file, response) => {
    const uploadedFileData = {
      id: file.meta['key'].match(/^cache\/(.+)/)[1], // object key without prefix
      storage: 'cache',
      metadata: {
        size: file.size,
        filename: file.name,
        mime_type: file.type,
      }
    }

    const input = hiddenInput.cloneNode(true)
    input.value = JSON.stringify(uploadedFileData)
    hiddenInput.parentNode.appendChild(input)
  })
}

export default fileUpload
