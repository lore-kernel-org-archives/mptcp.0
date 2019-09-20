Content-Type: multipart/mixed; boundary="===============1872196302421584185=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: Re: [MPTCP] [PATCH v2 0/7] mptcp: implement retransmit infrastructure
Date: Fri, 20 Sep 2019 20:20:08 +0200
Message-ID: <0dd932a1-9d76-13d4-817e-5fd3ec4e66c3@tessares.net>
In-Reply-To: cover.1568206133.git.pabeni@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 1895

--===============1872196302421584185==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 11/09/2019 14:55, Paolo Abeni wrote:
> The retransmission infrastructure is now functionally completed, and I do=
n't
> observe anymore memleak/socket reference leak.
> =

> Still there are a few self-test failures I still have to investigate.
> I *think* we could merge this series even with such failure pending, and =
fix
> them later, _if_ there is agreement.
> =

> v1 -> v2
> - rebased on top of "mptcp: remove token_release"
> - handle unacked sequence update collision with a loop, as suggested by M=
at
> =

> RFC v2 -> v1
> - update msk una_seq in tcp_incoming_options() and drop old patch 3/8
> - cleanup timer management
> - cleanup dfrag management
> =

> Paolo Abeni (7):
>   mptcp: move before/after64 into the header file
>   mptcp: update per unacked sequence on pkt reception
>   mptcp: queue data for mptcp level retransmission
>   mptcp: introduce MPTCP retransmission timer
>   mptcp: implement memory accounting for mptcp rtx queue
>   mptcp: rework mptcp_sendmsg_frag to accept optional dfrag
>   mptcp: implement and use MPTCP-level retransmission

Thank you for the patches and the review!

For the first patch:
- 5a3de094bcb1: "squashed" in "mptcp: Implement MPTCP receive path"
- 725be5004580: conflict in t/mptcp-add-and-use-mptcp_subflow_hold
- 0bc736fc5740: conflict in
t/mptcp-switch-sublist-to-mptcp-socket-lock-protection
- 5a9bfe5bc657: conflict in
t/mptcp-harmonize-locking-on-all-socket-operations
- 01562bd0943f..6ca71474f5a0: result

For the other ones, I added them at the end.

But now the selftests are unstable:


00:11:15.353 # MPTCP is disabled by default as expected	[ OK ]
00:11:15.743 # ns1  MPTCP -> ns1  (10.0.1.1:10000) MPTCP	[   24.016861]
IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link becomes ready
00:11:18.248 [ FAIL ] file received by client does not match (in, out):
00:11:18.259 # -rw------- 1 root root 4809756 Sep 20 16:12
/tmp/tmp.Gl6FLQbCVQ
00:11:18.261 # Trailing bytes are:
00:11:18.265 # MPTCP_TEST_FILE_END_MARKER
00:11:18.275 # -rw------- 1 root root 4776988 Sep 20 16:12
/tmp/tmp.phbPyn43Oi
00:11:18.276 # Trailing bytes are:
00:11:18.279 # MPTCP_TEST_FILE_END_MARKER
00:11:18.288 # ns1  MPTCP -> ns2  (10.0.1.2:10001) MPTCP	[ OK ]
00:11:19.326 # ns1  MPTCP -> ns2  (10.0.1.2:10002) TCP  	[ OK ]
00:11:20.386 # ns1  TCP   -> ns2  (10.0.1.2:10003) MPTCP	[ OK ]
00:11:21.405 # ns1  MPTCP -> ns2  (10.0.2.1:10004) MPTCP	[ OK ]
00:11:22.447 # ns1  MPTCP -> ns2  (10.0.2.1:10005) TCP  	[ OK ]
00:11:23.487 # ns1  TCP   -> ns2  (10.0.2.1:10006) MPTCP	[ OK ]
00:11:24.527 # ns1  MPTCP -> ns3  (10.0.2.2:10007) MPTCP	[ OK ]
00:11:25.628 # ns1  MPTCP -> ns3  (10.0.2.2:10008) TCP  	[ OK ]
00:11:26.616 # ns1  TCP   -> ns3  (10.0.2.2:10009) MPTCP	[ OK ]
00:11:27.861 # ns1  MPTCP -> ns3  (10.0.3.2:10010) MPTCP	[ OK ]
00:11:28.905 # ns1  MPTCP -> ns3  (10.0.3.2:10011) TCP  	[ OK ]
00:11:29.950 # ns1  TCP   -> ns3  (10.0.3.2:10012) MPTCP	[ OK ]
00:11:30.996 # ns1  MPTCP -> ns4  (10.0.3.1:10013) MPTCP	[ FAIL ] file
received by server does not match (in, out):
00:11:37.750 # -rw------- 1 root root 4275228 Sep 20 16:12
/tmp/tmp.YEs2evTYUi
00:11:37.751 # Trailing bytes are:
00:11:37.754 # MPTCP_TEST_FILE_END_MARKER
00:11:37.764 # -rw------- 1 root root 4235103 Sep 20 16:13
/tmp/tmp.EVURpWB7og
00:11:37.765 # Trailing bytes are:
00:11:37.768 # MPTCP_TEST_FILE_END_MARKER
00:11:37.772 # ns2  MPTCP -> ns1  (10.0.1.1:10014) MPTCP	[ OK ]
00:11:38.814 # ns2  MPTCP -> ns1  (10.0.1.1:10015) TCP  	[ OK ]
00:11:39.851 # ns2  TCP   -> ns1  (10.0.1.1:10016) MPTCP	[ OK ]
00:11:40.891 # ns2  MPTCP -> ns2  (10.0.1.2:10017) MPTCP	[ OK ]
00:11:41.925 # ns2  MPTCP -> ns2  (10.0.1.2:10018) TCP  	[ OK ]
00:11:42.959 # ns2  TCP   -> ns2  (10.0.1.2:10019) MPTCP	[ OK ]
00:11:43.993 # ns2  MPTCP -> ns2  (10.0.2.1:10020) MPTCP	[ OK ]
00:11:45.031 # ns2  MPTCP -> ns2  (10.0.2.1:10021) TCP  	[ OK ]
00:11:46.064 # ns2  TCP   -> ns2  (10.0.2.1:10022) MPTCP	[ OK ]
00:11:47.097 # ns2  MPTCP -> ns3  (10.0.2.2:10023) MPTCP	[ OK ]
00:11:48.141 # ns2  MPTCP -> ns3  (10.0.2.2:10024) TCP  	[ OK ]
00:11:49.182 # ns2  TCP   -> ns3  (10.0.2.2:10025) MPTCP	[ OK ]
00:11:50.225 # ns2  MPTCP -> ns3  (10.0.3.2:10026) MPTCP	[ OK ]
00:11:51.268 # ns2  MPTCP -> ns3  (10.0.3.2:10027) TCP  	[ OK ]
00:11:52.312 # ns2  TCP   -> ns3  (10.0.3.2:10028) MPTCP	[ OK ]
00:11:53.370 # ns2  MPTCP -> ns4  (10.0.3.1:10029) MPTCP	[ OK ]
00:11:58.470 # ns2  MPTCP -> ns4  (10.0.3.1:10030) TCP  	[ OK ]
00:12:03.677 # ns2  TCP   -> ns4  (10.0.3.1:10031) MPTCP	[ OK ]
00:12:09.171 # ns3  MPTCP -> ns1  (10.0.1.1:10032) MPTCP	[ OK ]
00:12:10.218 # ns3  MPTCP -> ns1  (10.0.1.1:10033) TCP  	[ OK ]
00:12:11.262 # ns3  TCP   -> ns1  (10.0.1.1:10034) MPTCP	[ OK ]
00:12:12.304 # ns3  MPTCP -> ns2  (10.0.1.2:10035) MPTCP	[ OK ]
00:12:13.350 # ns3  MPTCP -> ns2  (10.0.1.2:10036) TCP  	[ OK ]
00:12:14.437 # ns3  TCP   -> ns2  (10.0.1.2:10037) MPTCP	[ OK ]
00:12:15.439 # ns3  MPTCP -> ns2  (10.0.2.1:10038) MPTCP	[ OK ]
00:12:16.486 # ns3  MPTCP -> ns2  (10.0.2.1:10039) TCP  	[ OK ]
00:12:17.533 # ns3  TCP   -> ns2  (10.0.2.1:10040) MPTCP	[ OK ]
00:12:18.576 # ns3  MPTCP -> ns3  (10.0.2.2:10041) MPTCP	[ OK ]
00:12:19.653 # ns3  MPTCP -> ns3  (10.0.2.2:10042) TCP  	[ OK ]
00:12:20.644 # ns3  TCP   -> ns3  (10.0.2.2:10043) MPTCP	[ OK ]
00:12:21.681 # ns3  MPTCP -> ns3  (10.0.3.2:10044) MPTCP	[ OK ]
00:12:22.720 # ns3  MPTCP -> ns3  (10.0.3.2:10045) TCP  	[ OK ]
00:12:23.756 # ns3  TCP   -> ns3  (10.0.3.2:10046) MPTCP	[ OK ]
00:12:24.792 # ns3  MPTCP -> ns4  (10.0.3.1:10047) MPTCP	[ OK ]
00:12:26.072 # ns3  MPTCP -> ns4  (10.0.3.1:10048) TCP  	[ OK ]
00:12:27.400 # ns3  TCP   -> ns4  (10.0.3.1:10049) MPTCP	[ OK ]
00:12:32.415 # ns4  MPTCP -> ns1  (10.0.1.1:10050) MPTCP	[ FAIL ] file
received by client does not match (in, out):
00:13:08.018 # -rw------- 1 root root 4809756 Sep 20 16:12
/tmp/tmp.Gl6FLQbCVQ
00:13:08.018 # Trailing bytes are:
00:13:08.018 # MPTCP_TEST_FILE_END_MARKER
00:13:08.018 # -rw------- 1 root root 4692159 Sep 20 16:14
/tmp/tmp.phbPyn43Oi
00:13:08.018 # Trailing bytes are:
00:13:08.018 # MPTCP_TEST_FILE_END_MARKER
00:13:08.018 # ns4  MPTCP -> ns2  (10.0.1.2:10051) MPTCP	[ OK ]
00:13:08.018 # ns4  MPTCP -> ns2  (10.0.1.2:10052) TCP  	[ OK ]
00:13:08.018 # ns4  TCP   -> ns2  (10.0.1.2:10053) MPTCP	[ OK ]
00:13:08.018 # ns4  MPTCP -> ns2  (10.0.2.1:10054) MPTCP	[ FAIL ] file
received by client does not match (in, out):
00:13:08.018 # -rw------- 1 root root 4809756 Sep 20 16:12
/tmp/tmp.Gl6FLQbCVQ
00:13:08.018 # Trailing bytes are:
00:13:08.018 # MPTCP_TEST_FILE_END_MARKER
00:13:08.018 # -rw------- 1 root root 4745856 Sep 20 16:14
/tmp/tmp.phbPyn43Oi
00:13:08.018 # Trailing bytes are:
00:13:08.018 # MPTCP_TEST_FILE_END_MARKER
00:13:08.018 # ns4  MPTCP -> ns3  (10.0.2.2:10055) MPTCP	[ OK ]
00:13:08.018 # ns4  MPTCP -> ns3  (10.0.2.2:10056) TCP  	[ OK ]
00:13:13.047 # ns4  TCP   -> ns3  (10.0.2.2:10057) MPTCP	[ OK ]
00:13:18.209 # ns4  MPTCP -> ns3  (10.0.3.2:10058) MPTCP	[ OK ]
00:13:24.563 # ns4  MPTCP -> ns3  (10.0.3.2:10059) TCP  	[ OK ]
00:13:30.393 # ns4  TCP   -> ns3  (10.0.3.2:10060) MPTCP	[ OK ]
00:13:36.534 # ns4  MPTCP -> ns4  (10.0.3.1:10061) MPTCP	[ OK ]
00:13:37.569 # ns4  MPTCP -> ns4  (10.0.3.1:10062) TCP  	[ OK ]
00:13:38.604 # ns4  TCP   -> ns4  (10.0.3.1:10063) MPTCP	[ OK ]
00:13:39.672 not ok 1 selftests: mptcp: mptcp_connect.sh


Is is fixed with the patch you sent today? (fix stream corruption)
Can I continue to apply the other patches?

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium

--===============1872196302421584185==--
