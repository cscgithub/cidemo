as-create-auto-scaling-group $1-asg --region ap-southeast-2 --launch-configuration $1-lc --availability-zones "ap-southeast-2a,ap-southeast-2b" --min-size 2 --max-size 10 --desired-capacity 2 --load-balancers cidemo-lb --tag "k=Name, v=$1-as, p=true" --termination-policies "OldestInstance,Default"
export SCALE_UP_ARN=`as-put-scaling-policy $1-ScaleUp --region ap-southeast-2 --auto-scaling-group $1-asg --adjustment=1 --type ChangeInCapacity --cooldown 60`
mon-put-metric-alarm $1-HighCPU --region ap-southeast-2 --comparison-operator GreaterThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 70 --alarm-actions $SCALE_UP_ARN --dimensions "AutoScalingGroupName=$1-asg"
export SCALE_DOWN_ARN=`as-put-scaling-policy $1-ScaleDown --region ap-southeast-2 --auto-scaling-group $1-asg --adjustment=-1 --type ChangeInCapacity --cooldown 60`
mon-put-metric-alarm $1-LowCPU --region ap-southeast-2 --comparison-operator LessThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 40 --alarm-actions $SCALE_DOWN_ARN --dimensions "AutoScalingGroupName=$1-asg"
as-execute-policy $1-ScaleUp --auto-scaling-group $1-asg --region ap-southeast-2 --no-honor-cooldown
as-execute-policy $1-ScaleUp --auto-scaling-group $1-asg --region ap-southeast-2 --no-honor-cooldown