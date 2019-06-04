Content-Type: multipart/mixed; boundary="===============9128408545091529993=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] KSelftests: errors last night (20190604)
Date: Tue, 04 Jun 2019 14:18:08 +0200
Message-ID: <c9534f99-6dbf-4065-602c-5dcc3b55ec64@tessares.net>
X-Status: 
X-Keywords:                  
X-UID: 1279

--===============9128408545091529993==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

Last night, I got an error with one test:

(...)
# ns2  TCP   -> ns3  (10.0.2.2:10029) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10030) MPTCP	[ OK ]
# ns2  MPTCP -> ns3  (10.0.3.2:10031) TCP  	[ OK ]
# ns2  TCP   -> ns3  (10.0.3.2:10032) MPTCP	[ OK ]
# ns2  MPTCP -> ns4  (10.0.3.1:10033) MPTCP	main_loop_s: timed out
# copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
# [ FAIL ] client exit code 2, server 2
# \nnetns ns4 socket stat for 10033:
# State     Recv-Q   Send-Q        Local Address:Port        Peer
Address:Port
# SYN-RECV  0        0                  10.0.3.1:10033
10.0.2.1:37248    timer:(on,5.020ms,3) cwnd:2 retrans:3/0 reordering:0
# \nnetns ns2 socket stat for 10033:
# State       Recv-Q   Send-Q      Local Address:Port        Peer
Address:Port
# FIN-WAIT-1  0        49153            10.0.2.1:37248
10.0.3.1:10033    timer:(on,3.280ms,5) rto:6.75 cwnd:1 ssthresh:7
retrans:5/0 reordering:0
# ns3  MPTCP -> ns1  (10.0.1.1:10034) MPTCP	[ OK ]
# ns3  MPTCP -> ns1  (10.0.1.1:10035) TCP  	[ OK ]
# ns3  TCP   -> ns1  (10.0.1.1:10036) MPTCP	[ OK ]
# ns3  MPTCP -> ns2  (10.0.1.2:10037) MPTCP	[ OK ]
(...)

The same tests were running fine just before without KASAN and
PROVE_LOCKING.

I just re-launched the tests and I no longer have this error.

Anyone else saw this error?

Cheers,
Matt

-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============9128408545091529993==--
