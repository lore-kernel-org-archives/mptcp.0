Content-Type: multipart/mixed; boundary="===============8609594667257419061=="
MIME-Version: 1.0
From: Paolo Abeni <pabeni at redhat.com>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH] Squash-to: "net: mptcp: improve fallback to TCP"
Date: Fri, 26 Jun 2020 13:27:34 +0200
Message-ID: <95262bb3dfcddcfe670fef5af0290b429df67e35.1593170557.git.pabeni@redhat.com>
X-Status: 
X-Keywords:                  
X-UID: 4817

--===============8609594667257419061==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This fixes blocking accept() never waking-up.

When blocking, mptcp_stream_accept() calls into:
ssock->ops->acceptk -> ssock->sk->sk_prot->accept ->
inet_csk_accept() -> inet_csk_wait_for_connect(),

which in turns waits on ssock->sk->sk_wq, while
all signaling how happens on sock->sk->sk_wq.

Since we ssock->sk->sk_wq is never used otherwise,
just copy sock->sk->sk_wq into it at first subflow
creatin time.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
---
 net/mptcp/protocol.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 4d6d35e99d0f..5ae8952189d2 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -128,6 +128,10 @@ static struct socket *__mptcp_socket_create(struct mpt=
cp_sock *msk, int state)
 	list_add(&subflow->node, &msk->conn_list);
 	subflow->request_mptcp =3D 1;
 =

+	/* accept() will wait on first subflow sk_wq, and we always wakes up
+	 * via msk->sk_socket */
+	RCU_INIT_POINTER(msk->first->sk_wq, &sk->sk_socket->wq);
+
 set_state:
 	if (state !=3D MPTCP_SAME_STATE)
 		inet_sk_state_store(sk, state);
-- =

2.26.2

--===============8609594667257419061==--
