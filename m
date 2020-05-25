Content-Type: multipart/mixed; boundary="===============0948702699831895304=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v3 mptcp-next 1/2] mptcp: adjust tcp rcvspace after
 moving skbs from ssk to sk queue
Date: Mon, 25 May 2020 18:15:46 +0200
Message-ID: <20200525161547.24591-1-fw@strlen.de>
X-Status: 
X-Keywords:                  
X-UID: 4489

--===============0948702699831895304==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

TCP does tcp rcvbuf tuning when copying packets to userspace, e.g. in
tcp_read_sock().  In case of mptcp, that function is only rarely used
(when discarding retransmitted duplicate data).

Instead, skbs are moved from the tcp rx queue to the mptcp socket rx
queue.
Adjust subflow rcvbuf when we do so, its the last spot where we can
adjust the ssk rcvbuf -- later we only have the mptcp-level socket.

This greatly improves performance on mptcp bulk transfers.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index ba9d3d5c625f..dbb86cbb9e77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -248,6 +248,9 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp=
_sock *msk,
 =

 	*bytes =3D moved;
 =

+	if (moved)
+		tcp_rcv_space_adjust(ssk);
+
 	return done;
 }
 =

@@ -1263,6 +1266,7 @@ static int mptcp_init_sock(struct sock *sk)
 		return ret;
 =

 	sk_sockets_allocated_inc(sk);
+	sk->sk_rcvbuf =3D sock_net(sk)->ipv4.sysctl_tcp_rmem[1];
 	sk->sk_sndbuf =3D sock_net(sk)->ipv4.sysctl_tcp_wmem[2];
 =

 	return 0;
-- =

2.26.2

--===============0948702699831895304==--
