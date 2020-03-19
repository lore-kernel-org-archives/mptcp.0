Content-Type: multipart/mixed; boundary="===============4530171914315645565=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v1 0/3] MP_JOIN self-tests fixes
Date: Thu, 19 Mar 2020 22:29:51 +0100
Message-ID: <3ef23261-371e-4b04-8b08-dd7e4187b9c8@tessares.net>
In-Reply-To: 15b796cf-478d-a510-8a10-ebbffe1392eb@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 3994

--===============4530171914315645565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 19/03/2020 18:58, Matthieu Baerts wrote:> On 16/03/2020 19:06, Paolo =

Abeni wrote:

(...)

> Thank you for the patches and the reviews!
> =

> - c4615f515b41: "squashed" patch 1/3 in "mptcp: Implement path manager =

> interface commands"
> - 5257c21d9804: conflict in =

> t/mptcp-implement-and-use-MPTCP-level-retransmission
> - b2fc8ed9ca5f: conflict in t/mptcp-add-netlink-based-PM
> - ca158067259a..ef5d4d25c399: result
> =

> - a49945862c4d: "squashed" patch 2/3 in "mptcp: add netlink based PM"
> - ef5d4d25c399..152845a286fa: result
> =

> - 89d9a90d57ec: "squashed" patch 3/3 in "selftests: add test-cases for =

> MPTCP MP_JOIN"
> - 152845a286fa..6854e267eb38: result
> =

> Tests + export are in progress.

I don't know if it is because of this series of the previous one (I =

didn't validate the ADD_ADDRv1 series because of the compilation errors =

without IPv6) but MP-JOIN selftests are not passing:


00:22:33.510 # selftests: net/mptcp: mptcp_join.sh
00:22:33.722 [   26.953791] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:33.779 [   27.011063] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:33.841 [   27.072725] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:33.907 [   27.139205] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:33.921 # Created /tmp/tmp.yIjoftdzHL (size 1 KB) containing data =

sent by client
00:22:33.925 # Created /tmp/tmp.g2BhjAKKbf (size 1 KB) containing data =

sent by server
00:22:34.691 [   27.923132] IPv6: ADDRCONF(NETDEV_CHANGE): ns2eth1: link =

becomes ready
00:22:35.978 # no JOIN                              syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:36.234 [   29.465784] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:36.296 [   29.527773] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:36.354 [   29.585653] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:36.412 [   29.644095] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:38.459 # single subflow, limited by client    syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:38.668 [   31.900196] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:38.725 [   31.956627] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:38.782 [   32.013611] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:38.839 [   32.070715] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:40.905 # single subflow, limited by server    syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:41.117 [   34.348346] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:41.173 [   34.405189] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:41.233 [   34.464508] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:41.292 [   34.524131] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:43.361 # single subflow                       syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:43.607 [   36.839063] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:43.677 [   36.908825] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:43.743 [   36.974974] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:43.809 [   37.040564] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:45.879 # multiple subflows                    syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:46.096 [   39.327374] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:46.153 [   39.384462] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:46.206 [   39.438371] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:46.274 [   39.505456] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:48.352 # multiple subflows, limited by server syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:48.563 [   41.794844] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:48.619 [   41.851245] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:48.683 [   41.914516] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:48.747 [   41.978538] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:50.798 # unused signal address                syn[ ok ] - synack[ =

ok ] - ack[ ok ]
00:22:51.015 [   44.246727] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:51.070 [   44.302315] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:51.127 [   44.358752] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:51.184 [   44.416240] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:53.248 # signal address                       syn[fail] got 0 =

JOIN[s] syn expected 1
00:22:53.263 #  - synack[fail] got 0 JOIN[s] synack expected 1
00:22:53.278 #  - ack[fail] got 0 JOIN[s] ack expected 1
00:22:53.293 # Server ns stats
00:22:53.306 # MPTcpExtMPCapableSYNRX          1                  0.0
00:22:53.307 # MPTcpExtMPCapableACKRX          1                  0.0
00:22:53.308 # Client ns stats
00:22:53.493 [   46.725253] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:53.554 [   46.786174] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:53.616 [   46.848379] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:53.675 [   46.907186] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:55.752 # subflow and signal                   syn[fail] got 1 =

JOIN[s] syn expected 2
00:22:55.768 #  - synack[fail] got 1 JOIN[s] synack expected 2
00:22:55.783 #  - ack[fail] got 1 JOIN[s] ack expected 2
00:22:55.798 # Server ns stats
00:22:55.811 # MPTcpExtMPCapableSYNRX          1                  0.0
00:22:55.811 # MPTcpExtMPCapableACKRX          1                  0.0
00:22:55.812 # MPTcpExtMPJoinSynRx             1                  0.0
00:22:55.813 # MPTcpExtMPJoinAckRx             1                  0.0
00:22:55.814 # Client ns stats
00:22:55.830 # MPTcpExtMPJoinSynAckRx          1                  0.0
00:22:56.007 [   49.238474] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth1: link =

becomes ready
00:22:56.065 [   49.296800] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth2: link =

becomes ready
00:22:56.128 [   49.359657] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth3: link =

becomes ready
00:22:56.191 [   49.422532] IPv6: ADDRCONF(NETDEV_CHANGE): ns1eth4: link =

becomes ready
00:22:58.275 # multiple subflows and signal         syn[fail] got 2 =

JOIN[s] syn expected 3
00:22:58.290 #  - synack[fail] got 2 JOIN[s] synack expected 3
00:22:58.305 #  - ack[fail] got 2 JOIN[s] ack expected 3
00:22:58.320 # Server ns stats
00:22:58.334 # MPTcpExtMPCapableSYNRX          1                  0.0
00:22:58.335 # MPTcpExtMPCapableACKRX          1                  0.0
00:22:58.335 # MPTcpExtMPJoinSynRx             2                  0.0
00:22:58.336 # MPTcpExtMPJoinAckRx             2                  0.0
00:22:58.337 # Client ns stats
00:22:58.351 # MPTcpExtMPJoinSynAckRx          2                  0.0
00:22:58.379 not ok 3 selftests: net/mptcp: mptcp_join.sh # exit=3D1


Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4530171914315645565==--
