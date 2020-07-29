workflow "Release Notifier" {
  on = "release"
  resolves = ["Notify Releases"]
}

action "Notify Releases" {
  uses = "bitoiu/release-notify-action@master"
  secrets = ["SENDGRID_API_TOKEN", "RECIPIENTS"]
}
