as-create-launch-config CIDemoLaunch --region ap-southeast-2 --image-id ami-2e7fe914 --instance-type t1.micro --key lukeaaus --group cidemo
as-create-auto-scaling-group CIDemoASG --region ap-southeast-2 --launch-configuration CIDemoLaunch --availability-zones ap-southeast-2b --min-size 1 --max-size 10 --desired-capacity 1 --load-balancers cidemo-lb
export SCALE_UP_ARN=`as-put-scaling-policy CIDemoScaleUp --region ap-southeast-2 --auto-scaling-group CIDemoASG --adjustment=1 --type ChangeInCapacity  --cooldown 60`
mon-put-metric-alarm CIDemoHighCPU --region ap-southeast-2 --comparison-operator GreaterThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 70 --alarm-actions $SCALE_UP_ARN --dimensions "AutoScalingGroupName=CIDemoASG"
export SCALE_DOWN_ARN=`as-put-scaling-policy CIDemoScaleDown --region ap-southeast-2 --auto-scaling-group CIDemoASG --adjustment=-1 --type ChangeInCapacity  --cooldown 60`
mon-put-metric-alarm CIDemoLowCPU --region ap-southeast-2 --comparison-operator LessThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 40 --alarm-actions $SCALE_DOWN_ARN --dimensions "AutoScalingGroupName=CIDemoASG"

# Set key name
# Set instance name