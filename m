Content-Type: multipart/mixed; boundary="===============4998186119245831389=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests: errors last night (20190604)
Date: Mon, 01 Jul 2019 11:15:02 -0700
Message-ID: <alpine.OSX.2.21.1907011030570.13929@mjmartin-mac01.local>
In-Reply-To: 6166cccb438d5e34ec4b1051e9dba43cf5a9fba3.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1459

--===============4998186119245831389==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Mon, 1 Jul 2019, Paolo Abeni wrote:

> On Fri, 2019-06-28 at 15:47 +0200, Matthieu Baerts wrote:
>> (...)
>> 00:13:23.223 # ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
>> 00:13:24.256 # ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
>> 00:13:25.292 # ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
>> 00:13:26.338 # ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
>> 00:13:27.374 # ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	main_loop_s:
>> timed out
>> 00:13:58.414 # copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
>> 00:13:58.415 # [ FAIL ] client exit code 2, server 2
>> 00:13:58.415 # \nnetns ns3 socket stat for 10009:
>> 00:13:58.441 # State     Recv-Q   Send-Q        Local Address:Port
>>   Peer Address:Port
>> 00:13:58.441 # SYN-RECV  0        0                  10.0.2.2:10009
>>       10.0.1.1:32774    timer:(on,1.270ms,4) cwnd:2 retrans:4/0 reorderi=
ng:0
>> 00:13:58.443 # \nnetns ns1 socket stat for 10009:
>> 00:13:58.455 # State       Recv-Q   Send-Q      Local Address:Port
>>   Peer Address:Port
>> 00:13:58.456 # FIN-WAIT-1  0        49153            10.0.1.1:32774
>>       10.0.2.2:10009    timer:(on,22sec,7) rto:25.72 cwnd:1 ssthresh:7
>> retrans:7/0 reordering:0
>> 00:13:58.460 # ns1  MPTCP -> ns3  (10.0.3.2:10010) MPTCP	[ OK ]
>> 00:13:59.502 # ns1  MPTCP -> ns3  (10.0.3.2:10011) TCP  	[ OK ]
>> 00:14:00.543 # ns1  TCP   -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
>> 00:14:01.585 # ns1  MPTCP -> ns4  (10.0.3.1:10013) MPTCP	[ OK ]
>> (...)
>
> I'm (/was) able to reproduce the issue locally, but not reliably.
>
> @Mat: is "mptcp: Make MPTCP socket block/wakeup ignore
> sk_receive_queue" somehow related to this issue ? (e.g. an attempt to
> fix it)
>

That patch is a fix for a blocking issue I noticed in a different testing =

scenario, where recvmsg was blocking after a peer disconnected.

I was speculating that my patch since it looked like something was =

blocking too long - but examining the output more closely, that SYN-RECV =

state on one peer and the send-q on the other make this bug seem like =

something different.

--
Mat Martineau
Intel

--===============4998186119245831389==--
