##################### cdn-watch-aetnd-com-s3 #######################
output "cdn-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.cdn-watch-aetnd-com-s3.s3_bucket_id,
      module.cdn-watch-aetnd-com-s3.s3_bucket_arn,
      module.cdn-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### design-prod-watchae-s3 #######################
output "design-prod-watchae-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.design-prod-watchae-s3.s3_bucket_id,
      module.design-prod-watchae-s3.s3_bucket_arn,
      module.design-prod-watchae-s3.s3_bucket_region
    ]
  )
}

##################### dev-assets-watch-aetnd-com-s3 #######################
output "dev-assets-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-assets-watch-aetnd-com-s3.s3_bucket_id,
      module.dev-assets-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev-assets-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-cdn-history-com-s3 #######################
output "dev-cdn-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-cdn-history-com-s3.s3_bucket_id,
      module.dev-cdn-history-com-s3.s3_bucket_arn,
      module.dev-cdn-history-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-cdn-roots-history-com-s3 #######################
output "dev-cdn-roots-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-cdn-roots-history-com-s3.s3_bucket_id,
      module.dev-cdn-roots-history-com-s3.s3_bucket_arn,
      module.dev-cdn-roots-history-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-cdn-watch-aetnd-com-s3 #######################
output "dev-cdn-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-cdn-watch-aetnd-com-s3.s3_bucket_id,
      module.dev-cdn-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev-cdn-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-configs-watch-aetnd-com-s3 #######################
output "dev-configs-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-configs-watch-aetnd-com-s3.s3_bucket_id,
      module.dev-configs-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev-configs-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-editorials-watch-aetnd-com-s3 #######################
output "dev-editorials-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-editorials-watch-aetnd-com-s3.s3_bucket_id,
      module.dev-editorials-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev-editorials-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-lifetimelive-com-s3 #######################
output "dev-lifetimelive-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-lifetimelive-com-s3.s3_bucket_id,
      module.dev-lifetimelive-com-s3.s3_bucket_arn,
      module.dev-lifetimelive-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-mplclicense-history-com-s3 #######################
output "dev-mplclicense-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-mplclicense-history-com-s3.s3_bucket_id,
      module.dev-mplclicense-history-com-s3.s3_bucket_arn,
      module.dev-mplclicense-history-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-player-watch-aetnd-com-s3 #######################
output "dev-player-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-player-watch-aetnd-com-s3.s3_bucket_id,
      module.dev-player-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev-player-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### dev-wp-watch-aetnd-com-s3 #######################
output "dev-wp-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev-wp-watch-aetnd-com-s3.s3_bucket_id,
      module.dev-wp-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev-wp-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### dev_cdn-watch-aetnd-com-s3 #######################
output "dev_cdn-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.dev_cdn-watch-aetnd-com-s3.s3_bucket_id,
      module.dev_cdn-watch-aetnd-com-s3.s3_bucket_arn,
      module.dev_cdn-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### images-history-com-s3 #######################
output "images-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.images-history-com-s3.s3_bucket_id,
      module.images-history-com-s3.s3_bucket_arn,
      module.images-history-com-s3.s3_bucket_region
    ]
  )
}

##################### pdk-watch-aetnd-com-s3 #######################
output "pdk-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.pdk-watch-aetnd-com-s3.s3_bucket_id,
      module.pdk-watch-aetnd-com-s3.s3_bucket_arn,
      module.pdk-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-assets-watch-aetnd-com-s3 #######################
output "prod-assets-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-assets-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-assets-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-assets-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-cdn-history-com-s3 #######################
output "prod-cdn-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-cdn-history-com-s3.s3_bucket_id,
      module.prod-cdn-history-com-s3.s3_bucket_arn,
      module.prod-cdn-history-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-cdn-live-aenetworks-com-s3 #######################
output "prod-cdn-live-aenetworks-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-cdn-live-aenetworks-com-s3.s3_bucket_id,
      module.prod-cdn-live-aenetworks-com-s3.s3_bucket_arn,
      module.prod-cdn-live-aenetworks-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-cdn-live-aetnd-com-s3 #######################
output "prod-cdn-live-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-cdn-live-aetnd-com-s3.s3_bucket_id,
      module.prod-cdn-live-aetnd-com-s3.s3_bucket_arn,
      module.prod-cdn-live-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-cdn-roots-history-com-s3 #######################
output "prod-cdn-roots-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-cdn-roots-history-com-s3.s3_bucket_id,
      module.prod-cdn-roots-history-com-s3.s3_bucket_arn,
      module.prod-cdn-roots-history-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-cdn-watch-aetnd-com-s3 #######################
output "prod-cdn-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-cdn-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-cdn-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-cdn-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-configs-watch-aetnd-com-s3 #######################
output "prod-configs-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-configs-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-configs-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-configs-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-editorials-watch-aetnd-com-s3 #######################
output "prod-editorials-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-editorials-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-editorials-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-editorials-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-emailupdates-watch-aetnd-com-s3 #######################
output "prod-emailupdates-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-emailupdates-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-emailupdates-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-emailupdates-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-lifetimelive-com-s3 #######################
output "prod-lifetimelive-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-lifetimelive-com-s3.s3_bucket_id,
      module.prod-lifetimelive-com-s3.s3_bucket_arn,
      module.prod-lifetimelive-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-maintenance-aetnd-com-s3 #######################
output "prod-maintenance-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-maintenance-aetnd-com-s3.s3_bucket_id,
      module.prod-maintenance-aetnd-com-s3.s3_bucket_arn,
      module.prod-maintenance-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-mplclicense-history-com-s3 #######################
output "prod-mplclicense-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-mplclicense-history-com-s3.s3_bucket_id,
      module.prod-mplclicense-history-com-s3.s3_bucket_arn,
      module.prod-mplclicense-history-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-player-watch-aetnd-com-s3 #######################
output "prod-player-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-player-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-player-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-player-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### prod-wp-watch-aetnd-com-s3 #######################
output "prod-wp-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.prod-wp-watch-aetnd-com-s3.s3_bucket_id,
      module.prod-wp-watch-aetnd-com-s3.s3_bucket_arn,
      module.prod-wp-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-assets-watch-aetnd-com-s3 #######################
output "qa-assets-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-assets-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-assets-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-assets-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-cdn-history-com-s3 #######################
output "qa-cdn-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-cdn-history-com-s3.s3_bucket_id,
      module.qa-cdn-history-com-s3.s3_bucket_arn,
      module.qa-cdn-history-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-cdn-live-aenetworks-com-s3 #######################
output "qa-cdn-live-aenetworks-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-cdn-live-aenetworks-com-s3.s3_bucket_id,
      module.qa-cdn-live-aenetworks-com-s3.s3_bucket_arn,
      module.qa-cdn-live-aenetworks-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-cdn-live-aetnd-com-s3 #######################
output "qa-cdn-live-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-cdn-live-aetnd-com-s3.s3_bucket_id,
      module.qa-cdn-live-aetnd-com-s3.s3_bucket_arn,
      module.qa-cdn-live-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-cdn-roots-history-com-s3 #######################
output "qa-cdn-roots-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-cdn-roots-history-com-s3.s3_bucket_id,
      module.qa-cdn-roots-history-com-s3.s3_bucket_arn,
      module.qa-cdn-roots-history-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-cdn-watch-aetnd-com-s3 #######################
output "qa-cdn-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-cdn-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-cdn-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-cdn-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-configs-watch-aetnd-com-s3 #######################
output "qa-configs-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-configs-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-configs-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-configs-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-editorials-watch-aetnd-com-s3 #######################
output "qa-editorials-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-editorials-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-editorials-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-editorials-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-emailupdates-watch-aetnd-com-s3 #######################
output "qa-emailupdates-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-emailupdates-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-emailupdates-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-emailupdates-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-lifetimelive-com-s3 #######################
output "qa-lifetimelive-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-lifetimelive-com-s3.s3_bucket_id,
      module.qa-lifetimelive-com-s3.s3_bucket_arn,
      module.qa-lifetimelive-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-mplclicense-history-com-s3 #######################
output "qa-mplclicense-history-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-mplclicense-history-com-s3.s3_bucket_id,
      module.qa-mplclicense-history-com-s3.s3_bucket_arn,
      module.qa-mplclicense-history-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-player-watch-aetnd-com-s3 #######################
output "qa-player-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-player-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-player-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-player-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa-wp-watch-aetnd-com-s3 #######################
output "qa-wp-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa-wp-watch-aetnd-com-s3.s3_bucket_id,
      module.qa-wp-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa-wp-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### qa_cdn-watch-aetnd-com-s3 #######################
output "qa_cdn-watch-aetnd-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.qa_cdn-watch-aetnd-com-s3.s3_bucket_id,
      module.qa_cdn-watch-aetnd-com-s3.s3_bucket_arn,
      module.qa_cdn-watch-aetnd-com-s3.s3_bucket_region
    ]
  )
}

##################### s3-aetv-com-s3 #######################
output "s3-aetv-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.s3-aetv-com-s3.s3_bucket_id,
      module.s3-aetv-com-s3.s3_bucket_arn,
      module.s3-aetv-com-s3.s3_bucket_region
    ]
  )
}

##################### s3-games-mylifetime-com-s3 #######################
output "s3-games-mylifetime-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.s3-games-mylifetime-com-s3.s3_bucket_id,
      module.s3-games-mylifetime-com-s3.s3_bucket_arn,
      module.s3-games-mylifetime-com-s3.s3_bucket_region
    ]
  )
}

##################### s3-mylifetime-com-s3 #######################
output "s3-mylifetime-com-s3" {
  value = zipmap(
    ["name", "arn", "region"], [
      module.s3-mylifetime-com-s3.s3_bucket_id,
      module.s3-mylifetime-com-s3.s3_bucket_arn,
      module.s3-mylifetime-com-s3.s3_bucket_region
    ]
  )
}