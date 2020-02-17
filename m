Content-Type: multipart/mixed; boundary="===============2213537877861668307=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 6/6] mptcp: send acks when moving skbs to mptcp
 receive queue
Date: Mon, 17 Feb 2020 16:01:01 +0100
Message-ID: <20200217150101.13603-7-fw@strlen.de>
In-Reply-To: 20200217150101.13603-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3675

--===============2213537877861668307==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 include/net/tcp.h    | 1 +
 net/ipv4/tcp.c       | 2 +-
 net/mptcp/protocol.c | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index a5ea27df3c2b..454ecab0df8b 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -650,6 +650,7 @@ static inline int tcp_bound_to_half_wnd(struct tcp_sock=
 *tp, int pktsize)
 =

 /* tcp.c */
 void tcp_get_info(struct sock *, struct tcp_info *);
+void tcp_cleanup_rbuf(struct sock *sk, int copied);
 =

 /* Read 'sendfile()'-style from a TCP socket */
 int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index eb2d80519f8e..91883dbc37fc 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1517,7 +1517,7 @@ static int tcp_peek_sndq(struct sock *sk, struct msgh=
dr *msg, int len)
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void tcp_cleanup_rbuf(struct sock *sk, int copied)
+void tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp =3D tcp_sk(sk);
 	bool time_to_ack =3D false;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 54efcb4aecbc..1db6b64f4097 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -773,6 +773,9 @@ static bool __mptcp_move_skbs(struct mptcp_sock *msk)
 			more_data_avail =3D mptcp_subflow_data_available(ssk);
 		} while (more_data_avail);
 =

+		if (moved > 0)
+			tcp_cleanup_rbuf(ssk, moved);
+
 		release_sock(ssk);
 	} while (!done);
 =

-- =

2.24.1

--===============2213537877861668307==--
