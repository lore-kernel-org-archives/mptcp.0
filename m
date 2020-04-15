Content-Type: multipart/mixed; boundary="===============1646868111629380748=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH mptcp 1/7] mptcp: fix splat when incoming connection
 is never accepted before exit/close
Date: Wed, 15 Apr 2020 19:19:48 +0200
Message-ID: <20200415171954.15321-2-fw@strlen.de>
In-Reply-To: 20200415171954.15321-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 4180

--===============1646868111629380748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Following tool (replicated from syzkaller generated code) generates
warning: "IPv4: Attempt to release TCP socket in state 1".

int main(void) {
        struct sockaddr_in sin1 =3D { .sin_family =3D 2, .sin_port =3D 0x4e=
20, .sin_addr.s_addr =3D 0x010000e0, };
        struct sockaddr_in sin2 =3D { .sin_family =3D 2, .sin_port =3D 0x0,=
 .sin_addr.s_addr =3D 0x0100007f, };
        struct sockaddr_in sin3 =3D { .sin_family =3D 2, .sin_port =3D 0x4e=
20, .sin_addr.s_addr =3D 0x0100007f, };
        int r0 =3D socket(0x2, 0x1, 0x106);
        int r1 =3D socket(0x2, 0x1, 0x106);

        bind(r1, (void *)&sin1, sizeof(sin1));
        connect(r1, (void *)&sin2, sizeof(sin2));
        listen(r1, 3);
        return connect(r0, (void *)&sin3, 0x4d);
}

Reason is that the newly generated mptcp socket is closed via
the ulp release of the tcp socket, via the listeners accept backlog
purge.
To fix this, delay setting the ESTABLISHED state until after
userspace calls accept and via mptcp specific destructor.

Fixes: 58b09919626bf ("mptcp: create msk early")
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/9
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c |  1 +
 net/mptcp/subflow.c  | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 457655ea875b..2118b51afd60 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1440,6 +1440,7 @@ static struct sock *mptcp_accept(struct sock *sk, int=
 flags, int *err,
 		newsk =3D new_mptcp_sock;
 		mptcp_copy_inaddrs(newsk, ssk);
 		list_add(&subflow->node, &msk->conn_list);
+		inet_sk_state_store(newsk, TCP_ESTABLISHED);
 =

 		bh_unlock_sock(new_mptcp_sock);
 =

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 47f901b712f9..936f748075a7 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -347,6 +347,29 @@ static bool subflow_hmac_valid(const struct request_so=
ck *req,
 	return ret;
 }
 =

+static void mptcp_sock_destruct(struct sock *sk)
+{
+	/* if new mptcp socket isn't accepted, it is free'd
+	 * from the tcp listener sockets request queue, linked
+	 * from req->sk.  The tcp socket is released.
+	 * This calls the ULP release function which will
+	 * also remove the mptcp socket, via
+	 * sock_put(ctx->conn).
+	 *
+	 * Problem is that the mptcp socket will not be in
+	 * SYN_RECV state and doesn't have SOCK_DEAD flag.
+	 * Both result in warnings from inet_sock_destruct.
+	 */
+
+	if (sk->sk_state =3D=3D TCP_SYN_RECV) {
+		sk->sk_state =3D TCP_CLOSE;
+		WARN_ON_ONCE(sk->sk_socket);
+		sock_orphan(sk);
+	}
+
+	inet_sock_destruct(sk);
+}
+
 static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 					  struct sk_buff *skb,
 					  struct request_sock *req,
@@ -422,7 +445,7 @@ static struct sock *subflow_syn_recv_sock(const struct =
sock *sk,
 			/* new mpc subflow takes ownership of the newly
 			 * created mptcp socket
 			 */
-			inet_sk_state_store(new_msk, TCP_ESTABLISHED);
+			new_msk->sk_destruct =3D mptcp_sock_destruct;
 			mptcp_pm_new_connection(mptcp_sk(new_msk), 1);
 			ctx->conn =3D new_msk;
 			new_msk =3D NULL;
-- =

2.24.1

--===============1646868111629380748==--
