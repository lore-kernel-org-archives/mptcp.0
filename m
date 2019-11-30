Content-Type: multipart/mixed; boundary="===============9156696101588750658=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: selftests: no re-ordering makes tests very slow
Date: Sat, 30 Nov 2019 10:22:04 +0100
Message-ID: <5af23246-cd21-6651-f016-7e9b2a4d908e@tessares.net>
In-Reply-To: e99c3dd8-1b7a-d84d-eee4-6fbce409dbdd@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 2712

--===============9156696101588750658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

On 20/11/2019 17:12, Matthieu Baerts wrote:
> Hello,
> =

> On 16/11/2019 13:41, Matthieu Baerts wrote:
>> Hello,
>>
>> When trying to reproduce the crash I had, I saw that most of the time =

>> when there is no re-ordering set (which can happen even with the =

>> default options) but with loss and delay, the tests can be very slow =

>> with the ns4:
> =

> In my previous tests, I forgot to mention that I was testing "mptcp: add =

> basic kselftest for mptcp" commit.
> =

> Here are the results I just got when asking the CI to test the latest =

> origin/export branch:

FYI, selftests from last night's CI job failed. But it doesn't look =

critical as they failed due to a timeout, probably because of this issue =

(no re-ordering set):


01:12:17.147 TAP version 13
01:12:17.160 1..1
01:12:17.211 # selftests: net/mptcp: mptcp_connect.sh
01:12:18.149 [   53.654519] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
01:12:18.434 [   53.938877] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth3: link =

becomes ready
01:12:18.714 [   54.219094] IPv6: ADDRCONF(NETDEV_CHANGE): ns3eth4: link =

becomes ready
01:12:18.814 # INFO: set ns3-5de1ddd4-0j9d6N dev ns3eth2: ethtool -K =

gso off
01:12:18.877 [   54.382317] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link =

becomes ready
01:12:18.939 # Created /tmp/tmp.Cr7KGLuarg (size 4403797) containing =

data sent by client
01:12:19.101 # Created /tmp/tmp.sU9xWEO4c7 (size 7175996) containing =

data sent by server
01:12:19.318 # New MPTCP socket can be blocked via sysctl		[ OK ]
01:12:19.419 # setsockopt(..., TCP_ULP, "mptcp", ...) blocked	[ OK ]
01:12:19.446 # INFO: validating network environment with pings
01:12:22.687 # INFO: Using loss of 0.99% delay 218 ms on ns3eth4
01:12:22.716 # ns1 MPTCP -> ns1 (10.0.1.1:10000      ) MPTCP	(duration =

171ms) [ OK ]
01:12:23.068 # ns1 MPTCP -> ns1 (10.0.1.1:10001      ) TCP  	(duration =

163ms) [ OK ]
01:12:23.404 # ns1 TCP   -> ns1 (10.0.1.1:10002      ) MPTCP	(duration =

121ms) [ OK ]
01:12:23.700 # ns1 MPTCP -> ns1 (dead:beef:1::1:10003) MPTCP	(duration =

169ms) [ OK ]
01:12:24.039 # ns1 MPTCP -> ns1 (dead:beef:1::1:10004) TCP  	(duration =

127ms) [ OK ]
01:12:24.343 # ns1 TCP   -> ns1 (dead:beef:1::1:10005) MPTCP	(duration =

131ms) [ OK ]
01:12:24.659 # ns1 MPTCP -> ns2 (10.0.1.2:10006      ) MPTCP	(duration =

307ms) [ OK ]
01:12:25.155 # ns1 MPTCP -> ns2 (dead:beef:1::2:10007) MPTCP	(duration =

312ms) [ OK ]
01:12:25.655 # ns1 MPTCP -> ns2 (10.0.2.1:10008      ) MPTCP	(duration =

312ms) [ OK ]
01:12:26.154 # ns1 MPTCP -> ns2 (dead:beef:2::1:10009) MPTCP	(duration =

297ms) [ OK ]
01:12:26.623 # ns1 MPTCP -> ns3 (10.0.2.2:10010      ) MPTCP	(duration =

466ms) [ OK ]
01:12:27.267 # ns1 MPTCP -> ns3 (dead:beef:2::2:10011) MPTCP	(duration =

366ms) [ OK ]
01:12:27.813 # ns1 MPTCP -> ns3 (10.0.3.2:10012      ) MPTCP	(duration =

458ms) [ OK ]
01:12:28.445 # ns1 MPTCP -> ns3 (dead:beef:3::2:10013) MPTCP	(duration =

428ms) [ OK ]
01:12:29.062 # ns1 MPTCP -> ns4 (10.0.3.1:10014      ) MPTCP	(duration =

34112ms) [ OK ]
01:13:03.333 # ns1 MPTCP -> ns4 (dead:beef:3::1:10015) MPTCP	(duration =

16252ms) [ OK ]
01:13:19.755 # ns2 MPTCP -> ns1 (10.0.1.1:10016      ) MPTCP	(duration =

305ms) [ OK ]
01:13:20.253 # ns2 MPTCP -> ns1 (dead:beef:1::1:10017) MPTCP	(duration =

328ms) [ OK ]
01:13:20.731 # ns2 MPTCP -> ns3 (10.0.2.2:10018      ) MPTCP	(duration =

430ms) [ OK ]
01:13:21.342 # ns2 MPTCP -> ns3 (dead:beef:2::2:10019) MPTCP	(duration =

325ms) [ OK ]
01:13:21.845 # ns2 MPTCP -> ns3 (10.0.3.2:10020      ) MPTCP	(duration =

361ms) [ OK ]
01:13:22.384 # ns2 MPTCP -> ns3 (dead:beef:3::2:10021) MPTCP	(duration =

332ms) [ OK ]
01:13:22.902 # ns2 MPTCP -> ns4 (10.0.3.1:10022      ) MPTCP	(duration =

35082ms) [ OK ]
01:13:58.156 # ns2 MPTCP -> ns4 (dead:beef:3::1:10023) MPTCP	(duration =

39069ms) [ OK ]
01:14:37.397 # ns3 MPTCP -> ns1 (10.0.1.1:10024      ) MPTCP	(duration =

405ms) [ OK ]
01:14:37.975 # ns3 MPTCP -> ns1 (dead:beef:1::1:10025) MPTCP	(duration =

434ms) [ OK ]
01:14:38.595 # ns3 MPTCP -> ns2 (10.0.1.2:10026      ) MPTCP	(duration =

346ms) [ OK ]
01:14:39.118 # ns3 MPTCP -> ns2 (dead:beef:1::2:10027) MPTCP	(duration =

351ms) [ OK ]
01:14:39.654 # ns3 MPTCP -> ns2 (10.0.2.1:10028      ) MPTCP	(duration =

363ms) [ OK ]
01:14:40.195 # ns3 MPTCP -> ns2 (dead:beef:2::1:10029) MPTCP	(duration =

395ms) [ OK ]
01:14:40.770 # ns3 MPTCP -> ns4 (10.0.3.1:10030      ) MPTCP	(duration =

2908ms) [ OK ]
01:14:43.867 # ns3 MPTCP -> ns4 (dead:beef:3::1:10031) MPTCP	(duration =

2919ms) [ OK ]
01:14:46.976 # ns4 MPTCP -> ns1 (10.0.1.1:10032      ) MPTCP	(duration =

52371ms) [ OK ]
01:15:39.533 # ns4 MPTCP -> ns1 (dead:beef:1::1:10033) MPTCP	(duration =

70078ms) [ OK ]
01:16:49.781 # ns4 MPTCP -> ns2 (10.0.1.2:10034      ) MPTCP	(duration =

34180ms) [ OK ]
01:17:24.135 # ns4 MPTCP -> ns2 (dead:beef:1::2:10035) MPTCP	(duration =

46360ms) [ OK ]
01:18:10.673 # ns4 MPTCP -> ns2 (10.0.2.1:10036      ) MPTCP	(duration =

63281ms) [ OK ]
01:19:14.119 # ns4 MPTCP -> ns2 (dead:beef:2::1:10037) MPTCP =

./mptcp_connect.sh: line 104:  1144 Terminated              ip netns =

exec ${listener_ns} ./mptcp_connect -t $timeout -l -p $port -s =

${srv_proto} $extra_args $local_addr < "$sin" > "$sout"
01:19:47.280 # ./mptcp_connect.sh: line 104:  1150 Terminated =

   ip netns exec ${connector_ns} ./mptcp_connect -t $timeout -p $port -s =

${cl_proto} $extra_args $connect_addr < "$cin" > "$cout"
01:19:47.498 not ok 1 selftests: net/mptcp: mptcp_connect.sh # TIMEOUT


The current timeout is 450.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============9156696101588750658==--
