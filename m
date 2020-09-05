Content-Type: multipart/mixed; boundary="===============4541038630457768291=="
MIME-Version: 1.0
From: Florian Westphal <fw at strlen.de>
To: mptcp at lists.01.org
Subject: [MPTCP] [RFC mptcp-next 3/3] mptcp: try to clean data inplace if
 possible
Date: Sat, 05 Sep 2020 12:33:24 +0200
Message-ID: <20200905103324.27066-4-fw@strlen.de>
In-Reply-To: 20200905103324.27066-1-fw@strlen.de
X-Status: 
X-Keywords:                  
X-UID: 5730

--===============4541038630457768291==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In most cases the worker won't be scheduled because socket
has enough space and is established.

If the mptcp retransmit queue needs to cleaned up its possible to try to
acquire the mptcp socket lock anyway.  This allows to avoid the work
queue unless the socket is currently owned.

Signed-off-by: Florian Westphal <fw(a)strlen.de>
---
 net/mptcp/protocol.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bc5231d5b06d..d43f7e7125a1 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -41,6 +41,8 @@ struct mptcp_skb_cb {
 =

 static struct percpu_counter mptcp_sockets_allocated;
 =

+static void mptcp_clean_una(struct sock *sk);
+
 /* If msk has an initial subflow socket, and the MP_CAPABLE handshake has =
not
  * completed yet or has failed, return the subflow socket.
  * Otherwise return NULL.
@@ -681,13 +683,30 @@ static void mptcp_reset_timer(struct sock *sk)
 void mptcp_data_acked(struct sock *sk)
 {
 	struct mptcp_sock *msk =3D mptcp_sk(sk);
+	bool fast =3D false;
 =

 	mptcp_reset_timer(sk);
 =

 	if ((test_bit(MPTCP_NOSPACE, &msk->flags) ||
-	    (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED)) &&
-	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+	    (inet_sk_state_load(sk) !=3D TCP_ESTABLISHED))) {
+		if (READ_ONCE(sk->sk_lock.owned))
+			goto slowpath;
+
+		if (unlikely(!spin_trylock_bh(&sk->sk_lock.slock)))
+			goto slowpath;
+
+		if (!READ_ONCE(sk->sk_lock.owned)) {
+			mptcp_clean_una(sk);
+			fast =3D true;
+		}
+
+		spin_unlock_bh(&sk->sk_lock.slock);
+		if (fast)
+			return;
+	slowpath:
+		if (schedule_work(&mptcp_sk(sk)->work))
+			sock_hold(sk);
+	}
 }
 =

 void mptcp_subflow_eof(struct sock *sk)
-- =

2.26.2

--===============4541038630457768291==--
