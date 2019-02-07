Content-Type: multipart/mixed; boundary="===============4044347950920289702=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH RFC mptcp 4/4] mptcp: add mptcp_poll
Date: Thu, 07 Feb 2019 15:27:11 +0100
Message-ID: <20190207142711.3475-5-fw@strlen.de>
In-Reply-To: 20190207142711.3475-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 993

--===============4044347950920289702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Can't use tcp_poll directly:

BUG: KASAN: slab-out-of-bounds in tcp_poll+0x17f/0x540
Read of size 4 at addr ffff88806ac5e50c by task mptcp_connect/2085
Call Trace:
 tcp_poll+0x17f/0x540
 sock_poll+0x152/0x180

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 Should perhaps stop walk early in case __poll_t ret has all
 possible events already set.

 net/mptcp/protocol.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 91db8a0c222d..f99d0dfabe18 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -782,6 +782,50 @@ int mptcp_stream_accept(struct socket *sock, struct so=
cket *newsock, int flags,
 	return inet_accept(sock, newsock, flags, kern);
 }
 =

+static __poll_t mptcp_poll(struct file *file, struct socket *sock,
+			   struct poll_table_struct *wait)
+{
+	struct subflow_sock *subflow, *tmp;
+	const struct mptcp_sock *msk;
+	struct sock *sk =3D sock->sk;
+	__poll_t ret =3D 0;
+	unsigned int i;
+
+	msk =3D mptcp_sk(sk);
+	if (msk->subflow)
+		return tcp_poll(file, msk->subflow, wait);
+
+	i =3D 0;
+	for (;;) {
+		int j =3D 0;
+		tmp =3D NULL;
+
+		rcu_read_lock();
+		mptcp_for_each_subflow(msk, subflow) {
+			if (j < i) {
+				j++;
+				continue;
+			}
+
+			if (!mptcp_subflow_hold(subflow))
+				continue;
+
+			tmp =3D subflow;
+			i++;
+			break;
+		}
+		rcu_read_unlock();
+
+		if (!tmp)
+			break;
+
+		ret |=3D tcp_poll(file, sock_sk(tmp)->sk_socket, wait);
+		sock_put(sock_sk(tmp));
+	}
+
+	return ret;
+}
+
 int mptcp_stream_shutdown(struct socket *sock, int how)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -833,7 +877,7 @@ const struct proto_ops mptcp_stream_ops =3D {
 	.socketpair	   =3D sock_no_socketpair,
 	.accept		   =3D mptcp_stream_accept,
 	.getname	   =3D mptcp_stream_getname,
-	.poll		   =3D tcp_poll,
+	.poll		   =3D mptcp_poll,
 	.ioctl		   =3D inet_ioctl,
 	.listen		   =3D mptcp_stream_listen,
 	.shutdown	   =3D mptcp_stream_shutdown,
-- =

2.19.2


--===============4044347950920289702==--
