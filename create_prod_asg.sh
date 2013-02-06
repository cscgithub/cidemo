as-create-auto-scaling-group cidemo-asg --region ap-southeast-2 --launch-configuration cidemo-27-lc --availability-zones ap-southeast-2b --min-size 2 --max-size 10 --desired-capacity 1 --load-balancers cidemo-lb --tag "k=Name, v=cidemo-as, p=true" --termination-policies "OldestInstance,Default"
export SCALE_UP_ARN=`as-put-scaling-policy cidemo-ScaleUp --region ap-southeast-2 --auto-scaling-group cidemo-asg --adjustment=1 --type ChangeInCapacity --cooldown 60`
mon-put-metric-alarm cidemo-HighCPU --region ap-southeast-2 --comparison-operator GreaterThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 70 --alarm-actions $SCALE_UP_ARN --dimensions "AutoScalingGroupName=cidemo-asg"
export SCALE_DOWN_ARN=`as-put-scaling-policy cidemo-ScaleDown --region ap-southeast-2 --auto-scaling-group cidemo-asg --adjustment=-1 --type ChangeInCapacity --cooldown 60`
mon-put-metric-alarm cidemo-LowCPU --region ap-southeast-2 --comparison-operator LessThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 40 --alarm-actions $SCALE_DOWN_ARN --dimensions "AutoScalingGroupName=cidemo-asg"