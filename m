Content-Type: multipart/mixed; boundary="===============6293441742220412740=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] selftests: mptcp: capture pcap on both
 sides
Date: Mon, 06 Jul 2020 12:47:46 -0700
Message-ID: <20200706.124746.191843852351699222.davem@davemloft.net>
In-Reply-To: 20200706124408.3118005-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 4929

--===============6293441742220412740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Mon,  6 Jul 2020 14:44:08 +0200

> When investigating performance issues that involve latency / loss /
> reordering it is useful to have the pcap from the sender-side as it
> allows to easier infer the state of the sender's congestion-control,
> loss-recovery, etc.
> =

> Allow the selftests to capture a pcap on both sender and receiver so
> that this information is not lost when reproducing.
> =

> This patch also improves the file names. Instead of:
> =

>   ns4-5ee79a56-X4O6gS-ns3-5ee79a56-X4O6gS-MPTCP-MPTCP-10.0.3.1.pcap
> =

> We now have something like for the same test:
> =

>   5ee79a56-X4O6gS-ns3-ns4-MPTCP-MPTCP-10.0.3.1-10030-connector.pcap
>   5ee79a56-X4O6gS-ns3-ns4-MPTCP-MPTCP-10.0.3.1-10030-listener.pcap
> =

> It was a connection from ns3 to ns4, better to start with ns3 then. The
> port is also added, easier to find the trace we want.
> =

> Co-developed-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Christoph Paasch <cpaasch(a)apple.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied, thank you.
--===============6293441742220412740==--
