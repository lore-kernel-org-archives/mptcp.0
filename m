Content-Type: multipart/mixed; boundary="===============0475638394494743428=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp-next 1/2] mptcp: replay SOL_SOCKET options to
 subflows
Date: Tue, 16 Jun 2020 02:41:48 +0200
Message-ID: <20200616004149.21233-2-fw@strlen.de>
In-Reply-To: 20200616004149.21233-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4686

--===============0475638394494743428==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SO_REUSEPORT won't work as expected: the setsockopt will
be successful (the mptcp sk has the flag toggled), but it has
no effect because the subflow socket isn't aware of this.

Copy the flag(s) from the mptcp socket to the subflow socket
to resolve this.

This will e.g. make 'sshd restart' work when MPTCP is used.

Reported-by: Christoph Paasch <cpaasch(a)apple.com>
Suggested-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index faa804f63c81..d6dc2649bb8e 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1858,6 +1858,14 @@ static struct proto mptcp_prot =3D {
 	.no_autobind	=3D true,
 };
 =

+static void mptcp_copy_setsockopt(struct sock *sk, struct sock *ssk)
+{
+#define C(name) ssk->name =3D sk->name
+	C(sk_reuse);
+	C(sk_reuseport);
+#undef C
+}
+
 static int mptcp_bind(struct socket *sock, struct sockaddr *uaddr, int add=
r_len)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sock->sk);
@@ -1871,6 +1879,8 @@ static int mptcp_bind(struct socket *sock, struct soc=
kaddr *uaddr, int addr_len)
 		goto unlock;
 	}
 =

+	mptcp_copy_setsockopt(sock->sk, ssock->sk);
+
 	err =3D ssock->ops->bind(ssock, uaddr, addr_len);
 	if (!err)
 		mptcp_copy_inaddrs(sock->sk, ssock->sk);
@@ -1916,6 +1926,7 @@ static int mptcp_stream_connect(struct socket *sock, =
struct sockaddr *uaddr,
 		subflow->request_mptcp =3D 0;
 =

 do_connect:
+	mptcp_copy_setsockopt(sock->sk, ssock->sk);
 	err =3D ssock->ops->connect(ssock, uaddr, addr_len, flags);
 	sock->state =3D ssock->state;
 =

@@ -1985,6 +1996,7 @@ static int mptcp_listen(struct socket *sock, int back=
log)
 	}
 =

 	sock_set_flag(sock->sk, SOCK_RCU_FREE);
+	mptcp_copy_setsockopt(sock->sk, ssock->sk);
 =

 	err =3D ssock->ops->listen(ssock, backlog);
 	inet_sk_state_store(sock->sk, inet_sk_state_load(ssock->sk));
-- =

2.26.2

--===============0475638394494743428==--
