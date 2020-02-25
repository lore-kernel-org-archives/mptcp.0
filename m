Content-Type: multipart/mixed; boundary="===============3380564148346505730=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [PATCH net-next v2 2/7] mptcp: add work queue skeleton
Date: Tue, 25 Feb 2020 18:16:54 +0100
Message-ID: <20200225171659.4807-3-fw@strlen.de>
In-Reply-To: 20200225171659.4807-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 3794

--===============3380564148346505730==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Paolo Abeni <pabeni(a)redhat.com>

Will be extended with functionality in followup patches.
Initial user is moving skbs from subflows receive queue to
the mptcp-level receive queue.

Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 22 ++++++++++++++++++++++
 net/mptcp/protocol.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 1d55563e9aca..cbf184a71ed7 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -551,12 +551,24 @@ static void __mptcp_close_ssk(struct sock *sk, struct=
 sock *ssk,
 	}
 }
 =

+static void mptcp_worker(struct work_struct *work)
+{
+	struct mptcp_sock *msk =3D container_of(work, struct mptcp_sock, work);
+	struct sock *sk =3D &msk->sk.icsk_inet.sk;
+
+	lock_sock(sk);
+
+	release_sock(sk);
+	sock_put(sk);
+}
+
 static int __mptcp_init_sock(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
 =

 	INIT_LIST_HEAD(&msk->conn_list);
 	__set_bit(MPTCP_SEND_SPACE, &msk->flags);
+	INIT_WORK(&msk->work, mptcp_worker);
 =

 	msk->first =3D NULL;
 =

@@ -571,6 +583,14 @@ static int mptcp_init_sock(struct sock *sk)
 	return __mptcp_init_sock(sk);
 }
 =

+static void mptcp_cancel_work(struct sock *sk)
+{
+	struct mptcp_sock *msk =3D mptcp_sk(sk);
+
+	if (cancel_work_sync(&msk->work))
+		sock_put(sk);
+}
+
 static void mptcp_subflow_shutdown(struct sock *ssk, int how)
 {
 	lock_sock(ssk);
@@ -616,6 +636,8 @@ static void mptcp_close(struct sock *sk, long timeout)
 		__mptcp_close_ssk(sk, ssk, subflow, timeout);
 	}
 =

+	mptcp_cancel_work(sk);
+
 	sk_common_release(sk);
 }
 =

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 67895a7c1e5b..6e6e162d25f1 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -70,6 +70,7 @@ struct mptcp_sock {
 	u32		token;
 	unsigned long	flags;
 	bool		can_ack;
+	struct work_struct work;
 	struct list_head conn_list;
 	struct skb_ext	*cached_ext;	/* for the next sendmsg */
 	struct socket	*subflow; /* outgoing connect/listener/!mp_capable */
-- =

2.24.1

--===============3380564148346505730==--
