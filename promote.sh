as-update-auto-scaling-group cidemo-asg --region ap-southeast-2 --launch-configuration $1-lc
as-execute-policy cidemo-ScaleUp --auto-scaling-group cidemo-asg --region ap-southeast-2