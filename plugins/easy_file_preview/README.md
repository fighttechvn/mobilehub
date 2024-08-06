# Easy preview files
- Supported:
  - [x] pdf
  - [x] mp4
  - [x] doc, docx

## PDF 

```
  const SizedBox(
    height: 200,
    child: MediaPreviewWidget(
      type: '.pdf',
      url: 'https://pdfkit.org/docs/guide.pdf',
      title: 'View PDF',
      pdfFullScreen: true,
    ),
```
