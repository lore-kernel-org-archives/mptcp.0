Content-Type: multipart/mixed; boundary="===============2366278995262604867=="
MIME-Version: 1.0
From: David Miller <davem at davemloft.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next v3] mptcp: Wake up MPTCP worker when
 DATA_FIN found on a TCP FIN packet
Date: Wed, 23 Sep 2020 17:31:26 -0700
Message-ID: <20200923.173126.2037073365366368611.davem@davemloft.net>
In-Reply-To: 20200921145759.1302197-1-matthieu.baerts@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 5995

--===============2366278995262604867==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Matthieu Baerts <matthieu.baerts(a)tessares.net>
Date: Mon, 21 Sep 2020 16:57:58 +0200

> From: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> =

> When receiving a DATA_FIN MPTCP option on a TCP FIN packet, the DATA_FIN
> information would be stored but the MPTCP worker did not get
> scheduled. In turn, the MPTCP socket state would remain in
> TCP_ESTABLISHED and no blocked operations would be awakened.
> =

> TCP FIN packets are seen by the MPTCP socket when moving skbs out of the
> subflow receive queues, so schedule the MPTCP worker when a skb with
> DATA_FIN but no data payload is moved from a subflow queue. Other cases
> (DATA_FIN on a bare TCP ACK or on a packet with data payload) are
> already handled.
> =

> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/84
> Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machin=
e")
> Acked-by: Paolo Abeni <pabeni(a)redhat.com>
> Signed-off-by: Mat Martineau <mathew.j.martineau(a)linux.intel.com>
> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>

Applied to 'net', thanks.
--===============2366278995262604867==--
