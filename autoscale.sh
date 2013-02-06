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
as-update-auto-scaling-group cidemo-test-asg --region ap-southeast-2 --launch-configuration $1-lc
as-describe-auto-scaling-groups cidemo-test-asg --region ap-southeast-2 | awk '/INSTANCE/{print $2}' | while read instance; do ec2-terminate-instances $instance --region ap-southeast-2; done
as-execute-policy cidemo-test-ScaleUp --auto-scaling-group cidemo-test-asg --region ap-southeast-2