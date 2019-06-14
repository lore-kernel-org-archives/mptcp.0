Content-Type: multipart/mixed; boundary="===============7834496927270106681=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH] squash-to: mptcp: Implement MPTCP receive path
Date: Fri, 14 Jun 2019 15:45:40 +0200
Message-ID: <3f1b3cc7db3a67d3140a5ab4cadcb0ebe6b87180.camel@redhat.com>
In-Reply-To: 11b5cc73-6ef8-0474-c78a-5e37fc87764e@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1374

--===============7834496927270106681==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2019-06-14 at 15:37 +0200, Matthieu Baerts wrote:
> Note that I just ran the tests after having applied the patch and
> without KASAN and PROVE_LOCKING kconfig, I got this error:

That is quite unexpected, the patch should not impact functionality in
any way.

> 00:12:41.843 # ns2  MPTCP -> ns2  (10.0.2.1:10025) TCP  	[ OK ]
> 00:12:42.874 # ns2  TCP   -> ns2  (10.0.2.1:10026) MPTCP	[ OK ]
> 00:12:43.907 # ns2  MPTCP -> ns3  (10.0.2.2:10027) MPTCP	main_loop_s:
> timed out
> 00:13:14.949 # copyfd_io: poll timed out (events: POLLIN 1, POLLOUT 4)
> 00:13:14.950 # [ FAIL ] client exit code 2, server 2
> 00:13:14.950 # \nnetns ns3 socket stat for 10027:
> 00:13:14.970 # State     Recv-Q   Send-Q        Local Address:Port
>   Peer Address:Port
> 00:13:14.970 # SYN-RECV  0        0                  10.0.2.2:10027
>       10.0.2.1:47614    timer:(on,1.550ms,4) cwnd:2 retrans:4/0 reorderin=
g:0
> 00:13:14.972 # \nnetns ns2 socket stat for 10027:
> 00:13:14.982 # State       Recv-Q   Send-Q      Local Address:Port
>   Peer Address:Port
> 00:13:14.983 # FIN-WAIT-1  0        56569            10.0.2.1:47614
>       10.0.2.2:10027    timer:(on,22sec,7) rto:25.72 cwnd:1 ssthresh:7
> retrans:7/0 reordering:0
> 00:13:14.987 # ns2  MPTCP -> ns3  (10.0.3.2:10028) MPTCP	[ OK ]
> 00:13:16.020 # ns2  MPTCP -> ns3  (10.0.3.2:10029) TCP  	[ OK ]
> =

> I *think* it looks the same as the one I reported a few days ago.
> =

> https://lists.01.org/pipermail/mptcp/2019-June/001278.html

Indeed it looks similar...

> Is it not related to what Florian fixed in his last patch? e9d3a8a4a460
> (mptcp: selftests: increase timeout and return error on ping failure)
> =

> https://lists.01.org/pipermail/mptcp/2019-June/001286.html

... and you should not see that on top of Florian's patch. Just to
double check: is your testbed up2date? (e.g. the script includes
Florian's patch).

Cheers,

Paolo


--===============7834496927270106681==--
