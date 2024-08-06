abstract class DownloadStatus{
  const DownloadStatus();
}
class DownloadInitial extends DownloadStatus{
  const DownloadInitial();
}
class DownloadFailStatus extends DownloadStatus{
  DownloadFailStatus();
}
class DownloadingStatus extends DownloadStatus{}
class DownloadCompleteStatus extends DownloadStatus{
  final String fileName;
  DownloadCompleteStatus(this.fileName);
}
class DownloadCancelStatus extends DownloadStatus{
  final String error;
  DownloadCancelStatus(this.error);
}