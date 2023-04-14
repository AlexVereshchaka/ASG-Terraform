import boto3
import os

cloudwatch = boto3.client('cloudwatch')
elbv2 = boto3.client('elbv2')

def lambda_handler(event, context):

    # Получение значения метрики "CPUUtilization" из CloudWatch
    response = cloudwatch.get_metric_statistics(
        Namespace='AWS/EC2',
        MetricName='CPUUtilization',
        Dimensions=[
            {
                'Name': 'InstanceId',
                'Value': os.environ['INSTANCE_ID']
            },
        ],
        StartTime='2023-04-13T00:00:00Z',
        EndTime='2023-04-14T00:00:00Z',
        Period=60,
        Statistics=[
            'Average',
        ],
    )

    # Проверка, были ли получены значения метрики
    if len(response['Datapoints']) > 0:
        average_cpu_utilization = response['Datapoints'][-1]['Average']
    else:
        print("No data for CPUUtilization found.")
        return

    print(f"Current CPUUtilization: {average_cpu_utilization}")

    # Получение ARN Target Group и Instance ID текущего сервера
    target_group_arn = os.environ['TARGET_GROUP_ARN']
    instance_id = os.environ['INSTANCE_ID']

    # Определение, на какой сервер должен быть перенаправлен трафик
    if average_cpu_utilization >= 80:
        print("Redirecting traffic to second server.")
        target_id = get_target_id(target_group_arn, instance_id)
        register_target(target_group_arn, target_id, False)
    elif average_cpu_utilization < 50:
        print("Redirecting traffic to first server.")
        target_id = get_target_id(target_group_arn, instance_id)
        register_target(target_group_arn, target_id, True)
    else:
        print("CPUUtilization is within acceptable limits.")

def get_target_id(target_group_arn, instance_id):
    response = elbv2.describe_target_health(TargetGroupArn=target_group_arn)
    for target in response['TargetHealthDescriptions']:
        if target['Target']['Id'] == instance_id:
            return target['Target']['Id']
    return None

def register_target(target_group_arn, target_id, primary):
    if primary:
        response = elbv2.deregister_targets(
            TargetGroupArn=target_group_arn,
            Targets=[
                {
                    'Id': target_id,
                },
            ]
        )
    else:
        response = elbv2.register_targets(
            TargetGroupArn=target_group_arn,
            Targets=[
                {
                    'Id': target_id,
                },
            ]
        )
    print(response)

    if not primary:
        delete_instance(target_id)

def delete_instance(instance_id):
    ec2 = boto3.client('ec2')
    response = ec2.terminate_instances(
        InstanceIds=[
            instance_id,
        ]
    )
    print(response)
