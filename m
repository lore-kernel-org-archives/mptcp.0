Content-Type: multipart/mixed; boundary="===============8529578860058950464=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH v2 11/13] sendmsg: clear SEND_SPACE if write caused
 wmem to grow too large
Date: Mon, 18 Nov 2019 22:45:36 +0100
Message-ID: <20191118214538.21931-12-fw@strlen.de>
In-Reply-To: 20191118214538.21931-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 2596

--===============8529578860058950464==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is needed when we get rid of __tcp_poll and let mptcp_poll only
rely on msk->flags -- we need to avoid EPOLLOUT if the write filled
too much sndbuf space.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 8b22cf245580..9f2cbf2b89fb 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -421,6 +421,22 @@ static struct sock *mptcp_subflow_get_send(struct mptc=
p_sock *msk)
 	return backup;
 }
 =

+static void ssk_check_wmem(struct mptcp_sock *msk, struct sock *ssk)
+{
+	struct socket *sock;
+
+	if (likely(sk_stream_is_writeable(ssk)))
+		return;
+
+	sock =3D READ_ONCE(ssk->sk_socket);
+
+	if (sock) {
+		clear_bit(MPTCP_SEND_SPACE, &msk->flags);
+		smp_mb__after_atomic();
+		set_bit(SOCK_NOSPACE, &sock->flags);
+	}
+}
+
 static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	int mss_now =3D 0, size_goal =3D 0, ret =3D 0;
@@ -485,6 +501,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr=
 *msg, size_t len)
 			mptcp_reset_timer(sk);
 	}
 =

+	ssk_check_wmem(msk, ssk);
 	release_sock(ssk);
 =

 out:
-- =

2.23.0

--===============8529578860058950464==--
