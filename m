Content-Type: multipart/mixed; boundary="===============5152540955548371976=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: selftests: no re-ordering makes tests very slow
Date: Wed, 20 Nov 2019 17:12:50 +0100
Message-ID: <e99c3dd8-1b7a-d84d-eee4-6fbce409dbdd@tessares.net>
In-Reply-To: 5e2d899e-852d-b213-afc2-1dce2fb80305@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2621

--===============5152540955548371976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 16/11/2019 13:41, Matthieu Baerts wrote:
> Hello,
> =

> When trying to reproduce the crash I had, I saw that most of the time =

> when there is no re-ordering set (which can happen even with the default =

> options) but with loss and delay, the tests can be very slow with the ns4:

In my previous tests, I forgot to mention that I was testing "mptcp: add =

basic kselftest for mptcp" commit.

Here are the results I just got when asking the CI to test the latest =

origin/export branch:


00:12:45.309 # New MPTCP socket can be blocked via sysctl	[ OK ]
00:12:45.327 # setsockopt(..., TCP_ULP, "mptcp", ...) blocked	[ OK ]
00:12:47.942 # INFO: validating network environment with pings
00:12:48.530 # INFO: Using loss of 0.34% delay 382 ms on ns3eth4
00:12:48.538 # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration =

  27ms) [ OK ]
00:12:48.600 # ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration =

  24ms) [ OK ]
00:12:48.658 # ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration =

  25ms) [ OK ]
00:12:48.716 # ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP	(duration =

  25ms) [ OK ]
00:12:48.775 # ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP  	(duration =

  27ms) [ OK ]
00:12:48.839 # ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP	(duration =

  25ms) [ OK ]
00:12:48.899 # ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP	(duration =

  35ms) [ OK ]
00:12:48.977 # ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP	(duration =

  32ms) [ OK ]
00:12:49.049 # ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP	(duration =

  30ms) [ OK ]
00:12:49.112 # ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP	(duration =

  32ms) [ OK ]
00:12:49.178 # ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP	(duration =

  41ms) [ OK ]
00:12:49.255 # ns1 MPTCP -> ns3 (dead:beef:2::2:10011) MPTCP	(duration =

  39ms) [ OK ]
00:12:49.330 # ns1 MPTCP -> ns3 (10.0.3.2:10012      ) MPTCP	(duration =

  40ms) [ OK ]
00:12:49.412 # ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP	(duration =

  43ms) [ OK ]
00:12:49.496 # ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP	(duration =

7276ms) [ OK ]
00:12:56.805 # ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP	(duration =

43826ms) [ OK ]
00:13:40.667 # ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP	(duration =

  33ms) [ OK ]
00:13:40.736 # ns2 MPTCP -> ns1 (dead:beef:1::1:10017) MPTCP	(duration =

  33ms) [ OK ]
00:13:40.807 # ns2 MPTCP -> ns3 (10.0.2.2:10018      ) MPTCP	(duration =

  40ms) [ OK ]
00:13:40.887 # ns2 MPTCP -> ns3 (dead:beef:2::2:10019) MPTCP	(duration =

  40ms) [ OK ]
00:13:40.967 # ns2 MPTCP -> ns3 (10.0.3.2:10020      ) MPTCP	(duration =

  38ms) [ OK ]
00:13:41.044 # ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP	(duration =

  36ms) [ OK ]
00:13:41.116 # ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP	(duration =

10156ms) [ OK ]
00:13:51.310 # ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP	(duration =

11349ms) [ OK ]
00:14:02.696 # ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP	(duration =

  41ms) [ OK ]
00:14:02.772 # ns3 MPTCP -> ns1 (dead:beef:1::1:10025) MPTCP	(duration =

  43ms) [ OK ]
00:14:02.851 # ns3 MPTCP -> ns2 (10.0.1.2:10026      ) MPTCP	(duration =

  40ms) [ OK ]
00:14:02.929 # ns3 MPTCP -> ns2 (dead:beef:1::2:10027) MPTCP	(duration =

  43ms) [ OK ]
00:14:03.014 # ns3 MPTCP -> ns2 (10.0.2.1:10028      ) MPTCP	(duration =

  46ms) [ OK ]
00:14:03.102 # ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP	(duration =

  40ms) [ OK ]
00:14:03.181 # ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP	(duration =

4989ms) [ OK ]
00:14:08.206 # ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP	(duration =

4606ms) [ OK ]
00:14:12.850 # ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP	(duration =

9569ms) [ OK ]
00:14:22.451 # ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP	(duration =

18160ms) [ OK ]
00:14:40.647 # ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP	(duration =

30587ms) [ OK ]
00:15:11.268 # ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP	(duration =

27150ms) [ OK ]
00:15:38.454 # ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP	(duration =

17595ms) [ OK ]
00:15:56.085 # ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP	(duration =

34875ms) [ OK ]
00:16:30.992 # ns4 MPTCP -> ns3 (10.0.2.2:10038      ) MPTCP	(duration =

4983ms) [ OK ]
00:16:36.008 # ns4 MPTCP -> ns3 (dead:beef:2::2:10039) MPTCP	(duration =

4599ms) [ OK ]
00:16:40.641 # ns4 MPTCP -> ns3 (10.0.3.2:10040      ) MPTCP	(duration =

4605ms) [ OK ]
00:16:45.280 # ns4 MPTCP -> ns3 (dead:beef:3::2:10041) MPTCP	(duration =

4599ms) [ OK ]
00:16:49.916 # Time: 245 seconds


We can see that there is no re-ordering (Using loss of 0.34% delay 382 =

ms on ns3eth4). The other tests have re-ordering and no issue (12/22 =

seconds without and with KASAN)

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5152540955548371976==--
