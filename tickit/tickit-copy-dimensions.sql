copy event from 's3://awssampledbuswest2/tickit/allevents_pipe.txt'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
delimiter '|'
timeformat 'YYYY-MM-DD HH:MI:SS'
region 'us-west-2';

copy users from 's3://awssampledbuswest2/tickit/allusers_pipe.txt'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
delimiter '|'
timeformat 'YYYY-MM-DD HH:MI:SS'
region 'us-west-2';

copy date from 's3://awssampledbuswest2/tickit/date2008_pipe.txt'
iam_role 'arn:aws:iam::<Your-AWS-Account-Number>:role/redshift-elt-test-role'
delimiter '|'
timeformat 'YYYY-MM-DD HH:MI:SS'
region 'us-west-2';