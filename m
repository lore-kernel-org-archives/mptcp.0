Content-Type: multipart/mixed; boundary="===============0194675510401486207=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 4/4] sendmsg: block until mptcp sk is writeable
Date: Tue, 12 Nov 2019 15:10:38 +0100
Message-ID: <20191112141038.19213-5-fw@strlen.de>
In-Reply-To: 20191112141038.19213-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2487

--===============0194675510401486207==
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
Because subflow ssk is usually writable, we will have to undo-that
if the mptcp sndbuf is exhausted.  This won't be needed anymore once
__tcp_poll is removed, I am working on this.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 68171a539a02..4da4c702b1a5 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -406,6 +406,18 @@ static int mptcp_sendmsg(struct sock *sk, struct msghd=
r *msg, size_t len)
 		return ret;
 	}
 =

+	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
+
+	mptcp_clean_una(sk);
+
+	while (!sk_stream_is_writeable(sk)) {
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
@@ -421,8 +433,6 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 	pr_debug("conn_list->subflow=3D%p", ssk);
 =

 	lock_sock(ssk);
-	mptcp_clean_una(sk);
-	timeo =3D sock_sndtimeo(sk, msg->msg_flags & MSG_DONTWAIT);
 	while (msg_data_left(msg)) {
 		ret =3D mptcp_sendmsg_frag(sk, ssk, msg, NULL, &timeo, &mss_now,
 					 &size_goal);
@@ -1315,6 +1325,10 @@ static __poll_t mptcp_poll(struct file *file, struct=
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

--===============0194675510401486207==--
