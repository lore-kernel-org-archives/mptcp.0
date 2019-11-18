Content-Type: multipart/mixed; boundary="===============5702865643264116531=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 06/13] sendmsg: block until mptcp sk is writeable
Date: Mon, 18 Nov 2019 22:45:31 +0100
Message-ID: <20191118214538.21931-7-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2591

--===============5702865643264116531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This disables transmit of new data until the peer has acked
enough mptcp data to get below the wspace write threshold (more than
half of wspace upperlimit is available again).

Also have poll not report EPOLLOUT in this case, its not relevant if a
subflow is writeable.

The latter is a temporary workaround that is needed because mptcp_poll
walks the subflows and calls __tcp_poll on each of them.

Because subflow ssk is usually writable, the EPOLLOUT needs to be
removed if the mptcp sndbuf is exhausted.

This is only needed until __tcp_poll is removed later in the series.

v2: drop the "empty send" part as per comments from Paolo and Mat.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2144e80b8704..1515c3bad751 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -406,23 +406,27 @@ static int mptcp_sendmsg(struct sock *sk, struct msgh=
dr *msg, size_t len)
 		return ret;
 	}
 =

+	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+	mptcp_clean_una(sk);
+
+	while (!sk_stream_memory_free(sk)) {
+		ret =3D sk_stream_wait_memory(sk, &timeo);
+		if (ret)
+			goto out;
+
+		mptcp_clean_una(sk);
+	}
+
 	ssk =3D mptcp_subflow_get(msk);
 	if (!ssk) {
 		release_sock(sk);
 		return -ENOTCONN;
 	}
 =

-	if (!msg_data_left(msg)) {
-		pr_debug("empty send");
-		ret =3D sock_sendmsg(ssk->sk_socket, msg);
-		goto out;
-	}
-
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
-	mptcp_clean_una(sk);
-	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
@@ -1312,6 +1316,10 @@ static __poll_t mptcp_poll(struct file *file, struct=
 socket *sock,
 		tcp_sock =3D mptcp_subflow_tcp_socket(subflow);
 		ret |=3D __tcp_poll(tcp_sock->sk);
 	}
+
+	if (!sk_stream_is_writeable(sk))
+		ret &=3D ~(EPOLLOUT|EPOLLWRNORM);
+
 	release_sock(sk);
 =

 	return ret;
-- =

2.23.0

--===============5702865643264116531==--
