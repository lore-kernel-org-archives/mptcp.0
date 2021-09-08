Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ACA72
	for <mptcp@lists.linux.dev>; Wed,  8 Sep 2021 01:06:39 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="207580112"
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="207580112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 18:06:38 -0700
X-IronPort-AV: E=Sophos;i="5.85,276,1624345200"; 
   d="scan'208";a="465305892"
Received: from jeanfan1-mobl.amr.corp.intel.com ([10.212.129.129])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 18:06:38 -0700
Date: Tue, 7 Sep 2021 18:06:37 -0700 (PDT)
From: Mat Martineau <mathew.j.martineau@linux.intel.com>
To: Florian Westphal <fw@strlen.de>
cc: mptcp@lists.linux.dev
Subject: Re: [mptcp-next 0/2] Fix mptcp connection hangs after link
 failover
In-Reply-To: <20210906131045.18513-1-fw@strlen.de>
Message-ID: <e7135787-ee9c-dcef-d569-ceee8a3298b4@linux.intel.com>
References: <20210906131045.18513-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

On Mon, 6 Sep 2021, Florian Westphal wrote:

> First patch is preparation work: tx_pending_data counter is unreliable.
> Second patch fixes premature stop of the retransmit timer.
>
> Florian Westphal (2):
>  mptcp: remove tx_pending_data
>  mptcp: re-set push-pending bit on retransmit failure
>
> net/mptcp/protocol.c | 32 +++++++++++++++++++++++++-------
> net/mptcp/protocol.h |  1 -
> 2 files changed, 25 insertions(+), 8 deletions(-)
>
> -- 
> 2.32.0

The code changes look ok, and I don't see any copyfd_io_poll errors. But I 
do get consistent failures in the same group of self tests related to 
stale links and recovery:

15 multiple flows, signal, link failure syn[ ok ] - synack[ ok ] - ack[ ok 
]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [fail] got 0 
stale[s] 0 recover[s],   expected stale in range [1..5],  stale-recover 
delta 1
ns2-0-eBlFRK stats
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     RX: bytes  packets  errors  dropped missed  mcast
     1728       3        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     1728       3        0       0       0       0
2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
     RX: bytes  packets  errors  dropped missed  mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0
3: ns2eth1@if3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc netem 
state DOWN mode DEFAULT group default qlen 1000
     link/ether 1a:ff:34:f1:09:0c brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-eBlFRK
     RX: bytes  packets  errors  dropped missed  mcast
     93900      1188     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     3625894    1491     0       0       0       0
4: ns2eth2@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether 86:8e:f2:62:4d:ab brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-eBlFRK
     RX: bytes  packets  errors  dropped missed  mcast
     186852     2394     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     8018037    2641     0       0       0       0
5: ns2eth3@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether 6e:bb:bc:a6:6c:e4 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-eBlFRK
     RX: bytes  packets  errors  dropped missed  mcast
     192608     2468     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     8732438    2874     0       0       0       0
6: ns2eth4@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether a2:c9:68:39:8c:68 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-eBlFRK
     RX: bytes  packets  errors  dropped missed  mcast
     178072     2282     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     7742481    2508     0       0       0       0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            84                 0.0
MPTcpExtMPJoinSynAckRx          3                  0.0
MPTcpExtAddAddr                 1                  0.0
Created /tmp/tmp.VNjv8beZVJ (size 4096 KB) containing data sent by server
16 multi flows, signal, bidi, link fail syn[ ok ] - synack[ ok ] - ack[ ok 
]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [fail] got 0 
stale[s] 0 recover[s],   expected stale in range [1..-1],  stale-recover 
delta 1
ns2-0-McIAzy stats
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     RX: bytes  packets  errors  dropped missed  mcast
     2304       4        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     2304       4        0       0       0       0
2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
     RX: bytes  packets  errors  dropped missed  mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0
3: ns2eth1@if3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc netem 
state DOWN mode DEFAULT group default qlen 1000
     link/ether 5a:55:55:d0:62:02 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-McIAzy
     RX: bytes  packets  errors  dropped missed  mcast
     1462092    1435     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     3174798    1449     0       0       0       0
4: ns2eth2@if4: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether ee:c5:e3:b4:56:91 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-McIAzy
     RX: bytes  packets  errors  dropped missed  mcast
     1212944    2864     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     9191887    3021     0       0       0       0
5: ns2eth3@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether ce:6f:56:5f:4a:85 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-McIAzy
     RX: bytes  packets  errors  dropped missed  mcast
     896684     2618     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     8202792    2745     0       0       0       0
6: ns2eth4@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether 56:7a:df:33:db:f9 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-McIAzy
     RX: bytes  packets  errors  dropped missed  mcast
     1405836    2366     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     7566286    2745     0       0       0       0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            105                0.0
MPTcpExtMPJoinSynAckRx          3                  0.0
MPTcpExtOFOQueueTail            319                0.0
MPTcpExtOFOQueue                1012               0.0
MPTcpExtOFOMerge                322                0.0
MPTcpExtDuplicateData           5                  0.0
MPTcpExtAddAddr                 1                  0.0
17 backup subflow unused, link failure  syn[ ok ] - synack[ ok ] - ack[ ok 
]
                                         add[ ok ] - echo  [ ok ]
                                         link usage        [fail] got 39% 
usage, expected 0%
18 backup flow used, multi links fail   syn[ ok ] - synack[ ok ] - ack[ ok 
]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [fail] got 0 
stale[s] 0 recover[s],   expected stale in range [2..4],  stale-recover 
delta 2
ns2-0-N0wvlQ stats
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     RX: bytes  packets  errors  dropped missed  mcast
     11052      20       0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     11052      20       0       0       0       0
2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
     RX: bytes  packets  errors  dropped missed  mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0
3: ns2eth1@if3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc netem 
state DOWN mode DEFAULT group default qlen 1000
     link/ether 2a:6f:3d:be:d2:84 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-N0wvlQ
     RX: bytes  packets  errors  dropped missed  mcast
     128512     1632     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     4726279    1678     0       0       0       0
4: ns2eth2@if4: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc netem 
state DOWN mode DEFAULT group default qlen 1000
     link/ether 52:e2:d2:54:cd:18 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-N0wvlQ
     RX: bytes  packets  errors  dropped missed  mcast
     126524     1620     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     4682855    1665     0       7       0       0
5: ns2eth3@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether fe:a5:89:cc:e8:8e brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-N0wvlQ
     RX: bytes  packets  errors  dropped missed  mcast
     378726     4855     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     18615840   5084     0       0       0       0
6: ns2eth4@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether 4e:90:1f:7e:d2:50 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-N0wvlQ
     RX: bytes  packets  errors  dropped missed  mcast
     806        9        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     1026       11       0       0       0       0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            430                0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtAddAddr                 1                  0.0
                                         link usage        [fail] got 68% 
usage, expected 50%
19 backup flow used, bidi, link failure syn[ ok ] - synack[ ok ] - ack[ ok 
]
                                         add[ ok ] - echo  [ ok ]
                                         stale             [fail] got 0 
stale[s] 0 recover[s],   expected stale in range [1..-1],  stale-recover 
delta 2
ns2-0-Fvgunu stats
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode 
DEFAULT group default qlen 1000
     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
     RX: bytes  packets  errors  dropped missed  mcast
     10476      19       0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     10476      19       0       0       0       0
2: sit0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN mode DEFAULT group 
default qlen 1000
     link/sit 0.0.0.0 brd 0.0.0.0
     RX: bytes  packets  errors  dropped missed  mcast
     0          0        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     0          0        0       0       0       0
3: ns2eth1@if3: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc netem 
state DOWN mode DEFAULT group default qlen 1000
     link/ether 42:07:fd:15:b9:5d brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-Fvgunu
     RX: bytes  packets  errors  dropped missed  mcast
     2251816    1945     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     4705486    2003     0       0       0       0
4: ns2eth2@if4: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc netem 
state DOWN mode DEFAULT group default qlen 1000
     link/ether 26:6f:86:e8:ba:8a brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-Fvgunu
     RX: bytes  packets  errors  dropped missed  mcast
     2272210    1944     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     4195868    1994     0       8       0       0
5: ns2eth3@if5: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether 76:9f:8a:36:57:d0 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-Fvgunu
     RX: bytes  packets  errors  dropped missed  mcast
     404006     5169     0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     19168550   5433     0       0       0       0
6: ns2eth4@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc netem 
state UP mode DEFAULT group default qlen 1000
     link/ether ca:9e:ce:5e:8f:d0 brd ff:ff:ff:ff:ff:ff link-netns 
ns1-0-Fvgunu
     RX: bytes  packets  errors  dropped missed  mcast
     806        9        0       0       0       0
     TX: bytes  packets  errors  dropped carrier collsns
     1026       11       0       0       0       0
MPTcpExtMPCapableSYNTX          1                  0.0
MPTcpExtMPCapableSYNACKRX       1                  0.0
MPTcpExtMPTCPRetrans            419                0.0
MPTcpExtMPJoinSynAckRx          2                  0.0
MPTcpExtOFOQueueTail            677                0.0
MPTcpExtOFOQueue                733                0.0
MPTcpExtOFOMerge                513                0.0
MPTcpExtAddAddr                 1                  0.0
                                         link usage        [fail] got 70% 
usage, expected 50%


--
Mat Martineau
Intel
