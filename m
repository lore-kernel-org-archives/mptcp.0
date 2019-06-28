Content-Type: multipart/mixed; boundary="===============3405813621386998511=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] KSelftests: errors last night (20190604)
Date: Fri, 28 Jun 2019 15:47:18 +0200
Message-ID: <27752ad1-323b-4469-6502-06036d0cec3e@tessares.net>
In-Reply-To: c9534f99-6dbf-4065-602c-5dcc3b55ec64@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1453

--===============3405813621386998511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello

Last night I also got a similar issue:

(...)
00:13:23.223 # ns1  TCP   -> ns2  (10.0.1.2:10005) MPTCP	[ OK ]
00:13:24.256 # ns1  MPTCP -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
00:13:25.292 # ns1  MPTCP -> ns2  (10.0.2.1:10007) TCP  	[ OK ]
00:13:26.338 # ns1  TCP   -> ns2  (10.0.2.1:10008) MPTCP	[ OK ]
00:13:27.374 # ns1  MPTCP -> ns3  (10.0.2.2:10009) MPTCP	main_loop_s:
timed out
00:13:58.414 # copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
00:13:58.415 # [ FAIL ] client exit code 2, server 2
00:13:58.415 # \nnetns ns3 socket stat for 10009:
00:13:58.441 # State     Recv-Q   Send-Q        Local Address:Port
  Peer Address:Port
00:13:58.441 # SYN-RECV  0        0                  10.0.2.2:10009
      10.0.1.1:32774    timer:(on,1.270ms,4) cwnd:2 retrans:4/0 reordering:0
00:13:58.443 # \nnetns ns1 socket stat for 10009:
00:13:58.455 # State       Recv-Q   Send-Q      Local Address:Port
  Peer Address:Port
00:13:58.456 # FIN-WAIT-1  0        49153            10.0.1.1:32774
      10.0.2.2:10009    timer:(on,22sec,7) rto:25.72 cwnd:1 ssthresh:7
retrans:7/0 reordering:0
00:13:58.460 # ns1  MPTCP -> ns3  (10.0.3.2:10010) MPTCP	[ OK ]
00:13:59.502 # ns1  MPTCP -> ns3  (10.0.3.2:10011) TCP  	[ OK ]
00:14:00.543 # ns1  TCP   -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
00:14:01.585 # ns1  MPTCP -> ns4  (10.0.3.1:10013) MPTCP	[ OK ]
(...)

But I was not able to reproduce it today.

Cheers,
Matt

On 04/06/2019 14:18, Matthieu Baerts wrote:
> Hello,
> =

> Last night, I got an error with one test:
> =

> (...)
> # ns2  TCP   -> ns3  (10.0.2.2:10029) MPTCP	[ OK ]
> # ns2  MPTCP -> ns3  (10.0.3.2:10030) MPTCP	[ OK ]
> # ns2  MPTCP -> ns3  (10.0.3.2:10031) TCP  	[ OK ]
> # ns2  TCP   -> ns3  (10.0.3.2:10032) MPTCP	[ OK ]
> # ns2  MPTCP -> ns4  (10.0.3.1:10033) MPTCP	main_loop_s: timed out
> # copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
> # [ FAIL ] client exit code 2, server 2
> # \nnetns ns4 socket stat for 10033:
> # State     Recv-Q   Send-Q        Local Address:Port        Peer
> Address:Port
> # SYN-RECV  0        0                  10.0.3.1:10033
> 10.0.2.1:37248    timer:(on,5.020ms,3) cwnd:2 retrans:3/0 reordering:0
> # \nnetns ns2 socket stat for 10033:
> # State       Recv-Q   Send-Q      Local Address:Port        Peer
> Address:Port
> # FIN-WAIT-1  0        49153            10.0.2.1:37248
> 10.0.3.1:10033    timer:(on,3.280ms,5) rto:6.75 cwnd:1 ssthresh:7
> retrans:5/0 reordering:0
> # ns3  MPTCP -> ns1  (10.0.1.1:10034) MPTCP	[ OK ]
> # ns3  MPTCP -> ns1  (10.0.1.1:10035) TCP  	[ OK ]
> # ns3  TCP   -> ns1  (10.0.1.1:10036) MPTCP	[ OK ]
> # ns3  MPTCP -> ns2  (10.0.1.2:10037) MPTCP	[ OK ]
> (...)
> =

> The same tests were running fine just before without KASAN and
> PROVE_LOCKING.
> =

> I just re-launched the tests and I no longer have this error.
> =

> Anyone else saw this error?
> =

> Cheers,
> Matt
> =


-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============3405813621386998511==--
