Content-Type: multipart/mixed; boundary="===============6006614204225642812=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC 06/14] sendmsg: block until mptcp sk is writeable
Date: Thu, 14 Nov 2019 18:32:17 +0100
Message-ID: <20191114173225.21199-7-fw@strlen.de>
In-Reply-To: 20191114173225.21199-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2534

--===============6006614204225642812==
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
index 2144e80b8704..83be407e1dd6 100644
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
@@ -1312,6 +1322,10 @@ static __poll_t mptcp_poll(struct file *file, struct=
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

--===============6006614204225642812==--
