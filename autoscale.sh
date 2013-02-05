export COUNTER=0
export INSTANCE_ID=""
while [ -z "$INSTANCE_ID" ]; do
	if [ "$COUNTER" -gt 24 ]; then
		echo "Quitting after 25 attempts"
		exit 1
	else
	  	sleep 5s
	  	echo "Checking for instance availability"
	  	INSTANCE_ID=`ec2-describe-instances --region ap-southeast-2 --filter "tag-key=aws:cloudformation:stack-name" --filter "tag-value=$1" --filter "instance-state-name=running" | awk '/INSTANCE/{print $2}'`
	  	let COUNTER=COUNTER+1
    fi
done

export IMAGE_ID=`ec2-create-image --region ap-southeast-2 -n $1 -d "Image for build $1" $INSTANCE_ID | awk '/IMAGE/{print $2}'`

as-create-launch-config $1-lc --region ap-southeast-2 --image-id $IMAGE_ID --instance-type t1.micro --key lukeaaus --group cidemo
as-create-auto-scaling-group cidemo-test-asg --region ap-southeast-2 --launch-configuration $1-lc --availability-zones ap-southeast-2b --min-size 1 --max-size 10 --desired-capacity 1 --load-balancers cidemo-test-lb --tag "k=Name, v=$1-as, p=true"
export SCALE_UP_ARN=`as-put-scaling-policy cidemo-test-ScaleUp --region ap-southeast-2 --auto-scaling-group cidemo-test-asg --adjustment=1 --type ChangeInCapacity --cooldown 60`
mon-put-metric-alarm cidemo-test-HighCPU --region ap-southeast-2 --comparison-operator GreaterThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 70 --alarm-actions $SCALE_UP_ARN --dimensions "AutoScalingGroupName=cidemo-test-asg"
export SCALE_DOWN_ARN=`as-put-scaling-policy cidemo-test-ScaleDown --region ap-southeast-2 --auto-scaling-group cidemo-test-asg --adjustment=-1 --type ChangeInCapacity --cooldown 60`
mon-put-metric-alarm cidemo-test-LowCPU --region ap-southeast-2 --comparison-operator LessThanThreshold --evaluation-periods 1 --metric-name CPUUtilization --namespace "AWS/EC2" --period 60 --statistic Average --threshold 40 --alarm-actions $SCALE_DOWN_ARN --dimensions "AutoScalingGroupName=cidemo-test-asg"
