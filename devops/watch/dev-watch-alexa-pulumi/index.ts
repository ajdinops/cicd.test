import * as pulumi from "@pulumi/pulumi";
import * as aws from "@pulumi/aws";
import * as pagerduty from "@pulumi/pagerduty";
import * as datadog from "@pulumi/datadog";
import { CreateUltraDNS } from "./ultradns/index";

// UltraDNS Record
const cnameDevAlexaWatchAetndCom = CreateUltraDNS("cname-dev-alexa-watch-aetnd-com", {
    zone: "aetnd.com",
    name: "dev-alexa.watch.aetnd.com.",
    type: "CNAME",
    ttl: 86400,
    rdata: ["http2.aenet.map.fastly.net."],
});

// PagerDuty Escalation Policy
const devWatchAlexaEscalationPolicy = new pagerduty.EscalationPolicy("dev-watch-alexa-escalation-policy", {
    name: "dev-watch-alexa-escalation-policy",
    numLoops: 3,
    rules: [{
        escalationDelayInMinutes: 15,
        targets: [{
            id: pulumi.output(pagerduty.getUser({ email: "devops@aenetworks.com" })).id,
            type: "user_reference",
        }],
    }],
});

// PagerDuty Service
const devWatchAlexaService = new pagerduty.Service("dev-watch-alexa-service", {
    name: "dev-watch-alexa-service",
    escalationPolicy: devWatchAlexaEscalationPolicy.id,
    alertCreation: "create_alerts_and_incidents",
    incidentUrgencyRule: {
        type: "constant",
        urgency: "low",
    },
});

// PagerDuty Service Integration (CloudWatch)
const devWatchAlexaIntegrationCloudWatch = new pagerduty.ServiceIntegration("dev-watch-alexa-integration-cloudwatch", {
    name: "CloudWatch Integration",
    service: devWatchAlexaService.id,
    vendor: pulumi.output(pagerduty.getVendor({ name: "CloudWatch" })).id,
});

// PagerDuty Service Integration (Datadog)
const devWatchAlexaIntegrationDatadog = new pagerduty.ServiceIntegration("dev-watch-alexa-integration-datadog", {
    name: "Datadog Integration",
    service: devWatchAlexaService.id,
    vendor: pulumi.output(pagerduty.getVendor({ name: "Datadog" })).id,
});

// Datadog Integration with PagerDuty
const devWatchAlexaDatadogIntegration = new datadog.pagerduty.ServiceObject("dev-watch-alexa-service", {
    serviceName: devWatchAlexaService.name,
    serviceKey: devWatchAlexaIntegrationDatadog.integrationKey,
});

// CloudFormation Stack: dev-watch-alexa-alert
const devWatchAlexaAlert = new aws.cloudformation.Stack("dev-watch-alexa-alert", {
    name: "dev-watch-alexa-alert",
    capabilities: ["CAPABILITY_IAM"],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/alert.yaml", "utf-8")),
    parameters: {
        Email: "",
        HttpEndpoint: "",
        HttpsEndpoint: pulumi.interpolate`https://events.pagerduty.com/integration/${devWatchAlexaIntegrationCloudWatch.integrationKey}/enqueue`,
        FallbackEmail: "DevSecOps@aenetworks.com",
    },
    tags: {
        Name: "dev-watch-alexa-alert",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});

// CloudFormation Stack: dev-watch-alexa-ecr
const devWatchAlexaEcr = new aws.cloudformation.Stack("dev-watch-alexa-ecr", {
    name: "dev-watch-alexa-ecr",
    capabilities: ["CAPABILITY_IAM"],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/ecr-private-repository.yaml", "utf-8")),
    parameters: {
        ParentKmsKeyStack: "",
    },
    tags: {
        Name: "dev-watch-alexa-ecr",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:application": "watch-alexa",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});

// CloudFormation Stack: dev-watch-alexa-sg
const devWatchAlexaSg = new aws.cloudformation.Stack("dev-watch-alexa-sg", {
    name: "dev-watch-alexa-sg",
    capabilities: [],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/sg.yaml", "utf-8")),
    parameters: {
        ParentVPCStack: "vpc-prod",
    },
    tags: {
        Name: "dev-watch-alexa-sg",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:application": "watch-alexa",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});

// CloudFormation Stack: dev-watch-alexa-iam
const devWatchAlexaIam = new aws.cloudformation.Stack("dev-watch-alexa-iam", {
    name: "dev-watch-alexa-iam",
    capabilities: ["CAPABILITY_IAM"],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/iam-watch-alexa.yaml", "utf-8")),
    parameters: {
        Environment: "dev",
    },
    tags: {
        Name: "dev-watch-alexa-iam",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:application": "watch-alexa",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});

// CloudFormation Stack: dev-watch-alexa-cache-1
const devWatchAlexaCache1 = new aws.cloudformation.Stack("dev-watch-alexa-cache-1", {
    name: "dev-watch-alexa-cache-1",
    capabilities: ["CAPABILITY_IAM"],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/elasticache-memcached.yaml", "utf-8")),
    parameters: {
        ParentVPCStack: "vpc-prod",
        ParentZoneStack: "zone-aetnd-io",
        ParentSSHBastionStack: "",
        ParentAlertStack: devWatchAlexaAlert.outputs["StackName"],
        ParentClientStack1: "sg-dev",
        ParentClientStack2: "",
        ParentClientStack3: "",
        EngineVersion: "1.6.17",
        CacheNodeType: "cache.t4g.micro",
        NumCacheNodes: "1",
        SubDomainNameWithDot: "dev-watch-alexa-cache.",
        DNSRecordWeight: "50",
        SubnetsReach: "Private",
        CPUUtilizationAlarmThreshold: "90",
        CPUUtilizationAlarmPeriod: "60",
        CPUUtilizationAlarmEvaluationPeriods: "5",
        SwapUsageAlarmThreshold: "268435456",
        SwapUsageAlarmPeriod: "60",
        SwapUsageAlarmEvaluationPeriods: "5",
        EvictionsAlarmThreshold: "1000",
        EvictionsAlarmPeriod: "60",
        EvictionsAlarmEvaluationPeriods: "5",
        LogsRetentionInDays: "1",
        PermissionsBoundary: "",
    },
    tags: {
        Name: "dev-watch-alexa-cache-1",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:application": "watch-alexa",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});

// CloudFormation Stack: dev-watch-alexa-service
const devWatchAlexaServiceStack = new aws.cloudformation.Stack("dev-watch-alexa-service", {
    name: "dev-watch-alexa-service",
    capabilities: ["CAPABILITY_IAM"],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/fargate-service-alb.yaml", "utf-8")),
    parameters: {
        ParentVPCStack: "vpc-prod",
        ParentClusterStack: "dev-watch-cluster",
        ParentECRRepositoryStack: devWatchAlexaEcr.outputs["StackName"],
        ParentAlertStack: devWatchAlexaAlert.outputs["StackName"],
        ParentZoneStack: "",
        ParentClientStack1: devWatchAlexaSg.outputs["StackName"],
        ParentClientStack2: "sg-dev",
        ParentClientStack3: "",
        LoadBalancerPriority: "20",
        LoadBalancerHostPattern: "dev-alexa.watch.aetnd.com",
        LoadBalancerPathPattern: "/*",
        LoadBalancerDeregistrationDelay: "60",
        LoadBalancerStickiness: "false",
        TaskPolicies: devWatchAlexaIam.outputs["PolicyArn"],
        ProxyImage: "",
        ProxyCommand: "",
        ProxyPort: "8000",
        ProxyEnvironment1Key: "",
        ProxyEnvironment1Value: "",
        ProxyEnvironment2Key: "",
        ProxyEnvironment2Value: "",
        ProxyEnvironment3Key: "",
        ProxyEnvironment3Value: "",
        AppCommand: "",
        AppUser: "",
        AppPort: "4000",
        AppEnvironment1Key: "AETN_ENV",
        AppEnvironment1Value: "dev",
        AppEnvironment2Key: "",
        AppEnvironment2Value: "",
        AppEnvironment3Key: "",
        AppEnvironment3Value: "",
        AppLogDriver: "awsfirelens",
        SidecarImage: "",
        SidecarRepositoryCredentials: "/dockerhub/mirror",
        SidecarCommand: "",
        SidecarPort: "9000",
        SidecarEnvironment1Key: "",
        SidecarEnvironment1Value: "",
        SidecarEnvironment2Key: "",
        SidecarEnvironment2Value: "",
        SidecarEnvironment3Key: "",
        SidecarEnvironment3Value: "",
        EnableWiz: "true",
        WizApiClientSecret: "/wizio-sensor/aetnd_ecs_dev",
        EnableFireLens: "true",
        FluentBitConfigFile: "/fluent-bit/configs/parse-json.conf",
        EnableDatadogAgent: "true",
        DatadogApiKeySecret: "/datadog/aetnd_ecs_dev",
        DatadogAgentDDSource: "aetn_nodejs",
        SubDomainNameWithDot: "",
        DNSRecordWeight: "50",
        Cpu: "1",
        Memory: "8",
        EphemeralStorage: "21",
        CpuArchitecture: "X86_64",
        SubnetsReach: "Private",
        AutoScaling: "false",
        DesiredCount: "1",
        MaxCapacity: "1",
        MinCapacity: "1",
        HealthCheckPath: "/aetn-heartbeat.html",
        HealthCheckGracePeriod: "60",
        LogsRetentionInDays: "1",
        ScaleUpPolicyCooldown: "120",
        ScaleUpPolicyScalingAdjustment: "25",
        ScaleDownPolicyCooldown: "300",
        ScaleDownPolicyScalingAdjustment: "-25",
        AutoScalingCPUHighAlarmThreshold: "60",
        AutoScalingCPUHighAlarmPeriod: "60",
        AutoScalingCPUHighAlarmEvaluationPeriods: "1",
        AutoScalingCPULowAlarmThreshold: "30",
        AutoScalingCPULowAlarmPeriod: "300",
        AutoScalingCPULowAlarmEvaluationPeriods: "3",
        HTTPCodeTarget5XXTooHighAlarmThreshold: "100",
        HTTPCodeTarget5XXTooHighAlarmPeriod: "60",
        HTTPCodeTarget5XXTooHighAlarmEvaluationPeriods: "5",
        TargetConnectionErrorCountTooHighAlarmThreshold: "100",
        TargetConnectionErrorCountTooHighAlarmPeriod: "60",
        TargetConnectionErrorCountTooHighAlarmEvaluationPeriods: "5",
        CPUUtilizationTooHighAlarmThreshold: "90",
        CPUUtilizationTooHighAlarmPeriod: "60",
        CPUUtilizationTooHighAlarmEvaluationPeriods: "5",
        MemoryUtilizationTooHighAlarmThreshold: "90",
        MemoryUtilizationTooHighAlarmPeriod: "60",
        MemoryUtilizationTooHighAlarmEvaluationPeriods: "5",
    },
    tags: {
        Name: "dev-watch-alexa-service",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:application": "watch-alexa",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});

// CloudFormation Stack: dev-watch-alexa-pipeline
const devWatchAlexaPipeline = new aws.cloudformation.Stack("dev-watch-alexa-pipeline", {
    name: "dev-watch-alexa-pipeline",
    capabilities: ["CAPABILITY_IAM"],
    disableRollback: false,
    templateBody: pulumi.output(require("fs").readFileSync("../templates/fargate-ecs-service-pipeline.yaml", "utf-8")),
    parameters: {
        ParentClusterStack: "dev-watch-cluster",
        ParentServiceStack: devWatchAlexaServiceStack.outputs["StackName"],
        ParentECRRepositoryStack: devWatchAlexaEcr.outputs["StackName"],
        ParentS3ArtifactBucketStack: "s3-artifacts-codebuild",
        ParentAlertStack: "",
        ParentVPCStack: "",
        ParentClientStack1: "",
        ParentClientStack2: "",
        ParentClientStack3: "",
        SubnetsReach: "Private",
        CodeCommitRepo: "",
        CodeCommitBranch: "master",
        GitHubConnectionArn: "arn:aws:codestar-connections:us-east-1:433624884903:connection/b2a3e0ae-1341-4371-bcf3-31fddfd4e1f7",
        GitHubOwner: "aenetworks",
        GitHubRepo: "aetn.watch.alexa",
        GitHubBranch: "dev",
        SourceBucketName: "",
        SourceObjectKey: "",
        ValidationFunction1: "",
        ValidationFunction2: "",
        ValidationFunction3: "",
        CodeBuildServicePolicies: "",
        CodeBuildEnvironment1Key: "PUSH_TOKEN",
        CodeBuildEnvironment1Type: "SECRETS_MANAGER",
        CodeBuildEnvironment1Value: "/codebuild/github/push_token_dev",
        CodeBuildEnvironment2Key: "AETN_ENV",
        CodeBuildEnvironment2Type: "PLAINTEXT",
        CodeBuildEnvironment2Value: "dev",
        CodeBuildEnvironment3Key: "",
        CodeBuildEnvironment3Type: "PLAINTEXT",
        CodeBuildEnvironment3Value: "",
        CodeBuildEnvironment: "LINUX_CONTAINER",
        CodeBuildImageName: "aws/codebuild/standard:7.0",
        CodeBuildComputeType: "BUILD_GENERAL1_SMALL",
        CodeBuildBuildSpec: "buildspec.yaml",
        CodeBuildTimeoutInMinutes: "60",
        LogsRetentionInDays: "1",
    },
    tags: {
        Name: "dev-watch-alexa-pipeline",
        "Application ID": "AXA",
        Role: "infra",
        "aetnd:application": "watch-alexa",
        "aetnd:env": "dev",
        "Line of Business - Primary": "digital",
        env: "dev",
        Environment: "dev",
        group: "watch",
        Security: "internal",
        Automation: "pulumi",
    },
});