import time
import boto3
# The format of a schedule file is JSON and is a simple dictionary where
# the keys are instance ids and the values are the schedule.  For example:
#
# {
#   "i-0123456789": "00:00-08:00",
#   "i-7890123456": "16:00-02:00"
# }
#
# That would say to run the instance that ends in "9" from midnight to 8
# each day (GMT) and to run the instance that ends in "6" from 8 pm to 2
# am each day (so it spans midnight GMT).
def _lt(t1, t2):
    # Ugly helper function.
    if (t1.tm_hour < t2.tm_hour):
        return True
    elif (t1.tm_hour == t2.tm_hour) and (t1.tm_min < t2.tm_min):
        return True
    return False
def get_action(start_time, end_time, current_time, state):
    if _lt(start_time, end_time):
        # Schedule is within a single day.
        if _lt(start_time, current_time) and _lt(current_time, end_time):
            if state == 'stopped':
                return 'start'
        elif state == 'running':
            return 'stop'
    else:
        # The schedule wraps around midnight.
        if _lt(end_time, current_time) or _lt(current_time, start_time):
            if state == 'stopped':
                return 'start'
        elif state == 'running':
            return 'stop'
    return 'none'
def start_stop_vm(ec2, instance_id, state, schedule):
    # Convert a string in the format "00:00-08:00" into two different
    # Python time objects.
    start, end = schedule.split('-')
    start_time = time.strptime(start, '%H:%M')
    end_time = time.strptime(end, '%H:%M')
    # Get the current time in GMT to see if it lies within the schedule.
    current_time = time.gmtime()
    # See what we need to do, if anything, and do it.
    action = get_action(start_time, end_time, current_time, state)
    if action == 'start':
        ec2.start_instances(InstanceIds=[instance_id])
    elif action == 'stop':
        ec2.stop_instances(InstanceIds=[instance_id])
def get_tag(ec2, instance_id, tag_name):
    res = ec2.describe_tags(
        Filters=[
            {'Name': 'key', 'Values': [tag_name]},
            {'Name': 'resource-id', 'Values': [instance_id]},
        ]
     )
     if len(res['Tags']):
         return res['Tags'][0]['Value']
     return None
 def start_stop_vms(ec2):
     res = ec2.describe_instances(
         Filters=[{'Name': 'instance-state-name', 'Values': ['running', 'stopped']}]
     )
     # I hate how AWS doesn't return a single list of instances,
     # but instead can spread them across "reservations".
     for reservation in res['Reservations']:
         for instance in reservation['Instances']:
             instance_id = instance['InstanceId']
             state = instance['State']['Name']
             # Get the value of the Schedule tag, if any.
             schedule = get_tag(ec2, instance_id, 'Schedule')
             if schedule is not None:
                 # Do we need to stop or start the VM?
                 start_stop_vm(ec2, instance_id, state, schedule)
if __name__ == '__main__':
    ec2 = boto3.client('ec2', region_name='us-east-1')
    while True:
        start_stop_vms(ec2)
        time.sleep(60)
